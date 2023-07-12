import 'package:bigul_ekyc/screen/bank_proof/controller/BankProofController.dart';
import 'package:bigul_ekyc/screen/personal/BottomSheetWidget.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../model/VerifyOtp.dart';

class BankProofScreen extends GetView<BankProofController> {
  const BankProofScreen({Key? key}) : super(key: key);

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
                child: Column(children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Image.asset(
                    "assets/images/bank_proof.png",
                    height: MediaQuery.of(context).size.height * 0.20,
                    fit: BoxFit.fitHeight,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("Upload Bank Proof",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("We weren’t able to verify your bank\naccount before. Please select a type\nof proof and upload a PDF file to\ncontinue.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: Theme.of(context).hintColor)),
                  const SizedBox(
                    height: 16,
                  ),
                  BottomSheetWidget(
                      editable :true,
                      title: "Bank Account Proof",
                      list: const [
                        "Bank Statement",
                        "Cancelled Cheque Leaf",
                        "1st page of Passbook",
                      ],
                      fill:"",
                      selectedValue: (value) {
                        EventKeys.selectBankProofType( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

                        controller.selectedIncomeProof.value = value!;
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: SizedBox(
                      height: 60,
                      child: TextField(
                        textAlign: TextAlign.center,
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
                          hintText: "Enter Document Password, if any",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(color: Theme.of(context).hintColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 60,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: controller.selectedIncomeProof.isNotEmpty
                              ? () {
                                  controller.pickPDF().then((value) =>
                                      print(value?.absolute.path ?? ""));
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
                              IconButton(
                                icon: const Icon(
                                  Icons.upload,
                                ),
                                onPressed: () {},
                              ),
                              Text('Upload Document PDF',
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
                  Obx(
                    ()=> MasonryGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      itemCount: controller.selectedFiles.length??0,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.selectedFiles[index].path
                                      .split('/')
                                      .last,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    controller.selectedFiles.removeAt(index);
                                    controller.selectedFiles.refresh();
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ]),
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
                      child: Obx(
                        ()=> ElevatedButton(
                          onPressed: controller.selectedFiles.isNotEmpty
                              ? () {
                                  controller.uploadProof(context);
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
                              Text('Next, Segment Details',
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
