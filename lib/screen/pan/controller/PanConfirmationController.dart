import 'dart:convert';

import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/KraClient.dart';
import 'package:bigul_ekyc/dialogs/DialogManager.dart';
import 'package:bigul_ekyc/model/GetPanDetailResponse.dart';
import 'package:bigul_ekyc/model/KraVerifiedCode.dart';
import 'package:bigul_ekyc/model/VerifyOtp.dart';
import 'package:bigul_ekyc/screen/bank/EnterBankScreen.dart';
import 'package:bigul_ekyc/screen/pan/DigioFirstScreen.dart';
import 'package:bigul_ekyc/screen/pan/PanVerificationScreen.dart';
import 'package:bigul_ekyc/screen/personal/PersonalDetailsScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:xml2json/xml2json.dart';

class PanConfirmationController extends GetxController {
  String panNumber = "";
  String dob = "";
  String username = "";
  KraVerifiedCode? kraVerifiedCode;
  final KraClient kraClient;
  final bool isKraVerified;

  PanConfirmationController({
    required this.panNumber,
    required this.dob,
    required this.username,
    required this.kraClient,
    required this.kraVerifiedCode,
    required this.isKraVerified,
  });

  Future<void> onConfirmClick(BuildContext context) async {
    EventKeys.confirmItsYou( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

    if(isKraVerified) {
      String originalDate = dob;
      DateFormat inputFormat = DateFormat('yyyy-MM-dd');
      DateTime dateTime = inputFormat.parse(originalDate);
      DateFormat outputFormat = DateFormat('dd-MM-yyyy');
      String formattedDate = outputFormat.format(dateTime);

      DialogUtils.showDialog(context);
      var value =
      await kraClient.GetPanDetails(panNumber, formattedDate, kraVerifiedCode!)
          .then((value) async {
        await DialogUtils.hideProgress(context);
        Xml2Json xml2json = Xml2Json();
        xml2json.parse(value.toString());
        var json =
        xml2json.toParker(); // the only method that worked for my XML type.
        print(json);
        var response = jsonDecode(json);


        GetPanDetailResponse detailResponse =
        GetPanDetailResponse.fromJson(response);
        GetStorage().write("KRA",detailResponse.toJson());

        GetStorage().write('USERNAME', username);

        EventKeys.fetcKRA( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

        if (detailResponse.root.kycData?.appErrorDesc == null || detailResponse.root.kycData?.appErrorDesc == "ERR-00000") {
          DialogManager.showDocumentFetchedDialog(context).then((value) {
            if (value == true) {
              Get.off(() => const PersonalDetailsScreen(),
                  binding: PersonalDetailsScreenBinding(
                    isKraVerified: isKraVerified,
                    digioResponse: null,
                      detailResponse: detailResponse),
                  transition: Transition.rightToLeft);
            }
          });
        } else {
          if(detailResponse.root.kycData?.appErrorCode== "WEBERR-012") {
            Fluttertoast.showToast(
                msg: "Please enter correct date of birth");
          }else{
            Fluttertoast.showToast(
                msg: "${detailResponse.root.kycData?.appErrorDesc}");
          }

          Get.off(() => const PanVerificationScreen(),
              binding: PanVerificationScreenBinding(
                  number: UserData.fromJson(GetStorage().read("USERDATA")).mobile!),
              transition: Transition.rightToLeft);
        }
      }).onError((error, stackTrace) {
        DialogUtils.hideProgress(context);
      });
    }else{
      EventKeys.digilockerAccess( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

      Get.off(() => const DigioFirstScreen(),
          binding: DigioScreenBinding(
              mobile: UserData.fromJson(GetStorage().read("USERDATA")).mobile!,
              customer_name: username,
              customer_email: GetStorage().read("USEREMAIL"),),
          transition: Transition.rightToLeft);
    }


  }

  renterPanDetails() {
    EventKeys.renterPanDetails( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

    Get.off(() => const PanVerificationScreen(),
        binding: PanVerificationScreenBinding(
            number:
            UserData.fromJson(GetStorage().read("USERDATA")).mobile!),
        transition: Transition.rightToLeft);

  }


}
