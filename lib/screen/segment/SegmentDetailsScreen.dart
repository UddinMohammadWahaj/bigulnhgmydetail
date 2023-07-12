import 'package:bigul_ekyc/screen/segment/controller/SegmentData.dart';
import 'package:bigul_ekyc/screen/segment/controller/SegmentDetailsController.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/VerifyOtp.dart';

class SegmentDetailsScreen extends GetView<SegmentDetailsController> {
  const SegmentDetailsScreen({Key? key}) : super(key: key);

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
              title: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      'You are on step 5 of 8',
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
                      currentStep: 5,
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Image.asset(
                    "assets/images/segment.png",
                    height: MediaQuery.of(context).size.height * 0.20,
                    fit: BoxFit.fitHeight,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("Trading & Investment preferences",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("Segment Details - 1/2",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: Theme.of(context).hintColor)),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(() => MasonryGridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 1,
                        itemCount: controller.items.length ?? 0,
                        itemBuilder: (context, headerIndex) {
                          SegmentHeader header = controller.items[headerIndex];
                          return ExpansionTile(
                            initiallyExpanded: headerIndex==0?true:false,
                              tilePadding: EdgeInsets.zero,
                              title: CheckboxListTile(
                                activeColor: AppColors.primary,
                                title: Text("${header.header}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500)),
                                value: header.isExpanded,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (bool? value) {
                                  header.isExpanded = value!;
                                  header.list?.forEach((element) {element.isChecked=value;});
                                  controller.isComdtChek.value=value;
                                  controller.isFOChek.value=value;
                                  controller.items.refresh();
                                },
                              ),
                              children: <Widget>[
                                MasonryGridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 1,
                                  itemCount: header.list?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    ListElement listItem = header.list![index];
                                    if (listItem.type == "cb") {
                                      return CheckboxListTile(
                                        activeColor: AppColors.primary,
                                        title: Text("${listItem.text}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                        value: listItem.isChecked,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        onChanged: (bool? value) {
                                          listItem.isChecked = value!;


                                          if(header.list!.every((element) => element.isChecked==false)){
                                            header.isExpanded=false;
                                          }else{
                                            header.isExpanded=true;
                                          }


                                          controller.items.refresh();

                                         if(headerIndex==0){
                                           if(index==3){
                                             controller.isComdtChek.value=value!;
                                           }
                                           if(index==2){
                                             controller.isFOChek.value=value!;
                                           }
                                         }
                                        },
                                      );
                                    }
                                    if (listItem.type == "text") {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text("${listItem.text}",
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium
                                                    ?.copyWith(
                                                  fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                            MasonryGridView.count(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              crossAxisCount: 1,
                                              itemCount:
                                                  listItem.radiolist?.length ??
                                                      0,
                                              itemBuilder: (context, index) {
                                                String radio =
                                                    listItem.radiolist![index];
                                                return RadioListTile(
                                                  title: Text(radio,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium
                                                          ?.copyWith(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                  value: radio,
                                                  groupValue:
                                                      listItem.selectedRadio,
                                                  onChanged: (value) {
                                                    listItem.selectedRadio =
                                                        value;
                                                    controller.items.refresh();
                                                  },
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                    return const Placeholder();
                                  },
                                )
                              ]);
                        },
                      ))
                ]),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  ListTileTheme(
                    horizontalTitleGap: 0,
                    contentPadding: EdgeInsets.zero,
                    child: Obx(
                      () => CheckboxListTile(
                        activeColor: AppColors.primary,
                          value: controller.isAccept.value,
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "I accept the Terms & Conditions",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500, fontSize: 12),

                              ),
                              IconButton(
                                  onPressed: () async {
                                    if (!await launchUrl(Uri.parse("https://bigul.co/terms-and-conditions") , mode: LaunchMode.externalApplication,)) {
                                    throw Exception('Could not launch www.bigul.co');
                                    }

                                  },
                                  icon: const Icon(
                                    Icons.info,
                                    color: Colors.teal,
                                  )
                              ),
                            ],
                          ),
                          onChanged: (value) {
                          if(value==true) {
                            if (controller.items[2].list!.every((
                                element) => element.isChecked == true)) {
                              controller.isAccept.value = value!;
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please select all declaration and preferences");
                            }
                          }else{
                            controller.isAccept.value = value!;
                          }
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 60,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: controller.isAccept.value
                              ? () {
                                  controller.segment(context).then((value) {
                                    controller.isComdtChek.value||controller.isFOChek.value||controller.isAnnualGreater.value
                                        ? controller.goToInvestment()
                                        : controller.goToSelfie();
                                  });
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    UserData.fromJson(GetStorage().read("USERDATA")).jsonData==null?
                                    controller.isComdtChek.value||controller.isFOChek.value||controller.isAnnualGreater.value?'Next, Income Proof':'Next, Take a Selfie'
                                        :
                                    controller.isComdtChek.value||controller.isFOChek.value||controller.isAnnualGreater.value?'Next, Income Proof':'Next, Take a Signature'
                                    ,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
