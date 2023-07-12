import 'dart:io';

import 'package:bigul_ekyc/screen/selfie/controller/SelfieController.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SelfieScreen extends GetView<SelfieController> {
  const SelfieScreen({Key? key}) : super(key: key);

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
                      'You are on step 6 of 8',
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
                      currentStep: 6,
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
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.selfiecolor,
                        width: 5,
                      ),
                    ),
                    child: Obx(() {
                      switch (controller.cameraStatus.value) {
                        case Status.camera_closed:
                          return ClipOval(
                              child: Image.asset("assets/images/selfie.png"));

                        case Status.camera_opened:
                          if (!controller.isCameraInitialized.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return ClipOval(

                              child: CameraPreview(
                                  controller.cameraController),
                            );
                          }

                        case Status.image_captured:
                          return ClipOval(
                            child: Image.memory(
                              File(controller.imagePath.value)
                                  .readAsBytesSync(),
                              fit: BoxFit.cover,
                            ),
                          );
                          break;
                      }
                    }),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    ()=> Text(controller.headingText.value,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                      ()=> Text(
                        controller.subheadingText.value,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: Theme.of(context).hintColor)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    ()=> Visibility(
                      visible: (controller.cameraStatus.value==Status.image_captured)?true:false,
                      child:  GestureDetector(
                      onTap: () {
                        controller.changeStatus(Status.camera_closed);
                      },
                      child: Text("Take Selfie Again",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w400)),
                    ),),
                  )


                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: true
                              ? () async {
                                  switch (controller.cameraStatus.value) {
                                    case Status.camera_closed:
                                      controller
                                          .changeStatus(Status.camera_opened);
                                      break;
                                    case Status.camera_opened:
                                      {
                                        await controller.captureImage().then((value) {
                                          controller.uploadImage();
                                        });
                                        controller.changeStatus(
                                            Status.image_captured);
                                      }
                                      break;
                                    case Status.image_captured:
                                      controller.goToSignature();
                                      break;
                                  }
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
                              Text(controller.buttonText.value,
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
                  //     switch (controller.cameraStatus.value) {
                  //       case Status.camera_closed:
                  //         Get.back();
                  //         break;
                  //       case Status.camera_opened:
                  //         controller.changeStatus(Status.camera_closed);
                  //         break;
                  //       case Status.image_captured:
                  //         controller.changeStatus(Status.camera_opened);
                  //         break;
                  //     }
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
