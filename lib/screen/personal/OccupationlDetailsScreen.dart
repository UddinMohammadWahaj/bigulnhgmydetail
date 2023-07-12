import 'package:bigul_ekyc/model/EducationList.dart';
import 'package:bigul_ekyc/model/VerifyOtp.dart';
import 'package:bigul_ekyc/screen/personal/BottomSheetWidgetListItem.dart';
import 'package:bigul_ekyc/screen/personal/controller/OccupationDetailsController.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OccupationDetailsScreen extends GetView<OccupationDetailsController> {
  const OccupationDetailsScreen({Key? key}) : super(key: key);

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
              title: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      'You are on step 3 of 8',
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
                      currentStep: 3,
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
            ),
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Image.asset(
                      "assets/images/personal_details.png",
                      height: MediaQuery.of(context).size.height * 0.20,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Fill your details",
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                    const SizedBox(
                      height: 6,
                    ),
                    Text("Personal Details - 2/2",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: Theme.of(context).hintColor)),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(
                      ()=> Column(
                        children: [
                          BottomSheetWidgetListItem(
                              editable :true,
                              title: "Your Education",
                              list: controller.educationList.value.educationList??[],
                              selectedValue: (ListItem? value) {
                                EventKeys.education( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

                                controller.isEducationSelected.value = value;
                              }),
                          controller.isVisible.value?
                          BottomSheetWidgetListItem(
                              editable : controller.isOccupationEditable.value,
                              title: "Occupation",
                              list:controller.occupationList.value.occupationList??[],
                              selectedValue: (ListItem? value) {
                                EventKeys.occupation( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

                                controller.isOccupationSelected.value = value;
                              }):Container(),
                          controller.isVisible.value?
                          BottomSheetWidgetListItem(
                              editable : controller.isAnnualIncomeEditable.value,
                              title: "Annual Income",
                              list:controller.annualIncomeList.value.annualIncomeList??[],
                              selectedValue: (ListItem? value) {
                                EventKeys.annualIncome( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

                                controller.isAnnualIncomeSelected.value = value;
                              }):Container(),
                          BottomSheetWidgetListItem(
                              editable :true,
                              title: "Trading Experience",
                              list:controller.tradingExperienceList.value.experienceList??[],
                              selectedValue: (ListItem? value) {
                                EventKeys.tradingExperience( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

                                controller.isTradingSelected.value = value;
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 60,
                      child: Obx(
                          ()=> ElevatedButton(
                          onPressed: controller.isOccupationValidate().value
                              ? () {
                                  controller.isOccupationMessage(context);
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
                                Text('Next, Bank Details',
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
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Text("Back",
                  //       textAlign: TextAlign.center,
                  //       style: Theme.of(context).textTheme.displayMedium),
                  // ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
