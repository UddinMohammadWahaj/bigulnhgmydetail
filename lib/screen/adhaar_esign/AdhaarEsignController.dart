import 'dart:async';

import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/EsignClient.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/model/VerifyOtp.dart';
import 'package:bigul_ekyc/screen/congratulations/CongratulationsScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class AdhaarEsignController extends GetxController {
  DioClient dioClient;
  EsignClient esignClient;
  String mobile;
  bool callBefore;
  String  pan;

  AdhaarEsignController({required this.dioClient, required this.esignClient,required this.mobile,required this.callBefore,required this.pan});


  @override
  void onInit() {
    super.onInit();


  }
  void goToCongratulations() {
    Get.off(() => const CongratulationsScreen(),
        binding: CongratulationsScreenBindings(mobile: UserData.fromJson(GetStorage().read("USERDATA")).mobile!),
        transition: Transition.rightToLeft);
  }

  Future<void> beforeEsign() async {

    await dioClient.beforeEsign(mobile).then((value) async {
      if (value.status == 200) {
      }
    }).onError((error, stackTrace) {

    });
  }

  Future<void> afterEsign(BuildContext context) async {
    FocusScope.of(context).unfocus();
    DialogUtils.showDialog(context);
    await dioClient.afterEsign(mobile).then((value) {
      DialogUtils.hideProgress(context);
      if (value.status == 200) {
        GetStorage().write("USERDATA", value.userData?.toJson());
        goToCongratulations();
      }
    }).onError((error, stackTrace) {
      DialogUtils.hideProgress(context);
    });
  }


  Timer? _timer;
  Future<void> initSign(BuildContext context, String url, String clientId) async {

    if (!await launchUrl(Uri.parse(url) , mode: LaunchMode.externalApplication,)) {
      throw Exception('Could not launch url');
    }

    const duration = Duration(seconds: 3);
    _timer = Timer.periodic(duration, (Timer timer) async {
      await esignClient
          .getDetailsDid(clientId)
          .then((value) {

            if(value.message=="ESign Already Done."){
              _timer?.cancel();
              _timer=null;
              goToCongratulations();
            }
      });
    });



    // Object esignResult;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    // try {
    //   var digioConfig = DigioConfig();
    //   digioConfig.environment = Environment.PRODUCTION;
    //   final esignPlugin = EsignPlugin(digioConfig);
    //
    //   esignResult = await esignPlugin.start(did, mail, "", null);
    //   print('esignResult : $esignResult');
    //   DigioResponse response = esignResult as DigioResponse ;
    //   print(response.documentId);
    //   if (response.message == "Signed Successfully") {
    //     await afterEsign(context);
    //   }
    // } on PlatformException {
    //   esignResult = 'Failed to get platform version.';
    // }
  }

  Future<void> onPress(BuildContext context) async {
    EventKeys.adhaarEsign( UserData.fromJson(GetStorage().read("USERDATA")).mobile!??"");
    await esignClient
        .getDetails(pan)
        .then((getDetailResponse) async {
      if (getDetailResponse.success!) {
        await esignClient
            .getDetailsDid(getDetailResponse.data![0]["ClientId"]!)
            .then((getDIDvalue)  async {
          DialogUtils.hideProgress(context);
          if(getDIDvalue.success!){
            // RegExp exp = RegExp(r"DID\d{15}[A-Z0-9]{14}");
            // Match match = exp.firstMatch(getDIDvalue.data!.urll!) as Match;
            // String? result = match.group(0);

            await initSign(
                context, getDIDvalue.data!.urll!,getDetailResponse.data![0]["ClientId"]!);
          }else{
            if(getDIDvalue.message=="ESign Already Done."){
              Fluttertoast.showToast(msg: getDIDvalue.message!);
              goToCongratulations();
            }
          }
        });
      } else {
        DialogUtils.hideProgress(context);
        Fluttertoast.showToast(msg: getDetailResponse.message!);
      }
    });
  }
}
