import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/model/AnnualIncomeList.dart';
import 'package:bigul_ekyc/model/DigioResponse.dart';
import 'package:bigul_ekyc/model/EducationList.dart';
import 'package:bigul_ekyc/model/ExperienceList.dart';
import 'package:bigul_ekyc/model/GetPanDetailResponse.dart';
import 'package:bigul_ekyc/model/OccupationList.dart';
import 'package:bigul_ekyc/screen/bank/EnterBankScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/VerifyOtp.dart';

class OccupationDetailsController extends GetxController {
  DioClient dioClient;
  bool isKraVerified;
  String mobile;
  DigioResponse? digioResponse;
  GetPanDetailResponse? detailResponse;

  OccupationDetailsController({required this.dioClient,required this.isKraVerified,required this.mobile,required this.digioResponse,required this.detailResponse});

  RxBool isVisible = true.obs;

  Rx<ListItem?> isEducationSelected = ListItem().obs;
  Rx<ListItem?> isOccupationSelected = ListItem().obs;
  Rx<ListItem?> isAnnualIncomeSelected = ListItem().obs;
  Rx<ListItem?> isTradingSelected = ListItem().obs;

  RxBool isOccupationEditable = true.obs;
  RxBool isAnnualIncomeEditable = true.obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    await initiateListing();

    if(isKraVerified){
      if (detailResponse != null) {
        isOccupationSelected.value = occupationList.value.occupationList?.firstWhere((element) => element.name!.toUpperCase()==getOccupation(detailResponse?.root.kycData?.appOcc).toString().toUpperCase());
        isAnnualIncomeSelected.value = annualIncomeList.value.annualIncomeList?.firstWhere((element) => element.name!.toUpperCase()==getIncome(detailResponse?.root.kycData?.appIncome).toString().toUpperCase());
        isOccupationEditable.value = false;
        isAnnualIncomeEditable.value=false;

      }
    }else{
      if (digioResponse != null) {

      }
    }

  }


  void goToBank() {
    EventKeys.proceedBankVerification( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

    Get.off(() => const EnterBankScreen(),
        binding: EnterBankScreenBinding(), transition: Transition.rightToLeft);
  }

  Rx<EducationList> educationList = EducationList().obs;
  Rx<OccupationList> occupationList = OccupationList().obs;
  Rx<AnnualIncomeList> annualIncomeList = AnnualIncomeList().obs;
  Rx<ExperienceList> tradingExperienceList = ExperienceList().obs;

  Future<void> initiateListing() async {
    try {
      educationList.value = await dioClient.getEducationList();
      occupationList.value = await dioClient.getOccupationList();
      annualIncomeList.value = await dioClient.getAnnualIncomeList();
      tradingExperienceList.value = await dioClient.getTradingExperienceList();
    } finally {}
  }



  RxBool isOccupationValidate() {
    if (isEducationSelected.value?.name?.isEmpty??true) {
      return false.obs;
    } else if (isOccupationSelected.value?.name?.isEmpty??true) {
      return false.obs;
    } else if (isAnnualIncomeSelected.value?.name?.isEmpty??true) {
      return false.obs;
    } else if (isTradingSelected.value?.name?.isEmpty??true) {
      return false.obs;
    } else {
      return true.obs;
    }
  }

  void isOccupationMessage(BuildContext context) {
    if (isEducationSelected.value==null) {
      Fluttertoast.showToast(msg: "Please select education");
    } else if (isOccupationSelected.value==null) {
      Fluttertoast.showToast(msg: "Please select occupation");
    } else if (isAnnualIncomeSelected.value==null) {
      Fluttertoast.showToast(msg: "Please select annual income");
    } else if (isTradingSelected.value==null) {
      Fluttertoast.showToast(msg: "Please select trading experience");
    } else {
      postOccupation(context);
    }
  }

  Future<void> postOccupation(BuildContext context) async {
    FocusScope.of(context).unfocus();
    DialogUtils.showDialog(context);
    GetStorage().write("ANNUAL_INCOME", isAnnualIncomeSelected.value?.id!);
    await dioClient.occupation
      (
        mobile,
        isOccupationSelected.value?.id! ?? "",
        isOccupationSelected.value?.name!??"",
        isAnnualIncomeSelected.value?.id!??"",
        isAnnualIncomeSelected.value?.name!??"",
        isEducationSelected.value?.id!??"",
        isTradingSelected.value?.id!??""
    ).then((value) {
      DialogUtils.hideProgress(context);
      if (value.status == 200) {
        GetStorage().write("USERDATA", value.userData?.toJson());
        goToBank();
      }
    }).onError((error, stackTrace) {
      DialogUtils.hideProgress(context);
    });
  }

  getOccupation(String? appOcc) {
    switch (appOcc!) {
      case "01" :
        return "PRIVATE SECTOR SERVICE";
      case "02" :
        return "PUBLIC SECTOR";
      case "03" :
        return "BUSINESS";
      case "04" :
        return "PROFESSIONAL";
      case "05" :
        return "AGRICULTURIST";
      case "06" :
        return "RETIRED";
      case "07" :
        return "HOUSEWIFE";
      case "08" :
        return "STUDENT";
      case "09" :
        return "FOREX DEALER";
      case "10" :
        return "GOVERNMENT SERVICE";
      case "11" :
        return "PUBLIC SECTOR / GOVERNMENT SERVICE";
      case "99" :
        return "--";
      default :
        return "--";
    }
  }

  getIncome(String? appIncome) {
    switch (appIncome!) {
      case "01" :
        return "BELOW 1 LAC";
      case "02" :
        return "1-5 LAC";
      case "03" :
        return "5-10 LAC";
      case "04" :
        return "10-25 LAC";
      case "05" :
        return "> 25 LAC";
      case "06" :
        return "25 LAC - 1 CR";
      case "07" :
        return ">1 CR";
      case "10" :
        return "UPTO RS.5,00,000";
      case "11" :
        return "RS.5,00,001 TO RS.25,00,000";
      case "12" :
        return "RS.5,00,00,001 AND ABOVE";
      case "13" :
        return "RS.25,00,001 TO RS.1,00,00,000";
      case "14" :
        return "RS.1,00,00,001 TO RS.5,00,00,000";
      case "15" :
        return "UPTO RS.50,00,000";
      case "16" :
        return "RS.50,00,001 TO RS.2,50,00,000";
      case "17" :
        return "RS.2,50,00,001 TO RS.10,00,00,000";
      case "18" :
        return "RS.10,00,00,001 TO RS.50,00,00,000";
      case "19" :
        return "RS.50,00,00,001 AND ABOVE";
      default :
        return "--";
    }
  }
}
