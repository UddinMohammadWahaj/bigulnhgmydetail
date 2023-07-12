import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/screen/email_mobile/IntroScreen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 1500), () async {
      Get.off(() => const IntroScreen(),
          binding: IntroScreenBindings(),
          duration: const Duration(milliseconds: 1500));
    });
  }
}
