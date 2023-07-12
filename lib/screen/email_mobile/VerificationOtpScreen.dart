import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/screen/email_mobile/IntroScreen.dart';
import 'package:bigul_ekyc/screen/email_mobile/controllers/VerificationOtpController.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerificationOtpScreen extends GetView<VerificationOtpController> {
  const VerificationOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/mini_logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              centerTitle: true,
              title: Text(
                'Mobile Verification',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
            body: Stack(
              children: [
                Image.asset(
                  "assets/images/bg_pattern.png",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Image.asset(
                            "assets/images/verification_otp.png",
                            width: MediaQuery.of(context).size.width * 0.50,
                            fit: BoxFit.fitWidth,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text("Verification",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 16,
                          ),
                          Text("Enter the 6 digit OTP sent to",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor)),
                          Text(controller.number,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displayMedium),
                          const SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.editMobile();

                            },
                            child: Text("Edit Mobile Number",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w400)),
                          ),
                          // Obx(
                          //   ()=> OTPTextField(
                          //     width: MediaQuery.of(context).size.width * 0.75,
                          //     controller: controller.otpbox.value,
                          //     length: 6,
                          //     fieldWidth: 45,
                          //     spaceBetween: 2,
                          //     outlineBorderRadius: 5,
                          //
                          //     //set to true to show as box or false to show as dash
                          //     otpFieldStyle: OtpFieldStyle(
                          //       focusBorderColor: AppColors.primary,
                          //     ),
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .displayLarge!
                          //         .copyWith(fontWeight: FontWeight.bold),
                          //     fieldStyle: FieldStyle.box,
                          //     onChanged: (String code) {
                          //       controller.verificationCode.value = code;
                          //     },
                          //     onCompleted: (String code) {
                          //       print(code);
                          //       controller.verificationCode.value = code;
                          //       if (code.length == 6) {
                          //         controller.onSumitOtp(context);
                          //       }
                          //     },
                          //     //runs when every textfield is filled
                          //     // end onSubmit
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Obx(
                              () => Column(
                                children: [
                                  controller.verificationCode.value.isNotEmpty
                                      ? Container()
                                      : Container(),
                                  controller.controls.value.isNotEmpty
                                      ? Container()
                                      : Container(),
                                  SizedBox(
                                    height: 60,
                                    child: OtpTextField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              signed: true),
                                      handleControllers: (controllers) {
                                        controller.controls.value =
                                            controllers!;
                                      },
                                      numberOfFields: 6,
                                      fieldWidth: 45,
                                      borderColor: const Color(0xFF512DA8),
                                      //set to true to show as box or false to show as dash
                                      showFieldAsBox: true,
                                      borderWidth: 1,
                                      styles: [
                                        Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ],
                                      //runs when every textfield is filled
                                      onSubmit: (String verificationCode) {
                                        controller.verificationCode.value =
                                            verificationCode;
                                        if (verificationCode.length == 6) {
                                          controller.onSumitOtp(context);
                                        }
                                      }, // end onSubmit
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Obx(
                                () => CountdownTimer(
                                  controller: controller.countDownController,
                                  endTime: controller.endTime.value,
                                  onEnd: () {},
                                  widgetBuilder:
                                      (_, CurrentRemainingTime? time) {
                                    if (time == null) {
                                      return Text(
                                        '00:00',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                            ),
                                      );
                                    }
                                    return Text(
                                        '${time.min ?? "00"}:${time.sec ?? "00"}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ));
                                  },
                                ),
                              ),
                              Obx(
                                () => GestureDetector(
                                  onTap: !controller.isResendActive.value
                                      ? null
                                      : () {
                                          controller.onResendOtp(context);
                                        },
                                  child: Text("Resend OTP",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              color: controller
                                                      .isResendActive.value
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context).hintColor,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 60,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed:
                              controller.verificationCode.value.length == 6
                                  ? () {
                                      controller.onSumitOtp(context);
                                    }
                                  : null,
                          // set the onPressed callback based on the isEnabled boolean value
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.grey;
                                } else {
                                  return AppColors.primary;
                                }
                              },
                            ),
                            shape: MaterialStateProperty.resolveWith<
                                OutlinedBorder>(
                              (Set<MaterialState> states) {
                                return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                );
                              },
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Verify Mobile Number',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Text("Back",
                  //         textAlign: TextAlign.center,
                  //         style: Theme.of(context).textTheme.displayMedium),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      } else {
        return SafeArea(
          child: Row(
            children: [
              Flexible(
                child: Image.asset(
                  "assets/web/otp.png",
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/mini_logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    centerTitle: true,
                    title: Text(
                      'Mobile Verification',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ),
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),

                            Text("Verification",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 16,
                            ),
                            Text("Enter the 6 digit OTP sent to",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor)),
                            Text(controller.number,
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                print("tap");
                                Get.back();
                              },
                              child: Text("Edit Mobile Number",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w400)),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 30.0),
                              child: Obx(
                                () => Column(
                                  children: [
                                    controller.verificationCode.value.isNotEmpty
                                        ? Container()
                                        : Container(),
                                    controller.controls.value.isNotEmpty
                                        ? Container()
                                        : Container(),
                                    SizedBox(
                                      height: 60,
                                      child: OtpTextField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                signed: true),
                                        handleControllers: (controllers) {
                                          controller.controls.value =
                                              controllers!;
                                        },
                                        numberOfFields: 6,
                                        fieldWidth: 45,
                                        borderColor: const Color(0xFF512DA8),
                                        //set to true to show as box or false to show as dash
                                        showFieldAsBox: true,
                                        borderWidth: 1,
                                        styles: [
                                          Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                          Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                          Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                          Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                          Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                          Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ],
                                        //runs when every textfield is filled
                                        onSubmit: (String verificationCode) {
                                          controller.verificationCode.value =
                                              verificationCode;
                                          if (verificationCode.length == 6) {
                                            controller.onSumitOtp(context);
                                          }
                                        }, // end onSubmit
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Obx(
                                  () => CountdownTimer(
                                    controller: controller.countDownController,
                                    endTime: controller.endTime.value,
                                    onEnd: () {},
                                    widgetBuilder:
                                        (_, CurrentRemainingTime? time) {
                                      if (time == null) {
                                        return Text(
                                          '00:00',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor,
                                              ),
                                        );
                                      }
                                      return Text(
                                          '${time.min ?? "00"}:${time.sec ?? "00"}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                              ));
                                    },
                                  ),
                                ),
                                Obx(
                                  () => GestureDetector(
                                    onTap: !controller.isResendActive.value
                                        ? null
                                        : () {
                                            controller.onResendOtp(context);
                                          },
                                    child: Text("Resend OTP",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                                color: controller
                                                        .isResendActive.value
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Theme.of(context)
                                                        .hintColor,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w400)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SizedBox(
                            height: 60,
                            child: Obx(
                              () => ElevatedButton(
                                onPressed:
                                    controller.verificationCode.value.length ==
                                            6
                                        ? () {
                                            controller.onSumitOtp(context);
                                          }
                                        : null,
                                // set the onPressed callback based on the isEnabled boolean value
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors.grey;
                                      } else {
                                        return AppColors.primary;
                                      }
                                    },
                                  ),
                                  shape: MaterialStateProperty.resolveWith<
                                      OutlinedBorder>(
                                    (Set<MaterialState> states) {
                                      return RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      );
                                    },
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Verify Mobile Number',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.back();
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text("Back",
                        //         textAlign: TextAlign.center,
                        //         style:
                        //             Theme.of(context).textTheme.displayMedium),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
