import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/model/DigioResponse.dart';
import 'package:bigul_ekyc/model/GetPanDetailResponse.dart';
import 'package:bigul_ekyc/model/SavePersonalRequest.dart';
import 'package:bigul_ekyc/model/VerifyOtp.dart';
import 'package:bigul_ekyc/screen/personal/OccupationlDetailsScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PersonalDetailsController extends GetxController {
  DioClient dioClient;
  DigioResponse? digioResponse;
  GetPanDetailResponse? detailResponse;
  bool isKraVerified;

  PersonalDetailsController(
      {required this.dioClient,
      required this.digioResponse,
      required this.detailResponse,
      required this.isKraVerified});

  RxString genderSelected = "".obs;
  RxString maritalSelected = "".obs;
  TextEditingController fatherSpouseController = TextEditingController();
  TextEditingController cityOfBirthController = TextEditingController();

  RxBool isGenderEditable = true.obs;
  RxBool isMaritalEditable = true.obs;
  RxBool isFatherEditable = true.obs;
  RxBool isCityEditable = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (isKraVerified) {
      if (detailResponse != null) {
        genderSelected.value = getGender(detailResponse?.root.kycData?.appGen?? "M") ;
        maritalSelected.value = getMaritalStatus(
            detailResponse?.root.kycData?.appMarStatus ?? "02");
        cityOfBirthController.text =
            detailResponse?.root.kycData?.appPerCity ?? "";
        fatherSpouseController.text =
            detailResponse?.root.kycData?.appFName ?? "";

        isGenderEditable.value = false;
       isMaritalEditable.value = false;
       isFatherEditable .value = fatherSpouseController.text.isEmpty?true:false;
       isCityEditable.value = cityOfBirthController.text.isEmpty?true:false;


      } else {
        Fluttertoast.showToast(msg: "Data not found");
      }
    } else {
      if (digioResponse != null) {
        genderSelected.value =
            digioResponse?.actions?[0].details?.aadhaar?.gender == "M"
                ? "Male"
                : "Female";
        cityOfBirthController.text = digioResponse?.actions?[0].details?.aadhaar
                ?.permanentAddressDetails?.districtOrCity ??
            "";

        isGenderEditable.value = false;
        isFatherEditable .value = fatherSpouseController.text.isEmpty?true:false;
        isCityEditable.value = cityOfBirthController.text.isEmpty?true:false;

        fatherSpouseController.addListener(() {
          EventKeys.fatherSpouse(
              UserData.fromJson(GetStorage().read("USERDATA")).mobile!);
        });

        cityOfBirthController.addListener(() {
          EventKeys.cityOfBirth(
              UserData.fromJson(GetStorage().read("USERDATA")).mobile!);
        });
      } else {
        Fluttertoast.showToast(msg: "Data not found");
      }
    }
  }

  RxBool isPersonalValidate() {
     if (genderSelected.value.isEmpty) {
      return false.obs;
    } else if (maritalSelected.value.isEmpty) {
       return false.obs;
     } else if (fatherSpouseController.text.isEmpty) {
       return false.obs;
     } else if (cityOfBirthController.text.isEmpty) {
       return false.obs;
     } else {
       return true.obs;
     }
  }

  void isPersonalMessage(BuildContext context) {
    if (genderSelected.value.isEmpty) {
      Fluttertoast.showToast(msg: "Please select gender");
    } else if (maritalSelected.value.isEmpty) {
      Fluttertoast.showToast(msg: "Please select marital status");
    } else if (fatherSpouseController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter father/spouse name");
    } else if (cityOfBirthController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter city of birth");
    } else {
      if (isKraVerified) {
        saveKraPersonalData(context);
      } else {
        saveDigioPersonalData(context);
      }
    }
  }

  String smallAddress(String? bigSentence) {
    if (bigSentence == null) return "";
    if (bigSentence.length > 30) {
      return bigSentence.substring(0, 29);
    } else {
      return bigSentence ?? "";
    }
  }

  Future<void> saveDigioPersonalData(BuildContext context) async {
    if (digioResponse != null) {
      SavePersonalRequest savePersonalRequest = SavePersonalRequest(
        mobile: UserData.fromJson(GetStorage().read("USERDATA")).mobile!,
        panNo: digioResponse?.actions![0].details?.pan?.idNumber,
        birthDate: digioResponse?.actions![0].details?.pan?.dob,
        marital: maritalSelected.value.toString(),
        familyType: "Father",
        fatherSpouse: fatherSpouseController.text,
        birthplace: cityOfBirthController.text,
        gender: genderSelected.value.substring(0, 1),
        aadhar: digioResponse?.actions![0].details?.aadhaar?.idNumber,
        city: digioResponse?.actions![0].details?.aadhaar
            ?.permanentAddressDetails?.districtOrCity,
        state: digioResponse
            ?.actions![0].details?.aadhaar?.permanentAddressDetails?.state,
        pincode: digioResponse
            ?.actions![0].details?.aadhaar?.permanentAddressDetails?.pincode,
        apiType: "1",
        crAddr1: smallAddress(digioResponse
            ?.actions![0].details?.aadhaar?.currentAddressDetails?.address),
        crAddr2: smallAddress(digioResponse
            ?.actions![0].details?.aadhaar?.currentAddressDetails?.address),
        crAddr3: smallAddress(digioResponse
            ?.actions![0].details?.aadhaar?.currentAddressDetails?.address),
        crPinCode: digioResponse
            ?.actions![0].details?.aadhaar?.currentAddressDetails?.pincode,
        prAddr1: smallAddress(digioResponse
            ?.actions![0].details?.aadhaar?.permanentAddressDetails?.address),
        prAddr2: smallAddress(digioResponse
            ?.actions![0].details?.aadhaar?.permanentAddressDetails?.address),
        prAddr3: smallAddress(digioResponse
            ?.actions![0].details?.aadhaar?.permanentAddressDetails?.address),
        crCity: digioResponse?.actions![0].details?.aadhaar
            ?.currentAddressDetails?.districtOrCity,
        crState: digioResponse
            ?.actions![0].details?.aadhaar?.currentAddressDetails?.state,
        prCity: digioResponse?.actions![0].details?.aadhaar
            ?.permanentAddressDetails?.districtOrCity,
        prState: digioResponse
            ?.actions![0].details?.aadhaar?.permanentAddressDetails?.state,
        prPinCode: digioResponse
            ?.actions![0].details?.aadhaar?.permanentAddressDetails?.pincode,
      );


      FocusScope.of(context).unfocus();
      DialogUtils.showDialog(context);
      await dioClient.savePersonalData(savePersonalRequest).then((value) {
        DialogUtils.hideProgress(context);
        if (value.status == 200) {
          GetStorage().write("USERDATA", value.userData?.toJson());
          goToOccupation();
        }
      }).onError((error, stackTrace) {
        DialogUtils.hideProgress(context);
      });
    }
  }

  void goToOccupation() {
    Get.off(() => const OccupationDetailsScreen(),
        binding: OccupationDetailsScreenBinding(
            isKraVerified: false,
            mobile: UserData.fromJson(GetStorage().read("USERDATA")).mobile! ,detailResponse: detailResponse,
            digioResponse: digioResponse),
        transition: Transition.rightToLeft);
  }

  getMaritalStatus(String? appMarStatus) {
    switch (appMarStatus!) {
      case "01":
        return "Married";
      case "02":
        return "Single";
      default:
        return "Not Available";
    }
  }

  getNationality(String? appNationality) {
    switch (appNationality!) {
      case "01":
        return "Indian";
      case "02":
        return "Other";
      default:
        return "Not Available";
    }
  }

  getIPVstatus(String? appIpvFlag) {
    switch (appIpvFlag!) {
      case "Y":
        return "Yes";
      case "N":
        return "No";
      case "E":
        return "Exempted";
      default:
        return "Not Available";
    }
  }

  getGender(String? appGen) {
    switch (appGen!) {
      case "M":
        return "Male";
      case "F":
        return "Female";
      default:
        return "M";
    }
  }

  Future<void> saveKraPersonalData(BuildContext context) async {
    SavePersonalRequest savePersonalRequest = SavePersonalRequest(
      mobile: UserData.fromJson(GetStorage().read("USERDATA")).mobile!,
      panNo: detailResponse!.root.kycData?.appPanNo,
      birthDate: detailResponse!.root.kycData?.appDate,
      marital: getMaritalStatus(detailResponse!.root.kycData?.appMarStatus)
          .toString(),
      familyType: "Father",
      fatherSpouse: detailResponse!.root.kycData?.appFName,
      birthplace: detailResponse!.root.kycData?.appPerCity,
      gender: getGender(detailResponse!.root.kycData?.appGen)
          .toString()
          .substring(0, 1),
      aadhar: detailResponse!.root.kycData?.appCorAddRef,
      city: detailResponse!.root.kycData?.appPerCity,
      state: detailResponse!.root.kycData?.appPerState,
      pincode: detailResponse!.root.kycData?.appPerPincd,
      apiType: "1",
      crAddr1: smallAddress(detailResponse!.root.kycData!.appCorAdd1 ?? ""),
      crAddr2: smallAddress(detailResponse!.root.kycData!.appCorAdd2 ?? ""),
      crAddr3: smallAddress(detailResponse!.root.kycData!.appCorAdd3 ?? ""),
      crPinCode: detailResponse!.root.kycData?.appCorPincd,
      prAddr1: smallAddress(detailResponse!.root.kycData!.appPerAdd1 ?? ""),
      prAddr2: smallAddress(detailResponse!.root.kycData!.appPerAdd2 ?? ""),
      prAddr3: smallAddress(detailResponse!.root.kycData!.appPerAdd3 ?? ""),
      crCity: detailResponse!.root.kycData?.appCorCity,
      crState: detailResponse!.root.kycData?.appCorState,
      prCity: detailResponse!.root.kycData?.appPerCity,
      prState: detailResponse!.root.kycData?.appPerState,
      prPinCode: detailResponse!.root.kycData?.appPerPincd,
    );
    FocusScope.of(context).unfocus();
    DialogUtils.showDialog(context);
    await dioClient.savePersonalData(savePersonalRequest).then((value) {
      DialogUtils.hideProgress(context);
      if (value.status == 200) {
        GetStorage().write("USERDATA", value.userData?.toJson());

        Get.off(() => const OccupationDetailsScreen(),
            binding: OccupationDetailsScreenBinding(
                isKraVerified: isKraVerified,
                mobile: UserData.fromJson(GetStorage().read("USERDATA")).mobile!
            ,detailResponse: detailResponse,
              digioResponse: digioResponse
            ),

            transition: Transition.rightToLeft);
      } else {
        Fluttertoast.showToast(msg: value.msg!);
      }
    }).onError((error, stackTrace) {
      DialogUtils.hideProgress(context);
    });
  }
}
