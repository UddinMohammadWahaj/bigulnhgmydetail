import 'package:bigul_ekyc/screen/pan/controller/PanVerificationController.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:intl/intl.dart';

class PanVerificationScreen extends GetView<PanVerificationController> {
  const PanVerificationScreen({Key? key}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Image.asset(
                      "assets/images/pan_verify.png",
                      height: MediaQuery.of(context).size.height * 0.20,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Verify Pan Details",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                        "Enter your PAN number and Date of Birth. We will verify the details for you.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: Theme.of(context).hintColor)),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: TextFormField(
                          inputFormatters: [controller.panFormatter,UpperCaseTextFormatter()],
                          controller: controller.panNumberController,
                          textCapitalization: TextCapitalization.characters,
                          style: Theme.of(context).textTheme.displayMedium,
                        textInputAction: TextInputAction.done,
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

                            hintText: "Enter PAN Number",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: Theme.of(context).hintColor),
                            errorStyle: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(color: Colors.red),
                          ),
                          onChanged: (value){
                            controller.panNumberController.text.toUpperCase();
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => controller.isValidPanCardNo(value!) ? null : "Please enter valid pan number",

                        ),
                      ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: TextFormField(
                        controller: controller.selectedDOB,
                        inputFormatters: [controller.dobFormatter],
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                        textCapitalization: TextCapitalization.characters,
                        enableInteractiveSelection: false, textInputAction: TextInputAction.done,
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
                          hintText: "Date of Birth (DD/MM/YYYY)",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_month),
                            onPressed: () async{

                              DateTime getMinDate() {
                                final now = DateTime.now();
                                return DateTime(now.year - 18, now.month, now.day);
                              }
                              DateTime get100YearDate() {
                                final now = getMinDate();
                                return DateTime(now.year - 100, now.month, now.day);
                              }

                              // Show the date picker dialog
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                              firstDate:get100YearDate() ,
                              initialDate :getMinDate(),
                                lastDate: getMinDate(),
                              );
                              if (picked != null ) {
                                  // selectedDate = picked;
                                  controller.selectedDOB.text =  DateFormat('dd/MM/yyyy').format(picked);
                              }

                            },
                          ),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(color: Theme.of(context).hintColor),
                          errorStyle: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(color: Colors.red),
                        ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }
                            final components = value.split("/");
                            if (components.length == 3) {
                              final day = int.tryParse(components[0]);
                              final month = int.tryParse(components[1]);
                              final year = int.tryParse(components[2]);
                              if (day != null && month != null && year != null) {



                                if (month < 1 || month > 12) {
                                  return "Please enter valid Month";
                                }

                                if (day < 1 ||
                                    day > DateUtils.getDaysInMonth(year, month)) {
                                  return "Please enter valid date for the month";
                                }


                                if(year.toString().length!=4){
                                  return "Please enter valid year";

                                }
                                final date = DateTime(year, month, day);
                                DateTime now = DateTime.now();
                                int age = now.year - date.year;
                                if (now.month < date.month ||
                                    (now.month == date.month && now.day < date.day)) {
                                  age--;
                                }
                                if (age <= 18) {
                                  return "Your age must be 18 year or above";
                                }



                                if (date.year == year && date.month == month && date.day == day) {
                                  return null;
                                }
                              }
                            }
                            return "Please enter valid DOB";
                          }
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: controller.isValidForm().value
                            ? () {
                                controller.goToPanConfirmationScreen(context);
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
                            Text('Verify PAN',
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
