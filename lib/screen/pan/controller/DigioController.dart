import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/DigioClient.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/dialogs/DialogManager.dart';
import 'package:bigul_ekyc/model/VerifyOtp.dart';
import 'package:bigul_ekyc/screen/personal/PersonalDetailsScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kyc_workflow/digio_config.dart';
import 'package:kyc_workflow/environment.dart';
import 'package:kyc_workflow/kyc_workflow.dart';
import 'package:kyc_workflow/workflow_response.dart';
import 'package:permission_handler/permission_handler.dart';

class DigioController extends GetxController {
  DigioClient digioClient;
  DioClient dioClient;
  String customer_email;
  String customer_name;
  String mobile;

  DigioController(
      {required this.digioClient,
      required this.dioClient,
      required this.customer_email,
      required this.customer_name,
      required this.mobile
      });


  Future<void> fetchDigio(BuildContext context) async {
    // EventKeys.allowAccess( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);
    var status = await Permission.location.request();
    var locationWhenInUse = await Permission.locationWhenInUse.request();
    var statusCamera = await Permission.camera.request();

    if (status.isGranted &&
        locationWhenInUse.isGranted &&
        statusCamera.isGranted) {
      DialogUtils.showDialog(context);
      return await digioClient
          .getDigioData(customer_email, customer_name)
          .then((value) async {
        DialogUtils.hideProgress(context);
        Object workflowResult;
        try {
          var digioConfig = DigioConfig();
          digioConfig.environment = Environment.PRODUCTION;

          final kycWorkflowPlugin = KycWorkflow(digioConfig);
          workflowResult = await kycWorkflowPlugin.start(
              value.accessToken!.entityId!,
              customer_email,
              value.accessToken!.id!,
              null);
          print('workflowResult : $workflowResult');

          WorkflowResponse response = workflowResult as WorkflowResponse;
          print(response.documentId);
          if (response.message == "Success") {
            DialogUtils.showDialog(context);
            await digioClient
                .getDigioDataResponse(response.documentId!)
                .then((digioResponseData) async {
              if (UserData.fromJson(GetStorage().read("USERDATA"))
                      .pan!
                      .toUpperCase() ==
                  digioResponseData!.actions![0].details?.pan?.idNumber
                      ?.toUpperCase())
              {

                EventKeys.fetcDigilocker( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

                await dioClient
                    .saveDigilockerData(
                        mobile,
                        digioResponseData.referenceId,
                        digioResponseData.actions?[0].id!,
                        digioResponseData.actions?[0].executionRequestId,
                        digioResponseData)
                    .then((value) {
                  DialogUtils.hideProgress(context);
                  GetStorage().write("USERDATA", value.userData?.toJson());

                  GetStorage().write("DIGIO", digioResponseData.toJson());

                  DialogManager.showDigiDocumentFetchedDialog(context)
                      .then((value) {
                    Get.off(() => const PersonalDetailsScreen(),
                        binding: PersonalDetailsScreenBinding(
                          detailResponse: null,
                            digioResponse: digioResponseData,
                        isKraVerified: false),
                        transition: Transition.rightToLeft);
                  });
                }).onError((error, stackTrace) {
                  DialogUtils.hideProgress(context);
                });
              }
              else {
                DialogUtils.hideProgress(context);
                Fluttertoast.showToast(
                    msg:
                        'You are using Adhaar number which is not linked with you pan');
              }
            }).onError((error, stackTrace) {
              DialogUtils.hideProgress(context);
            });
          }
        } on PlatformException {
          workflowResult = 'Failed to get platform version.';
          Fluttertoast.showToast(
              msg: 'Digio Error: Failed to get platform version.');
        }

      }).onError((error, stackTrace) {
        DialogUtils.hideProgress(context);
        Fluttertoast.showToast(msg: "Something went wrong");
      });
    } else {
      Fluttertoast.showToast(msg: "Permission errors");
    }
  }
}
