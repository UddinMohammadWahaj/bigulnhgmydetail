import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CongratulationsController extends GetxController {
  DioClient dioClient;
  String mobile;
  CongratulationsController({required this.dioClient,required this.mobile});

  RxList<Interest> interestList = <Interest>[
    Interest(
        name: "Automated Trading",
        imagepath: "assets/images/1.png",
        isSelected: false,
        bgColor: const Color(0xFFF2FFFC),
        checkColor: const Color(0xFF00FFC1)),

    Interest(
        name: "Equity Baskets",
        imagepath: "assets/images/2.png",
        isSelected: false,
        bgColor: const Color(0xFFFFFEF9),
        checkColor: const Color(0xFFFFDE2D)),

    Interest(
        name: "Chart Analysis",
        imagepath: "assets/images/3.png",
        isSelected: false,
        bgColor: const Color(0xFFFFFAFA),
        checkColor: const Color(0xFFF15B4D)),

    Interest(
        name: "Debt Products",
        imagepath: "assets/images/4.png",
        isSelected: false,
        bgColor: const Color(0xFFF8F9FF),
        checkColor: const Color(0xFF5367FC)),
  ].obs;


  Future<void> welcome(BuildContext context) async {
    FocusScope.of(context).unfocus();

    DialogUtils.showDialog(context);
    await dioClient.welcomeSurvey(mobile,interestList.value).then((value) {
      DialogUtils.hideProgress(context);
      if (value.status == 200) {
        GetStorage().write("USERDATA", value.userData?.toJson());
      }
      Fluttertoast.showToast(msg: value.msg!);
    }).onError((error, stackTrace) {
      DialogUtils.hideProgress(context);
    });
  }

}

class Interest {
  String? name;
  String? imagepath;
  bool? isSelected;
  Color? bgColor;
  Color? checkColor;

  Interest(
      {this.name,
      this.imagepath,
      this.isSelected,
      this.bgColor,
      this.checkColor});
}
