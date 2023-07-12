import 'package:bigul_ekyc/screen/bank/controller/EnterBankController.dart';
import 'package:bigul_ekyc/screen/pan/controller/PanVerificationController.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EnterBankScreen extends GetView<EnterBankController> {
  const EnterBankScreen({Key? key}) : super(key: key);

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
                    'You are on step 4 of 8',
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
                    currentStep: 4,
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
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Image.asset(
                      "assets/images/enter_bank.png",
                      height: MediaQuery.of(context).size.height * 0.20,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Let’s now find your Bank",
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Enter your IFSC and we’ll find your bank branch.",
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
                          controller: controller.ifscController,
                          inputFormatters: [
                            controller.ifscMasking,UpperCaseTextFormatter()
                          ],
                          style: Theme.of(context).textTheme.displayMedium,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                            hintText: "Enter your bank IFSC code",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: Theme.of(context).hintColor)

                          ),

                        ),

                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                    //   child: TextField(
                    //     inputFormatters: [
                    //       FilteringTextInputFormatter.allow(
                    //           RegExp("[0-9a-zA-Z ]"))
                    //     ],
                    //     enabled: false,
                    //     style: Theme.of(context).textTheme.displayMedium,
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //         borderSide: const BorderSide(
                    //           color: AppColors.primary,
                    //           width: 2.0,
                    //         ),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //         borderSide: const BorderSide(
                    //           color: AppColors.primary,
                    //           width: 1.5,
                    //         ),
                    //       ),
                    //       hintText: "Enter Bank Branch",
                    //       hintStyle: Theme.of(context)
                    //           .textTheme
                    //           .displayMedium
                    //           ?.copyWith(color: Theme.of(context).hintColor),
                    //     ),
                    //   ),
                    // ),
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
                        onPressed: controller.ifscController.text.isNotEmpty
                            ? () {
                                controller.verifyBankScreen();
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Search for your Bank',
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
