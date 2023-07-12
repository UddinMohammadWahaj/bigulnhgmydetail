import 'package:bigul_ekyc/screen/bank/controller/VerifyBankController.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class VerifyBankScreen extends GetView<VerifyBankController> {
  const VerifyBankScreen({Key? key}) : super(key: key);

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
                      "assets/images/verify_bank.png",
                      height: MediaQuery.of(context).size.height * 0.20,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Verify your Bank Account",
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                        "We found your Bank! Now enter your account number to verify it.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: Theme.of(context).hintColor)),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.cardColorBlue,
                          border:
                              Border.all(color: AppColors.primary, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(4),
                          },
                          border: TableBorder.all(
                              width: 1.0, color: Colors.transparent),
                          children: [
                            TableRow(
                              children: [
                                Text("Name",
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500)),
                                Text(": ${controller.branchDetails.bank}",
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text("Branch",
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500)),
                                Text(": ${controller.branchDetails.branch}",
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text("IFSC",
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500)),
                                Text(": ${controller.branchDetails.ifsc}",
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: controller.bankAccountNo,
                        obscureText: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(18),

                        ],
                        keyboardType: TextInputType.numberWithOptions(signed: true),

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
                          hintText: "Enter your Bank Account Number",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(color: Theme.of(context).hintColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Obx(
                        ()=> TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator:(value) => controller.isSame.value ? null : "Your Bank Account Number and Confirm Bank Account Number should match.",
                          obscureText: controller.isBankVisible.value?true:false,
                          controller: controller.confirmBankAccountNo,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(18),

                          ],
                          keyboardType: TextInputType.numberWithOptions(signed: true),

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
                            hintText: "Confirm your Bank Account Number",
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(
                                  ()=> IconButton(
                                    icon:  Icon(
                                     controller.isBankVisible.value ? Icons.visibility_off: Icons.visibility,
                                      color:controller.isBankVisible.value ?  AppColors.primary : AppColors.lightHintColor,
                                    ),
                                    onPressed: () {
                                      controller.isBankVisible.value = ! controller.isBankVisible.value;
                                    },
                                  ),
                                ),

                                controller.isSame.value
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.check_circle,
                                          color: AppColors.primary,
                                        ),
                                        onPressed: () {},
                                      )
                                    : Container()
                              ],
                            ),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: Theme.of(context).hintColor),

                          ),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 60,
                      child: Obx(
                          ()=> ElevatedButton(
                          onPressed: controller.isSame.value
                              ? () {
                                  controller.goToPennyVerification(context);
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
                              Text('Verify your Bank Account',
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
