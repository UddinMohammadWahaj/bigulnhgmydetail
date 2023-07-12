import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/dialogs/DialogManager.dart';
import 'package:bigul_ekyc/screen/email_mobile/EmailVerificationOtpScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  String number = "";
  final DioClient dioClient;

  EmailVerificationController({required this.number, required this.dioClient});

  RxString errorString = "".obs;
  TextEditingController emailController = TextEditingController();



  Future<void> onSendLinkClick(BuildContext context) async {
    EventKeys.sendOtp(number.removeAllWhitespace);

    FocusScope.of(context).unfocus();
    DialogUtils.showDialog(context);
    await dioClient.sendEmailVerificationLink(number.removeAllWhitespace, emailController.text).then((value) {
      DialogUtils.hideProgress(context);
      if (value.status == 200) {
        EventKeys.emailOtpSent(number.removeAllWhitespace);
        DialogManager.showEmailLinkDialog(context).then((value) {
          if (value == true) {
            Get.off(() => const EmailVerificationOtpScreen(),
                    binding: EmailVerificationOtpScreenBindings(number:number,email : emailController.text ),
                    transition: Transition.rightToLeft);
          }
        });
      }
    }).onError((error, stackTrace) {
      DialogUtils.hideProgress(context);
    });

  }

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(() {
      EmailValidator.validate(emailController.text)?
          EventKeys.enterEmailAddress(number.removeAllWhitespace,emailController.text)
          : null
      ;
    });
  }
}
