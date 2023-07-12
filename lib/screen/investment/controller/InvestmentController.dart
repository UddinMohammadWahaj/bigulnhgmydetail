import 'dart:io';

import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/model/VerifyOtp.dart';
import 'package:bigul_ekyc/screen/selfie/SelfieScreen.dart';
import 'package:bigul_ekyc/screen/signature/SignatureScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:dio/src/multipart_file.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class InvestmentDetailsController extends GetxController {

  DioClient dioClient;
  InvestmentDetailsController({required this.dioClient});

  RxString selectedIncomeProof = "".obs;
  late RxList<File> selectedFiles = <File>[].obs;


  Future<File?> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      selectedFiles.add(File(result.files.single.path!));
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  void goToSelfie() {
    UserData.fromJson(GetStorage().read("USERDATA")).jsonData==null?
    Get.off(() => const SelfieScreen(),
        binding: SelfieScreenBinding(),
        transition: Transition.rightToLeft)
        :
    Get.off(() => const SignatureScreen(),
        binding: SignatureScreenBindings(),
        transition: Transition.rightToLeft);
     }

  Future<void> uploadProof(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if(selectedFiles.isNotEmpty) {
      Map<String, dynamic> map = {};

      map["mobile"] = UserData.fromJson(GetStorage().read("USERDATA")).mobile!;
      map["stage"] =
          UserData.fromJson(GetStorage().read("USERDATA")).jsonData == null
              ?
              //is kra
              8
              :
              //is digio
              9;

      String? mimeType = mime(selectedFiles[0].path);
      String mimee = mimeType!.split('/')[0];
      String type = mimeType.split('/')[1];
      map["income_proof"] = await dio.MultipartFile.fromFile(
          selectedFiles[0].path,
          contentType: MediaType(mimee, type));
      print(map.toString());
      DialogUtils.showDialog(context);
      await dioClient.incomeProof(map).then((value) {
        DialogUtils.hideProgress(context);
        print(value.toString());
        if (value.status == 200) {
          print(map.toString());
          GetStorage().write("USERDATA", value.userData?.toJson());
          goToSelfie();

        }
      }).onError((error, stackTrace) {
        print(stackTrace);
        DialogUtils.hideProgress(context);
      });
    }
  }


}


