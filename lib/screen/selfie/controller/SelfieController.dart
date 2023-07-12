import 'dart:io';

import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/screen/signature/SignatureScreen.dart';
import 'package:camera/camera.dart';
import 'package:dio/src/multipart_file.dart' as dio;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../model/VerifyOtp.dart';

enum Status { camera_closed, camera_opened, image_captured }

class SelfieController extends GetxController {
  DioClient dioClient;

  SelfieController({required this.dioClient});

  late CameraController cameraController;

  RxBool isCameraInitialized = false.obs;
  RxBool isOpenCamera = false.obs;
  RxString buttonText = "Open Camera".obs;
  RxString headingText = "Take a selfie!".obs;
  RxString subheadingText = "Take a clear picture of yourself by placing your face within the circle as shown.\n\nOpen the camera when ready!".obs;

  Rx<Status> cameraStatus = Status.camera_closed.obs;
  RxString imagePath = "".obs;

  @override
  void onInit() {
    super.onInit();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    print("permissin request");
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      print("permissin granted");
      await _initializeCamera();
    }else{
      openAppSettings();
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    print(cameras.length);
    final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    // final front = CameraDescription(name:frontCamera.name, lensDirection: frontCamera.lensDirection, sensorOrientation: -180);

    if(Platform.isAndroid) {
      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
    }else if(Platform.isIOS){
      cameraController = new CameraController(
        cameras[1],
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
    }

    cameraController.lockCaptureOrientation(DeviceOrientation.portraitUp);

    try {
      await cameraController.initialize();
      isCameraInitialized.value = true;
    } on CameraException catch (e) {
      print("Error initializing camera: ${e.code} ${e.description}");
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void changeStatus(Status status) {
    cameraStatus.value = status;
    print(status);
    switch (cameraStatus.value) {
      case Status.camera_closed:
        headingText.value = "Take a selfie!";
        subheadingText.value = "Take a clear picture of yourself by placing your face within the circle as shown.\n\nOpen the camera when ready!";

        buttonText.value = "Open Camera";
        break;
      case Status.camera_opened:
        headingText.value = "Take a selfie!";
        subheadingText.value = "Take a clear picture of yourself by placing your face within the circle as shown.\n\nOpen the camera when ready!";

        buttonText.value = "Take Picture";
        break;
      case Status.image_captured:
        headingText.value = "This is your picture!";
        subheadingText.value = "If you are not happy with the\npicture, you can take it again.";
        buttonText.value = "Looks Good!";
        break;
    }
    notifyChildrens();
  }

  Future<String?> captureImage() async {
    print('capture imge fun');

    // Take the picture using the camera and save it to the path
    try {
      await cameraController.takePicture().then((value) async {
        imagePath.value = value.path;
        print(imagePath.value);
        return imagePath.value;
      });
    } on CameraException catch (e) {
      print('Error taking picture: ${e.code} ${e.description}');
      return null;
    }
    return null;

    // Return the file
  }

  void goToSignature() {
    Get.off(() => const SignatureScreen(),
        binding: SignatureScreenBindings(), transition: Transition.rightToLeft);
  }

  Future<void> uploadImage() async {
    File newFile = File(imagePath.value);
    Map<String, dynamic> map = {};

    map["mobile"] = UserData.fromJson(GetStorage().read("USERDATA")).mobile!;
    String? mimeType = mime(newFile.path);
    String mimee = mimeType!.split('/')[0];
    String type = mimeType.split('/')[1];
    map["selfie_data"] = await dio.MultipartFile.fromFile(newFile.path,
        contentType: MediaType(mimee, type));

    await dioClient.uploadSelfie(map).then((value) {
      if(value.status==200){
        GetStorage().write("USERDATA", value.userData?.toJson());
      }
    }).onError((error, stackTrace) {});
  }
}
