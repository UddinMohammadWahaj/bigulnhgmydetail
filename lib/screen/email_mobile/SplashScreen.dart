import 'package:bigul_ekyc/screen/email_mobile/controllers/SplashController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child: Hero(
                  tag: "logo",
                  child: Image.asset(
                    "assets/images/Logo.png",
                    width: MediaQuery.of(context).size.width * 0.4,
                    fit: BoxFit.fitWidth,
                  )))),
    );
  }
}
