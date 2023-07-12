import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/screen/email_mobile/VerificationOtpScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MobileRegistrationController extends GetxController {
  String email;
  DioClient dioClient;

  MobileRegistrationController({required this.dioClient,required this.email});

  RxBool isValidMobile = true.obs;
  TextEditingController numberController = TextEditingController();
  var phoneFormatter = MaskTextInputFormatter(mask: "##### #####");

  bool startsWithZeroToFive(String input) {
    RegExp regex = RegExp(r'^[0-5]');
    return regex.hasMatch(input);
  }

  bool onPhoneValidation(String? value) {
    isValidMobile.value = false;
    if (value!.isEmpty) {
      return false;
    } else if (value.length != 10) {
      return false;
    } else if (startsWithZeroToFive(value)) {
      return false;
    } else {
      EventKeys.enterMobileNumber(value);
      isValidMobile.value = true;
      return true;
    }
  }

  Future<void> onGetOtpClick(BuildContext context) async {
    EventKeys.getOtp(numberController.text.removeAllWhitespace);

    FocusScope.of(context).unfocus();
    if(onPhoneValidation(numberController.text.removeAllWhitespace)){
      DialogUtils.showDialog(context);
      await dioClient.login(numberController.text.removeAllWhitespace).then((value) {
        DialogUtils.hideProgress(context);
        if (value.status == 200) {
          Get.off(() => const VerificationOtpScreen(),
              binding: VerificationOtpScreenBindings(number: numberController.text,email:email),
              transition: Transition.rightToLeft);
        }
      }).onError((error, stackTrace) {
        DialogUtils.hideProgress(context).then((value) {
        });
      });
    }
  }
}
