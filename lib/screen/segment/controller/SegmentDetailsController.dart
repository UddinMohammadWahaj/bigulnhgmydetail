import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/screen/investment/InvestementDetailsScreen.dart';
import 'package:bigul_ekyc/screen/segment/controller/SegmentData.dart';
import 'package:bigul_ekyc/screen/selfie/SelfieScreen.dart';
import 'package:bigul_ekyc/screen/signature/SignatureScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/VerifyOtp.dart';

class SegmentDetailsController extends GetxController {
  DioClient dioClient;
  String mobile;
  SegmentDetailsController({required this.dioClient,required this.mobile});


  RxList<SegmentHeader> items = <SegmentHeader>[
    SegmentHeader(
        header: "I agree to trade in these segments",
        isExpanded: true,
        list: [
          ListElement(type: "cb", text: "NSE Equity", isChecked: true),
          ListElement(type: "cb", text: "BSE Equity", isChecked: true),
          ListElement(type: "cb", text: "Futures & Options", isChecked: false),
          ListElement(
              type: "cb", text: "Commodities & Currency", isChecked: false),
          ListElement(type: "cb", text: "Mutual Funds", isChecked: true)
        ]),
    SegmentHeader(
        header:
            "I provide my authorization to Bigul for Demat Debit and Pledge Instruction",
        isExpanded: true,
        list: [
          ListElement(
              type: "cb", text: "Settlement Transactions", isChecked: true),
          ListElement(
              type: "cb", text: "Margin Pledge Transactions ", isChecked: true),
          ListElement(
              type: "cb", text: "Mutual Fund Transactions ", isChecked: true),
          ListElement(type: "cb", text: "Tendering Shares", isChecked: true)
        ]),
    SegmentHeader(
        header: "Declaration and preferences", isExpanded: true, list: [
      ListElement(type: "cb",text: "I declare that I am a resident of India for tax purposes as per FATCA & CRS compliance.",isChecked: true),
      ListElement(type: "cb",text: "I would like to receive dividend interest directly into my bank account",isChecked: true),
      ListElement(type: "cb",text: "I authorize Bonanza Portfolio Limited to proceed on all pledge instructions without additional confirmation from me",isChecked: true),
      ListElement(type: "cb",text: "I request you to send electronic transaction-cum holding statement at the email id",isChecked: true),
      ListElement(type: "cb",text: "I would like to share my email ID with the Registrar and Transfer Agent",isChecked: true),
      ListElement(type: "cb",text: "I would like to receive annual reports",isChecked: true),
      ListElement(type: "cb",text: "I would not like to receive Delivery Instruction Slip (DIS)",isChecked: true),
      ListElement(type: "cb",text: "Nominee not required",isChecked: true),

      ListElement(type: "text",text: "I request you to send my account statement on my registered email address",isChecked: true,radiolist:["Daily","Weekly",	"Fortnightly",	"Monthly"],selectedRadio:"Monthly" ),
      ListElement(type: "text",text: "Send me Contract note and Standard Documents",isChecked: true,radiolist:["Electronically"	,"Physical",	"Both"],selectedRadio: "Electronically")

    ]),
  ].obs;


  RxBool isAccept = false.obs;
  RxBool isComdtChek = false.obs;
  RxBool isFOChek = false.obs;
  RxBool isAnnualGreater = false.obs;

  void goToInvestment() {
    Get.off(() => const InvestmentDetailsScreen(),
        binding: InvestmentDetailsScreenBinding(),
        transition: Transition.rightToLeft);
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

  Future<void> segment(BuildContext context) async {
    FocusScope.of(context).unfocus();
    DialogUtils.showDialog(context);
    int stage =
    UserData.fromJson(GetStorage().read("USERDATA")).jsonData==null?
        //is kra
    isComdtChek.value||isFOChek.value||isAnnualGreater.value? 7 :8
        :
      //is digio
    isComdtChek.value||isFOChek.value||isAnnualGreater.value? 7 : 9

    ;


    await dioClient.postSegements(mobile,stage).then((value) {
      DialogUtils.hideProgress(context);
      if (value.status == 200) {
        GetStorage().write("USERDATA", value.userData?.toJson());
      }

    }).onError((error, stackTrace) {
      DialogUtils.hideProgress(context);
    });
  }

  @override
  void onInit() {

    super.onInit();
    if(GetStorage().read("ANNUAL_INCOME") !=null){
      if(int.parse(GetStorage().read("ANNUAL_INCOME"))>3){
        isAnnualGreater.value = true;
      }else{
        isAnnualGreater.value = false;
      }
    }

  }

}

class ExpansionPanelItem {
  String headerValue;
  List<String> expandedValue;
  bool isExpanded;

  ExpansionPanelItem({
    required this.headerValue,
    required this.expandedValue,
    required this.isExpanded,
  });
}
