import 'dart:io';

import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/model/VerifyOtp.dart';
import 'package:bigul_ekyc/screen/segment/SegmentDetailsScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:dio/src/multipart_file.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class BankProofController extends GetxController {

  DioClient dioClient;
  BankProofController({required this.dioClient});

  RxString selectedIncomeProof = "".obs;
  late RxList<File> selectedFiles = <File>[].obs;


  Future<File?> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg','png','pdf'],
    );

    if (result != null) {
      selectedFiles.add(File(result.files.single.path!));
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  void goToSegment() {
    Get.off(() => const SegmentDetailsScreen(),
        binding: SegmentDetailsScreenBinding(
            mobile: UserData.fromJson(GetStorage().read("USERDATA")).mobile!),
        transition: Transition.rightToLeft);
  }

  Future<void> uploadProof(BuildContext context) async {
    EventKeys.uploadBankProof( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);


    FocusScope.of(context).unfocus();
    if(selectedFiles.isNotEmpty) {
      Map<String, dynamic> map = {};

      map["mobile"] = UserData.fromJson(GetStorage().read("USERDATA")).mobile!;
      map["document_type"] = selectedIncomeProof.value;
      String? mimeType = mime(selectedFiles[0].path);
      String mimee = mimeType!.split('/')[0];
      String type = mimeType.split('/')[1];
      map["bank_proof"] = await dio.MultipartFile.fromFile(
          selectedFiles[0].path,
          contentType: MediaType(mimee, type));
      print(map.toString());
      DialogUtils.showDialog(context);
      await dioClient.bankProof(map).then((value) {
        DialogUtils.hideProgress(context);
        if (value.status == 200) {
          GetStorage().write("USERDATA", value.userData?.toJson());
          goToSegment();
        }else{
          Fluttertoast.showToast(msg: value.msg!);
        }
      }).onError((error, stackTrace) {
        DialogUtils.hideProgress(context);
      });
    }
  }

}


