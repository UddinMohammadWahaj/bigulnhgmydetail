import 'package:bigul_ekyc/model/BranchDetails.dart';
import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogManager {
  static Future<bool> showEmailVerifiedDialog(BuildContext context) async {
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isDialogOpen!) {
        Get.back(result: true);
      }
    });

    return await Get.dialog(ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child:
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints){
              if (constraints.maxWidth < 600) {
                return  ListView(
                  shrinkWrap: true,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/bg_dialog.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        "Email Verified",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      )),

                                ],
                              ),
                              Image.asset(
                                "assets/images/email_link.png",
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Get.back(result: true);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }else{
                return SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  height: MediaQuery.of(context).size.height*0.5,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/bg_dialog.png",
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                          "Email Verified",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.displayMedium,
                                        )),

                                  ],
                                ),
                                Image.asset(
                                  "assets/images/email_link.png",
                                  height: 150,
                                  fit: BoxFit.fitHeight,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Get.back(result: true);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          )


      ),
    ));
  }

  static Future<bool> showEmailLinkDialog(BuildContext context) async {
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isDialogOpen!) {
        Get.back(result: true);
      }
    });

    return await Get.dialog(ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child:
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            if (constraints.maxWidth < 600) {
              return  ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/bg_dialog.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      "OTP Sent",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displayMedium,
                                    )),

                              ],
                            ),
                            Image.asset(
                              "assets/images/email_link.png",
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Get.back(result: true);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }else{
              return SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.5,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/bg_dialog.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        "OTP Sent",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      )),

                                ],
                              ),
                              Image.asset(
                                "assets/images/email_link.png",
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Get.back(result: true);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        )


      ),
    ));
  }

  static Future<bool> showMobileVerifiedDialog(BuildContext context) async {
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isDialogOpen!) {
        Get.back(result: true);
      }
    });

    return await Get.dialog(ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),

        ),
        child:
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints){
              if (constraints.maxWidth < 600) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/bg_dialog.png",
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        "Mobile Number Verified",
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .displayMedium,
                                      )),

                                ],
                              ),
                              Image.asset(
                                "assets/images/mobile_verified.png",
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Get.back(result: true);
                              },
                            ),
                          ),
                        )                      ],
                    ),
                  ],
                );
              }else{
                return Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  height: MediaQuery.of(context).size.height*0.5,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/bg_dialog.png",
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            fit: BoxFit.fitWidth,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                          "Mobile Number Verified",
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .displayMedium,
                                        )),

                                  ],
                                ),
                                Image.asset(
                                  "assets/images/mobile_verified.png",
                                  height: 150,
                                  fit: BoxFit.fitHeight,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Get.back(result: true);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
          },
        )

      ),
    ));
  }

  static Future<bool> showMobileRegisteredDialog(BuildContext context) async {
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isDialogOpen!) {
        Get.back(result: true);
      }
    });

    return await Get.dialog(ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child:
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            if (constraints.maxWidth < 600) {
              return  ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/bg_dialog.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      "Number Already Registered",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displayMedium,
                                    )),

                              ],
                            ),
                            Image.asset(
                              "assets/images/mobile_already_registered.png",
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Get.back(result: true);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }else{
              return SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.5,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/bg_dialog.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        "Number Already Registered",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      )),

                                ],
                              ),
                              Image.asset(
                                "assets/images/mobile_already_registered.png",
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Get.back(result: true);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        )


      ),
    ));
  }

  static Future<bool> showDocumentFetchedDialog(BuildContext context) async {
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isDialogOpen!) {
        Get.back(result: true);
      }
    });

    return await Get.dialog(ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            if (constraints.maxWidth < 600) {
              return  ListView(
                  shrinkWrap: true,
                  children:[ Stack(
                    children: [
                      Image.asset(
                        "assets/images/bg_dialog.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      "Document Fetched!",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displayMedium,
                                    )),

                              ],
                            ),
                            Text(
                              "Since you are already a KRA registered member,we have your following details.",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(color: Theme.of(context).hintColor),
                            ),
                            Image.asset(
                              "assets/images/mobile_verified.png",
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Get.back(result: true);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  ]);
            }else{
              return SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.5,
                child: ListView(
                    shrinkWrap: true,
                    children:[ Stack(
                      children: [
                        Image.asset(
                          "assets/images/bg_dialog.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        "Document Fetched!",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      )),

                                ],
                              ),
                              Text(
                                "Since you are already a KRA registered member,we have your following details.",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: Theme.of(context).hintColor),
                              ),
                              Image.asset(
                                "assets/images/mobile_verified.png",
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Get.back(result: true);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    ]),
              );
            }
          },
        )

        ,
      ),
    ));
  }

  static Future<bool> showDigiDocumentFetchedDialog(BuildContext context) async {
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isDialogOpen!) {
        Get.back(result: true);
      }
    });

    return await Get.dialog(ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child:
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            if (constraints.maxWidth < 600) {
              return  ListView(
                  shrinkWrap: true,
                  children:[ Stack(
                    children: [
                      Image.asset(
                        "assets/images/bg_dialog.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      "Document Fetched!",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displayMedium,
                                    )),

                              ],
                            ),
                            Text(
                              "Let’s continue with the KYC journey.",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(color: Theme.of(context).hintColor),
                            ),
                            Image.asset(
                              "assets/images/mobile_verified.png",
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Get.back(result: true);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  ]);
            }else{
              return SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.5,
                child: ListView(
                    shrinkWrap: true,
                    children:[ Stack(
                      children: [
                        Image.asset(
                          "assets/images/bg_dialog.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        "Document Fetched!",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      )),

                                ],
                              ),
                              Text(
                                "Let’s continue with the KYC journey.",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: Theme.of(context).hintColor),
                              ),
                              Image.asset(
                                "assets/images/mobile_verified.png",
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Get.back(result: true);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    ]),
              );
            }
          },
        )

        ,
      ),
    ));
  }

  static bool hideDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
      return true;
    } else {
      return false;
    }
  }

  static void showPennyVerificationDialog(BuildContext context) {
    Get.dialog(ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            if (constraints.maxWidth < 600) {
              return   ListView(
                  shrinkWrap: true,
                  children:[ Stack(
                    children: [
                      Image.asset(
                        "assets/images/bg_dialog.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      "Bank Account Verification",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displayMedium,
                                    )),

                              ],
                            ),
                            Text(
                              "We are depositing ₹1 in your bank\naccount to verify it.\nPlease wait for a few seconds.",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(color: Theme.of(context).hintColor),
                            ),
                            Image.asset(
                              "assets/images/penny_verification.png",
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              // Get.back(result: true);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  ]
              );
            }else{
              return SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.5,
                child: ListView(
                    shrinkWrap: true,
                    children:[ Stack(
                      children: [
                        Image.asset(
                          "assets/images/bg_dialog.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        "Bank Account Verification",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      )),

                                ],
                              ),
                              Text(
                                "We are depositing ₹1 in your bank\naccount to verify it.\nPlease wait for a few seconds.",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: Theme.of(context).hintColor),
                              ),
                              Image.asset(
                                "assets/images/penny_verification.png",
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                // Get.back(result: true);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    ]
                ),
              );
            }
          },
        )

       ,
      ),
    ));
  }

  static Future<bool> showBankVerfiedDialog(BuildContext context, BranchDetails branchDetails, String username) async {
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isDialogOpen!) {
        Get.back(result: true);
      }
    });

    return await Get.dialog(ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child:LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            if (constraints.maxWidth < 600) {
              return  ListView(
                  shrinkWrap: true,
                  children:[ Stack(
                    children: [
                      Image.asset(
                        "assets/images/bg_dialog.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      "Bank Account Verification",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displayMedium,
                                    )),

                              ],
                            ),
                            Text(
                              "Hi, $username",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(color: Theme.of(context).hintColor),
                            ),
                            Image.asset(
                              "assets/images/bank_verified.png",
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                            const SizedBox(
                              height: 8,
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
                                                .displayMedium
                                                ?.copyWith(
                                                fontWeight: FontWeight.w500)),
                                        Text(": ${branchDetails.bank}",
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Text("Branch",
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                fontWeight: FontWeight.w500)),
                                        Text(": ${branchDetails.branch}",
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Text("IFSC",
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                fontWeight: FontWeight.w500)),
                                        Text(": ${branchDetails.ifsc}",
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium),
                                      ],
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Get.back(result: true);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  ]);
            }else{
              return SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.5,
                child: ListView(
                    shrinkWrap: true,
                    children:[ Stack(
                      children: [
                        Image.asset(
                          "assets/images/bg_dialog.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        "Bank Account Verification",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      )),

                                ],
                              ),
                              Text(
                                "Hi, $username",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: Theme.of(context).hintColor),
                              ),
                              Image.asset(
                                "assets/images/bank_verified.png",
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                              const SizedBox(
                                height: 8,
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
                                                  .displayMedium
                                                  ?.copyWith(
                                                  fontWeight: FontWeight.w500)),
                                          Text(": ${branchDetails.bank}",
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          Text("Branch",
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.copyWith(
                                                  fontWeight: FontWeight.w500)),
                                          Text(": ${branchDetails.branch}",
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          Text("IFSC",
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.copyWith(
                                                  fontWeight: FontWeight.w500)),
                                          Text(": ${branchDetails.ifsc}",
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium),
                                        ],
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Get.back(result: true);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    ]),
              );
            }
          },
        )

        ,
      ),
    ));
  }

  static Future<bool> showBankNotVerfiedDialog(BuildContext context) async {
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isDialogOpen!) {
        Get.back(result: true);
      }
    });

    return await Get.dialog(ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            if (constraints.maxWidth < 600) {
              return  ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/bg_dialog.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      "Oops, couldn’t verify your Bank Account",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displayMedium,
                                    )),

                              ],
                            ),
                            Text(
                              "No worries, we will ask you to upload your\nbanking document as proof in the last step.",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(color: Theme.of(context).hintColor),
                            ),
                            Image.asset(
                              "assets/images/bank_not_verified.png",
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Get.back(result: true);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }else{
              return SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.5,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/bg_dialog.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        "Oops, couldn’t verify your Bank Account",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      )),

                                ],
                              ),
                              Text(
                                "No worries, we will ask you to upload your\nbanking document as proof in the last step.",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: Theme.of(context).hintColor),
                              ),
                              Image.asset(
                                "assets/images/bank_not_verified.png",
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Get.back(result: true);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        )


        ,
      ),
    ));
  }


  static Future<bool> showSeedingNDialog(BuildContext context) async {


    return await Get.dialog(ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child:LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            if (constraints.maxWidth < 600) {
              return  ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/bg_dialog.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      "Oops, Your Pan and Adhaar number are not linked!",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displayMedium,
                                    )),

                              ],
                            ),
                            Text(
                              "Please link your pan and adhaar number in order to continue",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(color: Theme.of(context).hintColor),
                            ),
                            Image.asset(
                              "assets/images/bank_not_verified.png",
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Get.back(result: true);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }else{
              return SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.5,
                child:  ListView(
                  shrinkWrap: true,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/bg_dialog.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        "Oops, Your Pan and Adhaar number are not linked!",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      )),

                                ],
                              ),
                              Text(
                                "Please link your pan and adhaar number in order to continue",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: Theme.of(context).hintColor),
                              ),
                              Image.asset(
                                "assets/images/bank_not_verified.png",
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Get.back(result: true);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        )

       ,
      ),
    ));
  }
}
