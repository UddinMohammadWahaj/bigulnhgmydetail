import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/screen/pan/PanVerificationScreen.dart';
import 'package:bigul_ekyc/screen/pan/controller/PanConfirmationController.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../model/VerifyOtp.dart';

class PanConfirmationScreen extends GetView<PanConfirmationController> {
  const PanConfirmationScreen({Key? key}) : super(key: key);

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
              title: Column(
                children: [
                  Text(
                    'You are on step 1 of 8',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Theme.of(context).hintColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  StepProgressIndicator(
                    totalSteps: 8,
                    currentStep: 1,
                    padding: 1,
                    selectedColor: AppColors.darkTextColor,
                    unselectedColor: AppColors.stepColor,
                    customStep: (index, color, _) =>
                        color == AppColors.darkTextColor
                            ? Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  border: Border.all(
                                      color: AppColors.primary, width: 1),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.stepColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                              ),
                  )
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Image.asset(
                        "assets/images/pan_confirm.png",
                        height: MediaQuery.of(context).size.height * 0.20,
                        fit: BoxFit.fitHeight,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("Hello,\n${controller.username}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("Not your name?",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(color: Theme.of(context).hintColor)),
                      GestureDetector(
                        onTap:()=>
                            controller.renterPanDetails()
                           ,
                        child: Text("Re-enter PAN Details",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline,
                                )),
                      ),
                    ],
                  ),
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
                        onPressed:  () {
                                controller.onConfirmClick(context);
                              }
                          ,
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
                              Text('Confirm it’s you',
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
