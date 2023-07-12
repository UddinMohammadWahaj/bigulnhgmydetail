import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/DigioClient.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/api/logger_interceptors.dart';
import 'package:bigul_ekyc/api/razor_client.dart';
import 'package:bigul_ekyc/dialogs/DialogManager.dart';
import 'package:bigul_ekyc/model/BranchDetails.dart';
import 'package:bigul_ekyc/model/VerifyOtp.dart';
import 'package:bigul_ekyc/screen/bank_proof/BankProofScreen.dart';
import 'package:bigul_ekyc/screen/segment/SegmentDetailsScreen.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VerifyBankController extends GetxController {
  RazorClient razorClient;
  DigioClient digioClient;
  DioClient dioClient;
  BranchDetails branchDetails;

  VerifyBankController({required this.dioClient,required this.razorClient,required this.digioClient,required this.branchDetails});


  TextEditingController confirmBankAccountNo = TextEditingController();
  TextEditingController bankAccountNo= TextEditingController();
  RxBool isSame = false.obs;
  RxBool isBankVisible = false.obs;
  @override
  void onInit() {
    super.onInit();
    bankAccountNo.addListener(() {
      EventKeys.enterBankAccountNo( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);
    });

    confirmBankAccountNo.addListener(() {
      EventKeys.enterConfirmBankAccountNo( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

      if(bankAccountNo.text==confirmBankAccountNo.text &&bankAccountNo.text.isNotEmpty){
        isSame.value = true;
      }else{
        isSame.value = false;
      }
    });
  }

  Future<void> goToPennyVerification(BuildContext context) async {
    DialogManager.showPennyVerificationDialog(context);

    await digioClient.bankValidaate(confirmBankAccountNo.text, branchDetails.ifsc!).then((value) {
      EventKeys.verifyBankAccoutNo( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

      DialogManager.hideDialog();
     if(value.verified==true){
       final username =  GetStorage().read("USERNAME");
       if (username != null) {
         DialogManager.showBankVerfiedDialog(context,branchDetails,username).then((value) async{
           if (value == true) {
             EventKeys.bankVerified( UserData.fromJson(GetStorage().read("USERDATA")).mobile!);

             await dioClient.saveBank(UserData.fromJson(GetStorage().read("USERDATA")).mobile!,
                 branchDetails.ifsc!.trim(),
                 confirmBankAccountNo.text,
                 username,
                 branchDetails.bank!.trim(),
                 branchDetails.address!.trim()).then((value) {

               if(value.status==200) {
                 Get.off(() => const SegmentDetailsScreen(),
                   binding: SegmentDetailsScreenBinding(mobile: UserData.fromJson(GetStorage().read("USERDATA")).mobile!),
                   transition: Transition.rightToLeft);
               }else{
                 Fluttertoast.showToast(msg: value.msg!);
               }

             });



           }
         });
       }

     }else{
       DialogManager.showBankNotVerfiedDialog(context).then((value) {
         Get.off(() => const BankProofScreen(),
             binding: BankProofScreenBinding(),
             transition: Transition.rightToLeft);
       });
     }
    }).onError((DioError error, stackTrace) {
      DialogManager.hideDialog();
      Fluttertoast.showToast(msg: LoggerInterceptor.parseErrorMessage(error.response.toString()));
    });




  }
}




class MinLengthTextInputFormatter extends TextInputFormatter {
  final int minLength;

  MinLengthTextInputFormatter(this.minLength);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length < minLength) {
      return oldValue;
    }
    return newValue;
  }
}
