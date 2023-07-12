import 'dart:convert';

import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/KraClient.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/dialogs/DialogManager.dart';
import 'package:bigul_ekyc/model/GetPanStatusResponse.dart';
import 'package:bigul_ekyc/model/KraVerifiedCode.dart';
import 'package:bigul_ekyc/screen/email_mobile/IntroScreen.dart';
import 'package:bigul_ekyc/screen/pan/PanConfirmationScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:xml2json/xml2json.dart';

class PanVerificationController extends GetxController {
  String number = "";
  final KraClient kraClient;
  final DioClient dioClient;
  TextEditingController selectedDOB = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  var dobFormatter = MaskTextInputFormatter(mask: "##/##/####");
  var panFormatter = MaskTextInputFormatter(mask: "AAAAA####A");

  PanVerificationController({
    required this.number,
    required this.kraClient,
    required this.dioClient,
  });

  @override
  void onInit() {
    super.onInit();
    panNumberController.addListener(() {
      if(isValidPanCardNo(panNumberController.text)){
        EventKeys.enterPan(number.removeAllWhitespace,panNumberController.text);
      }
    });

    selectedDOB.addListener(() {
      if(isDobValid(selectedDOB.text)){
        EventKeys.enterDOB(number.removeAllWhitespace);
      }
    });
  }





  bool isValidPanCardNo(String value) {
    return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value);
  }





  Future<void> goToPanConfirmationScreen(BuildContext context) async {
    EventKeys.verifyPan(number.removeAllWhitespace);

    FocusScope.of(context).unfocus();
    bool isKraNotVerified = false;
    String originalDate = selectedDOB.text;
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateTime dateTime = inputFormat.parse(originalDate);
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = outputFormat.format(dateTime);

    DialogUtils.showDialog(context);
    await dioClient
        .panVerification(number.removeAllWhitespace, panNumberController.text, formattedDate)
        .then((panresponse)  {
      if (panresponse.status == 200) {
        // GetStorage().write("USERDATA", panresponse.userData?.toJson());

        if (panresponse.userData!.seeding == "Y") {
           kraClient.GetPanStatus(panNumberController.text)
              .then((value) async {
            await DialogUtils.hideProgress(context);
            Xml2Json xml2json = Xml2Json();
            xml2json.parse(value.toString());
            var json = xml2json
                .toParker(); // the only method that worked for my XML type.
            var response = jsonDecode(json);

            GetPanStatusResponse getPanStatusResponse =
                GetPanStatusResponse.fromJson(response);

            GetStorage().write("KRA_VERIFIED",false);

            for (var element in KraVerifiedCode.kraVerifiedCodes) {
              if (element.code == getPanStatusResponse.appResRoot.appPanInq.appStatus) {
                isKraNotVerified = true;
                GetStorage().write("KRA_VERIFIED",true);
                String? username = getPanStatusResponse.appResRoot.appPanInq.appName;
                Get.off(() => const PanConfirmationScreen(),
                    binding: PanConfirmationScreenBinding(
                        panNumber: panNumberController.text,
                        dob: formattedDate,
                        username: username!,
                        kraVerifiedCode: element,
                    isKraVerified: true),
                    transition: Transition.rightToLeft);
              }
            }
            if(!isKraNotVerified){

              // Fluttertoast.showToast(msg: "KRA not verified\nAccess to Digio");
              String? username = "${panresponse.userData!.firstName} ${panresponse.userData!.middleName} ${panresponse.userData!.lastName}";
              Get.off(() => const PanConfirmationScreen(),
                  binding: PanConfirmationScreenBinding(
                      panNumber: panNumberController.text,
                      dob: formattedDate,
                      username: username ,
                      kraVerifiedCode: null,
                      isKraVerified: false),
                  transition: Transition.rightToLeft);


            }

          }).onError((error, stackTrace) {
            DialogUtils.hideProgress(context);
          });
        }
        else{
          //seeding N
          DialogUtils.hideProgress(context);
          DialogManager.showSeedingNDialog(context).then((value) {
            if (value == true) {
              DialogManager.hideDialog();
            }
          });
        }
      }
      else if(panresponse.status == 201){
        DialogUtils.hideProgress(context);
        Fluttertoast.showToast(msg: panresponse.msg!);
        // Get.off(()=>const IntroScreen(),binding: IntroScreenBindings());
      }
      else{
        DialogUtils.hideProgress(context);
        Fluttertoast.showToast(msg: panresponse.msg!);
        Get.offAll(()=>const IntroScreen(),binding: IntroScreenBindings());
      }
    }
    ).onError((error, stackTrace){
      Fluttertoast.showToast(msg: "Something wrong");
      DialogUtils.hideProgress(context);
    }
    );

  }

  bool isDobValid(String value) {
    if (value.isEmpty) {
      return false;
    }
    final components = value.split("/");
    if (components.length == 3) {
      final day = int.tryParse(components[0]);
      final month = int.tryParse(components[1]);
      final year = int.tryParse(components[2]);
      if (day != null && month != null && year != null) {



        if (month < 1 || month > 12) {
          return false;
        }

        if (day < 1 ||
            day > DateUtils.getDaysInMonth(year, month)) {
          return false;
        }

        if(year.toString().length!=4){
          return false;

        }
        final date = DateTime(year, month, day);
        DateTime now = DateTime.now();
        int age = now.year - date.year;
        if (now.month < date.month ||
            (now.month == date.month && now.day < date.day)) {
          age--;
        }
        if (age <= 18){
          return false;
        }


        if (date.year == year && date.month == month && date.day == day) {
          return true;
        }
      }

    }
    return false;
  }

  RxBool isValidForm() {
    if (isValidPanCardNo(panNumberController.text) &&
        isDobValid(selectedDOB.text)) {
      return true.obs;
    }
    return false.obs;
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}