import 'package:bigul_ekyc/screen/email_mobile/controllers/MobileRegistrationController.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileRegistrationScreen extends GetView<MobileRegistrationController> {
  const MobileRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const Scaffold(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/bg_pattern.png",
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/mini_logo.png",
                ),
              ),
              centerTitle: true,
              title: Text(
                'Mobile Verification',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: Theme.of(context).hintColor),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Image.asset(
                      "assets/images/mobile_registration.png",
                      height: MediaQuery.of(context).size.height * 0.20,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Registration",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                        "Enter your Mobile Number and we will send you an OTP to verify.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: Theme.of(context).hintColor)),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child:  TextFormField(
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value){

                        },
                        onChanged: (value){
                          controller.onPhoneValidation(value.removeAllWhitespace);
                        },
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                            fontWeight:
                            FontWeight.normal),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                          hintText: "Enter Mobile Number",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                              color: Theme.of(context)
                                  .hintColor),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(signed: true),
                        controller:
                        controller.numberController,
                        inputFormatters: [
                          controller.phoneFormatter
                        ],
                      ),
                    ),
                    Obx(() {
                      if (!controller.isValidMobile.value) {
                        return Text(
                          'Please enter valid mobile number ',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: Colors.red),
                        );
                      } else {
                        return Container();
                      }
                    })
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: true
                            ? () {
                                controller.onGetOtpClick(context);
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
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                            (Set<MaterialState> states) {
                              return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              );
                            },
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Get OTP',
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
                  //   child: Text("Back",
                  //       textAlign: TextAlign.center,
                  //       style: Theme.of(context).textTheme.displayMedium),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
