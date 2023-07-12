import 'dart:io';

import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/model/VerifyOtp.dart';
import 'package:bigul_ekyc/screen/adhaar_esign/AdharEsignScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hand_signature/signature.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:dio/src/multipart_file.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

class SignatureController extends GetxController {
  DioClient dioClient;
  SignatureController({required this.dioClient});

  RxBool isSomethingOnCanvas =false.obs;
  HandSignatureControl control = HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );
  @override
  void onInit() {
    super.onInit();

    control.addListener(() {
      print(isSomethingOnCanvas.value);
      isSomethingOnCanvas.value = control.isFilled || control.hasActivePath;

    });
  }


  RxString selectedValue = "Draw your Signature".obs;
  RxString buttonText = "Continue to Last Step".obs;

  List<String> options = [
    "Draw your Signature",
    "Capture Signature",
    "Upload Photo of Signature"
  ];

  void goToAdhaar() {

    Get.off(() => const AdhaarEsignScreen(),
        binding: AdhaarEsignScreenBindings(mobile:UserData.fromJson(GetStorage().read("USERDATA")).mobile!,callBefore: true,pan: UserData.fromJson(GetStorage().read("USERDATA")).pan!),
        transition: Transition.rightToLeft);
  }

  void changeStatus() {
    control.clear();
    image=null;
    isFileSelected.value=false;
    switch (selectedValue.value) {
      case "Draw your Signature":
        EventKeys.drawSignature( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

        buttonText.value = "Continue to Last Step";
        break;
      case "Capture Signature":
        EventKeys.takePicture( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);
        buttonText.value = "Take Picture of your Signature";
        break;
      case "Upload Photo of Signature":
        EventKeys.uploadSignature( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);
        buttonText.value = "Upload Photo of your Signature";
        break;
    }
    notifyChildrens();
  }



  File? image;
  RxBool isFileSelected= false.obs;
  Future<File?> pickJPG() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg','png'],
    );
    isFileSelected.value = false;
    if (result != null) {
      image = File(result.files.single.path!);
      isFileSelected.value = true;
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }


  RxBool isFileCaptured= false.obs;
  Future<File?> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      isFileCaptured.value = false;
      if(image == null) return null;
      final imageTemp = File(image.path);
      this.image = imageTemp;
      isFileCaptured.value = true;
      return imageTemp;
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
    return null;
  }

  void deleteImage(){
    image=null;
    isFileSelected.value = false;
    isFileCaptured.value = false;
    changeStatus();

  }

  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = '$tempPath/file_01.jpg'; // file_01.tmp is dump file, can be anything
    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<void> uploadProof(BuildContext context) async {
    FocusScope.of(context).unfocus();
    Map<String, dynamic> map = {};
    map["mobile"] = UserData.fromJson(GetStorage().read("USERDATA")).mobile!;
    switch (selectedValue.value) {
      case "Draw your Signature":
     await   control.toImage().then((value) async {
          await writeToFile(value!).then((value) async {
            String? mimeType = mime(value.path);
            String mimee = mimeType!.split('/')[0];
            String type = mimeType.split('/')[1];
            map["client_signature"] = await dio.MultipartFile.fromFile(value.path??"",
                contentType: MediaType(mimee, type));
          });
        });
        break;
      case "Capture Signature":
      case "Upload Photo of Signature":
      String? mimeType = mime(image?.path);
      String mimee = mimeType!.split('/')[0];
      String type = mimeType.split('/')[1];
      map["client_signature"] = await dio.MultipartFile.fromFile(image?.path??"",
          contentType: MediaType(mimee, type));
        break;
    }









      print(map.toString());
      DialogUtils.showDialog(context);
      await dioClient.clientSignature(map).then((value) {

        DialogUtils.hideProgress(context);

        if(value.status==200){
          GetStorage().write("USERDATA", value.userData?.toJson());
          goToAdhaar();
        }

      }).onError((error, stackTrace) {
        DialogUtils.hideProgress(context);
      });

  }
}
