import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/model/VerifyOtp.dart';
import 'package:bigul_ekyc/screen/email_mobile/EmailVerificationScreen.dart';
import 'package:bigul_ekyc/screen/pan/PanVerificationScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EmailVerificationOtpController extends GetxController {
  String number = "";
  String email = "";
  final DioClient dioClient;

  EmailVerificationOtpController({required this.number,required this.email, required this.dioClient});

  CountdownTimerController? countDownController;
  RxInt endTime = (DateTime.now().millisecondsSinceEpoch + 1000 * 60).obs;
  RxBool isResendActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    initCounterCountroller();
  }


  @override
  void dispose() {
    countDownController?.dispose();
    super.dispose();
  }

  void initCounterCountroller() {
    endTime.value = (DateTime.now().millisecondsSinceEpoch + 1000 * 60);
    isResendActive.value = false;
     countDownController = CountdownTimerController(endTime: endTime.value,onEnd: (){
      isResendActive.value = true;
    });
  }



  RxString verificationCode = "".obs;

  Future<void> onResendOtp(BuildContext context) async {
    EventKeys.resendEmailOtpSent(number.removeAllWhitespace);
    FocusScope.of(context).unfocus();
    DialogUtils.showDialog(context);
    await dioClient.resendOTP(number.removeAllWhitespace, email, "email").then((value) {
      DialogUtils.hideProgress(context);
      if (value.status == 200) {
        isResendActive.value = false;
        initCounterCountroller();
        countDownController?.start();
      }
    }).onError((error, stackTrace) {
      DialogUtils.hideProgress(context);
    });
  }

  Future<void> onSumitOtp(BuildContext context) async {
    EventKeys.verifyEmailAddress(number.removeAllWhitespace);

    FocusScope.of(context).unfocus();
    DialogUtils.showDialog(context);
    await dioClient.verifyEmailOtp(number.removeAllWhitespace,email,verificationCode.value ).then((value) {
      DialogUtils.hideProgress(context);
      if (value.status == 200) {
        EventKeys.emailVerified(number.removeAllWhitespace);
        GetStorage().write('USEREMAIL', email.trim());
        Get.off(() => const PanVerificationScreen(),
            binding: PanVerificationScreenBinding(number:UserData.fromJson(GetStorage().read("USERDATA")).mobile! ),
            transition: Transition.rightToLeft);
      }else{
        Fluttertoast.showToast(msg: value.msg!);
      }
    }).onError((error, stackTrace) {
      DialogUtils.hideProgress(context);
    });
  }

  void gotoEmail() {
    Get.off(() => const EmailVerificationScreen(),
        binding: EmailVerificationScreenBindings(number: number),
        transition: Transition.rightToLeft);
  }
}
