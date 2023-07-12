import 'package:bigul_ekyc/screen/signature/controller/SignatureController.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignatureScreen extends GetView<SignatureController> {
  const SignatureScreen({Key? key}) : super(key: key);

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
                      'You are on step 8 of 8',
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
                      currentStep: 8,
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
            body: Obx(
              ()=> Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child:
                      
                      Obx(
                          ()=> SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child:
                          controller.selectedValue.value=="Draw your Signature"?

                          HandSignature(
                            control: controller.control,
                            color: Colors.blueGrey,
                            width: 1,
                            maxWidth: 1.5,
                            type: SignatureDrawType.shape,
                          ):


                              controller.isFileSelected.value ||  controller.isFileCaptured.value?
                            controller.image!=null?
                            Image.file(controller.image!,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                              fit: BoxFit.fitWidth,
                            ):Container()
                                  :Container()
                        ),
                      )
                     
                    ),
                    SizedBox(height: 50,
                      child: RadioListTile(
                        activeColor: AppColors.primary,
                        contentPadding: EdgeInsets.zero,
                        title: Text("Draw your Signature",
                            style:
                            controller.selectedValue.value=="Draw your Signature" ?
                            Theme.of(context)
                                .textTheme
                                .displayLarge?.copyWith(fontWeight: FontWeight.bold)  :
                            Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: Theme.of(context).hintColor)),
                        value: "Draw your Signature",
                        groupValue: controller.selectedValue.value,
                        onChanged: (value) {
                          controller.selectedValue.value = value!;
                          controller.changeStatus();
                        },
                      ),
                    ),
                    Text("\u2022 Use your finger to sign within the box\n\u2022 Avoid signing with your initials",
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(color: Theme.of(context).hintColor)),
                    const SizedBox(height: 16,),
                    GestureDetector(
                      onTap: (){
                        controller.control.clear();
                      },
                      child: Text("Erase & Try Again",
                          textAlign: TextAlign.center,
                          style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline,
                          )),
                    ),

                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60,
                            child: Divider(
                              thickness: 1,
                              color: Theme.of(context)
                                  .hintColor
                                  .withOpacity(0.5),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("OR",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                    color: Theme.of(context)
                                        .hintColor)),
                          ),
                          SizedBox(
                            width: 60,
                            child: Divider(
                              thickness: 1,
                              color: Theme.of(context)
                                  .hintColor
                                  .withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: RadioListTile(
                        activeColor: AppColors.primary,
                        contentPadding: EdgeInsets.zero,
                        title: Obx(
                          ()=> Row(
                            children: [
                              Expanded(
                                child: Text("Capture Signature",
                                    style:
                                    controller.selectedValue.value=="Capture Signature" ?
                                    Theme.of(context)
                                        .textTheme
                                        .displayLarge?.copyWith(fontWeight: FontWeight.bold)  :
                                    Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(color: Theme.of(context).hintColor)),
                              ),

                              controller.isFileCaptured.value?
                              IconButton(
                                  onPressed: () {
                                  controller.deleteImage();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )
                              ):Container(),
                            ],
                          ),
                        ),
                        value: "Capture Signature",
                        groupValue: controller.selectedValue.value,
                        onChanged: (value) {
                          controller.selectedValue.value = value!;
                          controller.changeStatus();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: RadioListTile(
                        activeColor: AppColors.primary,
                        contentPadding: EdgeInsets.zero,
                        title: Obx(
                          ()=> Row(
                            children: [
                              Expanded(
                                child: Text("Upload Photo of Signature",
                                    style:
                                    controller.selectedValue.value=="Upload Photo of Signature" ?
                                    Theme.of(context)
                                        .textTheme
                                        .displayLarge?.copyWith(fontWeight: FontWeight.bold)  :
                                    Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(color: Theme.of(context).hintColor)),
                              ),

                              controller.isFileSelected.value?
                              IconButton(
                                  onPressed: () {
                                    controller.deleteImage();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )
                              ):Container(),
                            ],
                          ),
                        ),
                        value: "Upload Photo of Signature",
                        groupValue: controller.selectedValue.value,
                        onChanged: (value) {
                          controller.selectedValue.value = value!;
                          controller.changeStatus();
                        },
                      ),
                    )
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
                      child: Obx(
                        ()=> ElevatedButton(
                          onPressed: controller.isSomethingOnCanvas.value || controller.selectedValue.value!="Draw your Signature" ? () {
                            switch(controller.selectedValue.value){
                              case "Draw your Signature" :
                                controller.uploadProof(context);
                                break;
                              case "Capture Signature" :
                                controller.buttonText.value == "Continue to Last Step" ?
                                controller.uploadProof(context)
                                    :
                                controller.pickImage().then((value) {
                                  if(value!=null){
                                    controller.buttonText.value = "Continue to Last Step";
                                  }
                                });

                                break;
                              case "Upload Photo of Signature" :
                                controller.buttonText.value == "Continue to Last Step" ?
                                controller.uploadProof(context)
                                    :
                                controller.pickJPG().then((value) {
                                  if(value!=null){
                                    controller.buttonText.value = "Continue to Last Step";
                                  }
                                });

                                break;
                            }


                          } : null,
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

                              Obx(
                              ()=> Text(controller.buttonText.value,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(color: Colors.white)),
                              ),
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
