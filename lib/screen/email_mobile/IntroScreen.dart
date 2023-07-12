import 'package:bigul_ekyc/screen/email_mobile/controllers/IntroScreenController.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:bigul_ekyc/utils/DelayedWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class IntroScreen extends GetView<IntroScreenController> {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return SafeArea(
          child: Scaffold(
            body:
            Stack(
              children: [
                Image.asset(
                  "assets/images/bg_pattern.png",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
physics: const ClampingScrollPhysics(),
                 shrinkWrap: true,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                              tag: "logo",
                              child: Image.asset(
                                "assets/images/Logo.png",
                                width:
                                    MediaQuery.of(context).size.width * 0.4,
                                fit: BoxFit.fitWidth,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DelayedWidget(
                        delay: const Duration(seconds: 1),
                        duration: 500,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/introImage.png",
                              width: MediaQuery.of(context).size.width * 0.80,
                              fit: BoxFit.fitWidth,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                  "A Trading and Investment Ecosystem\nbuilt for your Success!",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DelayedWidget(
                        delay: const Duration(seconds: 2),
                        duration: 500,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Text("Let’s get started!",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w400)),
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Stack(
                                      children: [
                                        TextFormField(
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
                                        Positioned(
                                          right: 4,
                                          top: 4,
                                          bottom: 4,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller
                                                  .goToVerificationOtpScreen(
                                                      context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0),
                                              ),
                                              backgroundColor:
                                                  AppColors.primary,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              textStyle: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            child: Text(
                                              'Get OTP',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      child: Divider(
                                        thickness: 2,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.15),
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
                                        thickness: 2,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0),
                                child: SizedBox(
                                  height: 60,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.onPressGoogleSignIn(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 5,
                                      shadowColor: Colors.white70,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).cardColor,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50.0, vertical: 15.0),
                                      textStyle: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/google.png",
                                          width: 30,
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Text('Sign in with Google',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),





                    ],
                  ),
                ),
              ],
            ),
          ),
        );

      } else {

        //Responsive
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Row(
              children: [
                Flexible(
                  child: Image.asset(
                    "assets/web/intro.png",
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Hero(
                                tag: "logo",
                                child: Image.asset(
                                  "assets/images/Logo.png",
                                  height: MediaQuery.of(context).size.height *
                                      0.08,
                                  fit: BoxFit.fitHeight,
                                )),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                                "A Trading and Investment Ecosystem built for your Success!",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DelayedWidget(
                            delay: const Duration(seconds: 2),
                            duration: 500,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                children: [
                                  Text("Let’s get started!",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w400)),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Stack(
                                          children: [
                                            TextFormField(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30),
                                                  borderSide:
                                                      const BorderSide(
                                                    color: AppColors.primary,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30),
                                                  borderSide:
                                                      const BorderSide(
                                                    color: AppColors.primary,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                hintText:
                                                    "Enter Mobile Number",
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium
                                                    ?.copyWith(
                                                        color:
                                                            Theme.of(context)
                                                                .hintColor),
                                              ),
                                              keyboardType:
                                                  TextInputType.phone,
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller:
                                                  controller.numberController,
                                              inputFormatters: [
                                                controller.phoneFormatter
                                              ],
                                            ),
                                            Positioned(
                                              right: 4,
                                              top: 4,
                                              bottom: 4,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  controller
                                                      .goToVerificationOtpScreen(
                                                          context);
                                                },
                                                style:
                                                    ElevatedButton.styleFrom(
                                                  shape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  backgroundColor:
                                                      AppColors.primary,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0),
                                                  textStyle: const TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                ),
                                                child: Text(
                                                  'Get OTP',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium
                                                      ?.copyWith(
                                                          color:
                                                              Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Obx(() {
                                        if (!controller.isValidMobile.value) {
                                          return Text(
                                            'Please enter 10 digit number ',
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: SizedBox(
                                      height: 60,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller
                                              .onPressGoogleSignIn(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 5,
                                          shadowColor: Colors.white54,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          backgroundColor:
                                              Theme.of(context).cardColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50.0,
                                              vertical: 15.0),
                                          textStyle: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/google.png",
                                              width: 30,
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Text('Sign in with Google',
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black54)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
