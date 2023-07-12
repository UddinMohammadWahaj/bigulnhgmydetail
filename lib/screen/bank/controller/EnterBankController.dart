import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/razor_client.dart';
import 'package:bigul_ekyc/screen/bank/VerifyBankScreen.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../model/VerifyOtp.dart';

class EnterBankController extends GetxController {
  RazorClient razorClient;

  EnterBankController({required this.razorClient});
  TextEditingController ifscController = TextEditingController();
  RxBool isIfscValid = false.obs;
  var ifscMasking = MaskTextInputFormatter(mask: "AAAA#######");

  @override
  void onInit() {
    super.onInit();
    ifscController.addListener(() {
      EventKeys.enterBankNameIFSC( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);
    });
  }



  Future<void> verifyBankScreen() async {
    await razorClient.getBranch(ifscController.text).then((value) {
      isIfscValid.value = true;
      Get.off(() => const VerifyBankScreen(),
          binding: VerifyBankScreenBinding(branchDetails :value),
          transition: Transition.rightToLeft);
    }).onError((error, stackTrace) {
      isIfscValid.value = false;
      Fluttertoast.showToast(msg: "Branch Not found");
    });
  }


}
