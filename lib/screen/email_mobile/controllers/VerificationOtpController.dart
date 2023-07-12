import 'dart:io';

import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/dialogs/DialogManager.dart';
import 'package:bigul_ekyc/model/DigioResponse.dart';
import 'package:bigul_ekyc/model/GetPanDetailResponse.dart';
import 'package:bigul_ekyc/model/VerifyOtp.dart';
import 'package:bigul_ekyc/screen/adhaar_esign/AdharEsignScreen.dart';
import 'package:bigul_ekyc/screen/bank/EnterBankScreen.dart';
import 'package:bigul_ekyc/screen/bank_proof/BankProofScreen.dart';
import 'package:bigul_ekyc/screen/congratulations/CongratulationsScreen.dart';
import 'package:bigul_ekyc/screen/email_mobile/EmailVerificationScreen.dart';
import 'package:bigul_ekyc/screen/email_mobile/IntroScreen.dart';
import 'package:bigul_ekyc/screen/email_mobile/SplashScreen.dart';
import 'package:bigul_ekyc/screen/investment/InvestementDetailsScreen.dart';
import 'package:bigul_ekyc/screen/pan/PanVerificationScreen.dart';
import 'package:bigul_ekyc/screen/personal/OccupationlDetailsScreen.dart';
import 'package:bigul_ekyc/screen/personal/PersonalDetailsScreen.dart';
import 'package:bigul_ekyc/screen/segment/SegmentDetailsScreen.dart';
import 'package:bigul_ekyc/screen/selfie/SelfieScreen.dart';
import 'package:bigul_ekyc/screen/signature/SignatureScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:telephony/telephony.dart';

class VerificationOtpController extends GetxController {
  String number = "";
  String? email;
  final DioClient dioClient;

  RxList<TextEditingController?> controls = <TextEditingController>[].obs;

  late BuildContext context;

  VerificationOtpController({required this.number,required this.email, required this.dioClient});

  CountdownTimerController? countDownController;
  RxInt endTime = (DateTime.now().millisecondsSinceEpoch + 1000 * 60).obs;
  RxBool isResendActive = false.obs;

  Telephony telephony = Telephony.instance;

  // RxList<TextEditingController> otpbox = <TextEditingController>[].obs;

  @override
  void onInit() {
    super.onInit();
    initCounterCountroller();

    if (kIsWeb) {
    } else if (Platform.isAndroid) {
      telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          print(message.toString());
          print(message.address); //+977981******67, sender nubmer
          print(message.body); //Your OTP code is 34567
          print(message.date); //1659690242000, timestamp

          String sms = message.body.toString(); //get the message

          if (message.address == "AX-BBIGUL") {
            //verify SMS is sent for OTP with sender number
            String otpcode = sms.replaceAll(RegExp(r'[^0-9]'), '');
            //prase code from the OTP sms
            verificationCode.value = otpcode.trim().substring(0, 6);
            int count = 0;
            // otpbox.value.forEach((element) {
            //
            //   count++;
            // });

            controls.forEach((element) {
              controls[count]!.text =
                  verificationCode.value.characters.elementAt(count);
            });
            notifyChildrens();
            controls.refresh();
            print(verificationCode);
            onSumitOtp(context);

            //split otp code to list of number
            //and populate to otb boxes
          } else {
            print("Normal message.");
          }
        },
        listenInBackground: false,
      );
    }
  }

  @override
  void dispose() {
    countDownController?.dispose();
    super.dispose();
  }


  void initCounterCountroller() {
    endTime.value = (DateTime.now().millisecondsSinceEpoch + 1000 * 60);
    isResendActive.value = false;
    countDownController = CountdownTimerController(
        endTime: endTime.value,
        onEnd: () {
          isResendActive.value = true;
        });
  }

  void goToEmailVerification(BuildContext context) {
    DialogManager.showMobileVerifiedDialog(context).then((value) {
      if (value == true) {
        Get.off(() => const EmailVerificationScreen(),
            binding: EmailVerificationScreenBindings(number: number),
            transition: Transition.rightToLeft);
      }
    });
  }

  RxString verificationCode = "".obs;

  Future<void> onResendOtp(BuildContext context) async {
    EventKeys.resendOtp(number.removeAllWhitespace);
    controls.clear();

    FocusScope.of(context).unfocus();
    DialogUtils.showDialog(context);
    await dioClient.resendOTP(number.removeAllWhitespace, "null", "mobile").then((value) {
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
    EventKeys.verifyMobileNumber(number.removeAllWhitespace );

    FocusScope.of(context).unfocus();
    DialogUtils.showDialog(context);
    await dioClient.verifyOtp(number.removeAllWhitespace,email??"",verificationCode.value ).then((value) {
      DialogUtils.hideProgress(context);

      if (value.msg == "OTP Verified successfully") {
        EventKeys.mobileVerified(number.removeAllWhitespace);
        EventKeys.userId(number.removeAllWhitespace);
        GetStorage().write("MOBILE", number.removeAllWhitespace);
        GetStorage().write("USERDATA", value.userData?.toJson());
        GetStorage().write("USEREMAIL",value.userData?.email??"");

        if (value.userData!.emailVerify == 0) {
          goToEmailVerification(context);
        }
        else if (value.userData!.stage == 1) {
          //Pan verification

          Get.off(() => const PanVerificationScreen(),
              binding: PanVerificationScreenBinding(
                  number:
                      UserData.fromJson(GetStorage().read("USERDATA")).mobile!),
              transition: Transition.rightToLeft);
        } else if (value.userData!.stage == 2) {
          //Pan Confirmation
          Get.off(() => const PanVerificationScreen(),
              binding: PanVerificationScreenBinding(
                  number:
                      UserData.fromJson(GetStorage().read("USERDATA")).mobile!),
              transition: Transition.rightToLeft);
        } else if (value.userData!.stage == 3) {
          // if digio then personal detail,
          // UserData.fromJson(GetStorage().read("USERDATA")).jsonData==null?
          // //is kra
          // Get.off(() => const OccupationDetailsScreen(),
          //     binding: OccupationDetailsScreenBinding(
          //         isKraVerified: true,
          //         mobile:
          //         UserData.fromJson(GetStorage().read("USERDATA")).mobile!))
          //     :
          // //is digio
          Get.off(() => const PersonalDetailsScreen(),
              binding: PersonalDetailsScreenBinding(
                  isKraVerified: UserData.fromJson(GetStorage().read("USERDATA")).jsonData==null?true:false,
                  detailResponse: GetStorage().read("KRA")!=null?GetPanDetailResponse.fromJson(GetStorage().read("KRA")):null,
                  digioResponse:GetStorage().read("DIGIO")!=null? DigioResponse.fromJson(GetStorage().read("DIGIO")):null)
                 ,
              transition: Transition.rightToLeft);

          ;

        } else if (value.userData!.stage == 4) {
          //Save Occupation

          Get.off(() => const OccupationDetailsScreen(),
              binding: OccupationDetailsScreenBinding(
                  isKraVerified:  UserData.fromJson(GetStorage().read("USERDATA")).jsonData==null?true:false,
                  mobile: UserData.fromJson(GetStorage().read("USERDATA")).mobile!,
                  detailResponse: GetStorage().read("KRA")!=null?GetPanDetailResponse.fromJson(GetStorage().read("KRA")):null,
                  digioResponse: GetStorage().read("DIGIO")!=null? DigioResponse.fromJson(GetStorage().read("DIGIO")):null
              ),
              transition: Transition.rightToLeft);
        } else if (value.userData!.stage == 5) {
          //Save Bank
          EventKeys.proceedBankVerification( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);
          Get.off(() => const EnterBankScreen(),
              binding: EnterBankScreenBinding(),
              transition: Transition.rightToLeft);
        } else if (value.userData!.stage == 6) {
          //segment
          Get.off(() => const SegmentDetailsScreen(),
              binding: SegmentDetailsScreenBinding(
                  mobile:
                      UserData.fromJson(GetStorage().read("USERDATA")).mobile!),
              transition: Transition.rightToLeft);
        } else if (value.userData!.stage == 7) {
          //income proof

          Get.off(() => const InvestmentDetailsScreen(),
              binding: InvestmentDetailsScreenBinding(),
              transition: Transition.rightToLeft);

        } else if (value.userData!.stage == 8) {
          //selfie
          Get.off(() => const SelfieScreen(),
              binding: SelfieScreenBinding(),
              transition: Transition.rightToLeft);

        } else if (value.userData!.stage == 9) {
          //signature

          Get.off(() => const SignatureScreen(),
              binding: SignatureScreenBindings(), transition: Transition.rightToLeft);


        } else if (value.userData!.stage == 10) {
          //adhar
          Get.off(() => const AdhaarEsignScreen(),
              binding: AdhaarEsignScreenBindings(mobile:UserData.fromJson(GetStorage().read("USERDATA")).mobile!,callBefore:true,pan: UserData.fromJson(GetStorage().read("USERDATA")).pan!),
              transition: Transition.rightToLeft);
        } else if (value.userData!.stage == 11) {
          //adhar esign
          Get.off(() => const AdhaarEsignScreen(),
              binding: AdhaarEsignScreenBindings(mobile:UserData.fromJson(GetStorage().read("USERDATA")).mobile!,callBefore:false,pan: UserData.fromJson(GetStorage().read("USERDATA")).pan!),
              transition: Transition.rightToLeft);
        } else if (value.userData!.stage == 12 &&
            value.userData!.esignStatus == 1) {
          Get.off(() => const CongratulationsScreen(),
              binding: CongratulationsScreenBindings(mobile: UserData.fromJson(GetStorage().read("USERDATA")).mobile!),
              transition: Transition.rightToLeft);
          //welcome
        }
      }
      else if (value.msg == "Client already registered.") {
        DialogManager.showMobileRegisteredDialog(context).then((value) {
          if (value == true) {
            Get.off(() => const SplashScreen(),
                binding: SplashBindings(), transition: Transition.rightToLeft);
          }
        });
      } else {
        Fluttertoast.showToast(msg: value.msg!);
      }

    }).onError((error, stackTrace) {
      DialogUtils.hideProgress(context);
    });
  }

  void editMobile() {
    Get.off(() => const IntroScreen(),
        binding: IntroScreenBindings(),
        duration: const Duration(milliseconds: 1500));
    EventKeys.editMobile(number.removeAllWhitespace);

  }
}
