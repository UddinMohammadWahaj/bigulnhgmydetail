import 'package:bigul_ekyc/api/EsignClient.dart';
import 'package:bigul_ekyc/api/KraClient.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/api/razor_client.dart';
import 'package:bigul_ekyc/model/BranchDetails.dart';
import 'package:bigul_ekyc/model/DigioResponse.dart';
import 'package:bigul_ekyc/model/GetPanDetailResponse.dart';
import 'package:bigul_ekyc/model/KraVerifiedCode.dart';
import 'package:bigul_ekyc/screen/adhaar_esign/AdhaarEsignController.dart';
import 'package:bigul_ekyc/screen/bank/controller/EnterBankController.dart';
import 'package:bigul_ekyc/screen/bank/controller/VerifyBankController.dart';
import 'package:bigul_ekyc/screen/bank_proof/controller/BankProofController.dart';
import 'package:bigul_ekyc/screen/congratulations/CongratulationsController.dart';
import 'package:bigul_ekyc/screen/email_mobile/controllers/EmailVerificationOtpController.dart';
import 'package:bigul_ekyc/screen/email_mobile/controllers/IntroScreenController.dart';
import 'package:bigul_ekyc/screen/email_mobile/controllers/MobileRegistrationController.dart';
import 'package:bigul_ekyc/screen/email_mobile/controllers/SplashController.dart';
import 'package:bigul_ekyc/screen/email_mobile/controllers/VerificationOtpController.dart';
import 'package:bigul_ekyc/screen/investment/controller/InvestmentController.dart';
import 'package:bigul_ekyc/screen/pan/controller/DigioController.dart';
import 'package:bigul_ekyc/screen/pan/controller/PanConfirmationController.dart';
import 'package:bigul_ekyc/screen/pan/controller/PanVerificationController.dart';
import 'package:bigul_ekyc/screen/personal/controller/OccupationDetailsController.dart';
import 'package:bigul_ekyc/screen/personal/controller/PersonalDetailsController.dart';
import 'package:bigul_ekyc/screen/segment/controller/SegmentDetailsController.dart';
import 'package:bigul_ekyc/screen/selfie/controller/SelfieController.dart';
import 'package:bigul_ekyc/screen/signature/controller/SignatureController.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'api/DigioClient.dart';
import 'screen/email_mobile/controllers/EmailVerificationController.dart';


class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

class IntroScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => IntroScreenController(dioClient : Get.find()));
  }
}

class VerificationOtpScreenBindings extends Bindings {
String number;
String? email;

VerificationOtpScreenBindings({required this.number,required this.email});

@override
void dependencies() {
  Get.lazyPut(()=> DioClient());
  Get.lazyPut(() => VerificationOtpController(number:number,email: email,dioClient: Get.find() ));
}
}

class EmailVerificationScreenBindings extends Bindings {
  String number;

  EmailVerificationScreenBindings({required this.number});

  @override
  void dependencies() {
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => EmailVerificationController(number:number,dioClient: Get.find()));
  }
}

class EmailVerificationOtpScreenBindings extends Bindings {
  String number;
  String email;

  EmailVerificationOtpScreenBindings({required this.number,required this.email});

  @override
  void dependencies() {
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => EmailVerificationOtpController(number:number,email:email,dioClient: Get.find() ));
  }
}

class MobileRegistrationScreenBinding extends Bindings {
  String email ;
  MobileRegistrationScreenBinding({required this.email});
  @override
  void dependencies() {
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => MobileRegistrationController(email:email,dioClient: Get.find()));
  }
}

class PanVerificationScreenBinding extends Bindings {
  String number;

  PanVerificationScreenBinding({required this.number});

  @override
  void dependencies() {
    Get.lazyPut(()=> KraClient());
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => PanVerificationController(number:number,kraClient: Get.find(),dioClient: Get.find()));
  }
}



class PanConfirmationScreenBinding extends Bindings {
  String panNumber;
  String dob;
  String? username;
  KraVerifiedCode? kraVerifiedCode;
  bool isKraVerified;

  PanConfirmationScreenBinding({required this.panNumber,required this.dob,required this.username,required this.kraVerifiedCode,required this.isKraVerified});

  @override
  void dependencies() {
    Get.lazyPut(()=> KraClient());
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => PanConfirmationController(panNumber:panNumber,kraClient: Get.find(),dob: dob,username:username??"",kraVerifiedCode:kraVerifiedCode,isKraVerified:isKraVerified));
  }
}

class DigioScreenBinding extends Bindings {
  String customer_email;
  String customer_name;
String mobile;
  DigioScreenBinding({required this.customer_email,required this.customer_name,required this.mobile});

  @override
  void dependencies() {
    Get.lazyPut(()=> DigioClient());
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => DigioController(digioClient: Get.find(),dioClient: Get.find(),customer_email: customer_email,customer_name: customer_name,mobile: mobile));
  }
}

class EnterBankScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> RazorClient());
    Get.lazyPut(() => EnterBankController(razorClient : Get.find()));
  }
}
class VerifyBankScreenBinding extends Bindings {
  BranchDetails branchDetails;

  VerifyBankScreenBinding({required this.branchDetails});

  @override
  void dependencies() {
    Get.lazyPut(() => RazorClient());
    Get.lazyPut(() => DigioClient());
    Get.lazyPut(() => DioClient());
    Get.lazyPut(() =>
        VerifyBankController(
          dioClient: Get.find(),
            razorClient: Get.find(), branchDetails: branchDetails
            , digioClient : Get.find()));
  }
}

class PersonalDetailsScreenBinding extends Bindings {
  DigioResponse? digioResponse;
  GetPanDetailResponse? detailResponse;
  bool isKraVerified;

  PersonalDetailsScreenBinding({required this.digioResponse,required this.detailResponse,required this.isKraVerified});

  @override
  void dependencies() {
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => PersonalDetailsController(dioClient: Get.find(),digioResponse:digioResponse,detailResponse:detailResponse,isKraVerified:isKraVerified));
  }
}

class OccupationDetailsScreenBinding extends Bindings {
  bool isKraVerified;
String mobile;
  DigioResponse? digioResponse;
  GetPanDetailResponse? detailResponse;
  OccupationDetailsScreenBinding({required this.isKraVerified,required this.mobile,required this.digioResponse,required this.detailResponse});

  @override
  void dependencies() {
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => OccupationDetailsController(dioClient: Get.find(),isKraVerified:isKraVerified,mobile: mobile,digioResponse:digioResponse,detailResponse:detailResponse));
  }
}

class SegmentDetailsScreenBinding extends Bindings {
  String mobile;
  SegmentDetailsScreenBinding({required this.mobile});
  @override
  void dependencies() {
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => SegmentDetailsController(dioClient : Get.find(),mobile: mobile));
  }
}

class InvestmentDetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => InvestmentDetailsController(dioClient : Get.find()));
  }
}

class BankProofScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => BankProofController(dioClient : Get.find()));
  }
}

class SelfieScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => SelfieController(dioClient : Get.find()));
  }
}

class SignatureScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> DioClient());
    Get.lazyPut(() => SignatureController(dioClient : Get.find()));
  }
}

class AdhaarEsignScreenBindings extends Bindings {

  String mobile;
  bool callBefore;
  String pan;
  AdhaarEsignScreenBindings({required this.mobile, required this.callBefore,required this.pan });
  @override
  void dependencies() {
    Get.lazyPut(() => DioClient());
    Get.lazyPut(() => EsignClient());
    Get.lazyPut(() =>
        AdhaarEsignController(dioClient: Get.find(), esignClient: Get.find(),mobile: mobile,callBefore:callBefore,pan: pan));
  }
}


class CongratulationsScreenBindings extends Bindings {
  String mobile;
  CongratulationsScreenBindings({required this.mobile});
  @override
  void dependencies() {
    Get.lazyPut(() => DioClient());
    Get.lazyPut(() => CongratulationsController(dioClient: Get.find(),mobile: mobile));
  }
}

