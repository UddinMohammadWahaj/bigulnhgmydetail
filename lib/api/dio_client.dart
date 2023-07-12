import 'package:bigul_ekyc/model/AnnualIncomeList.dart';
import 'package:bigul_ekyc/model/DigioResponse.dart';
import 'package:bigul_ekyc/model/EducationList.dart';
import 'package:bigul_ekyc/model/ExperienceList.dart';
import 'package:bigul_ekyc/model/LoginWithOtp.dart';
import 'package:bigul_ekyc/model/OccupationList.dart';
import 'package:bigul_ekyc/model/PanVerificationResponse.dart';
import 'package:bigul_ekyc/model/SavePersonalRequest.dart';
import 'package:bigul_ekyc/model/VerifyOtp.dart';
import 'package:bigul_ekyc/screen/congratulations/CongratulationsController.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import 'logger_interceptors.dart';

const String baseUrl = "https://bigul.app/api/";

class DioClient {
  late final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 30000),
            receiveTimeout: const Duration(seconds: 10000),
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
            LoggerInterceptor(),
          ]);

  Future<LoginWithOtp> login(
      String mobile) async {
    final response = await _dio.post('login-signup',
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        followRedirects: true),
        data: {
          "mobile": mobile,
          "mx_Source_URL": "bigul.app",
        });
    return LoginWithOtp.fromJson(response.data);
  }

  Future<VerifyOtp> verifyOtp(
      String mobile,String email,String otp) async {
    Object? data = email=="" ? {
      "mobile": mobile,
      "motp":otp
    }: {
      "mobile": mobile,
      "motp":otp,
      "email": email
    };

    final response = await _dio.post('verify-otp',
        options: Options(contentType: Headers.jsonContentType),
        data: data);
    return VerifyOtp.fromJson(response.data);
  }

  Future<LoginWithOtp> verifyEmailOtp(
      String mobile,String email,String otp) async {
    final response = await _dio.post('verify-email-otp',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "mobile": mobile,
          "email":email,
          "otp":otp
        });
    return LoginWithOtp.fromJson(response.data);
  }

  Future<LoginWithOtp> sendEmailVerificationLink(
      String mobile,String email) async {
    final response = await _dio.post('send-verification-otp',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "mobile": mobile,
          "email":email
        });
    return LoginWithOtp.fromJson(response.data);
  }

  Future<LoginWithOtp> resendOTP(
      String mobile,
      String email,
      String type
      ) async {
    Object? data = type=="mobile" ? {
      "mobile": mobile,
      "type":"mobile"
    }: {
      "mobile": mobile,
      "email": email,
      "type":"email"
    };
    final response = await _dio.post('resend-otp',
        options: Options(contentType: Headers.jsonContentType),
        data: data);
    return LoginWithOtp.fromJson(response.data);
  }

  Future<PanVerificationResponse> panVerification(
      String mobile,String pan,String dob) async {
    final response = await _dio.post('pan-verification',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "mobile":mobile,
          "pan":pan,
          "dob":dob,
          "current_stage":"1"
        });
    return PanVerificationResponse.fromJson(response.data);
  }

  Future<VerifyOtp> saveBank(
      String mobile,String ifsc,String account,String holder,String bankName,String address) async {
    final response = await _dio.post('save-bank-details',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "mobile":mobile,
          "ifsc":ifsc,
          "account":account,
          "accountHolderName":holder,
          "bankName":bankName,
          "bankAddress":address
        });
    return VerifyOtp.fromJson(response.data);
  }

  Future<EducationList> getEducationList(
      ) async {
    final response = await _dio.get('education-list',
        options: Options(contentType: Headers.jsonContentType),
        data: {

        });
    return EducationList.fromJson(response.data);
  }

  Future<OccupationList> getOccupationList(
      ) async {
    final response = await _dio.get('occupation-list',
        options: Options(contentType: Headers.jsonContentType),
        data: {

        });
    return OccupationList.fromJson(response.data);
  }

  Future<AnnualIncomeList> getAnnualIncomeList(
     ) async {
    final response = await _dio.get('annual-income-list',
        options: Options(contentType: Headers.jsonContentType),
        data: {

        });
    return AnnualIncomeList.fromJson(response.data);
  }

  Future<ExperienceList> getTradingExperienceList(
     ) async {
    final response = await _dio.get('experience-list',
        options: Options(contentType: Headers.jsonContentType),
        data: {

        });
    return ExperienceList.fromJson(response.data);
  }


  Future<VerifyOtp> uploadSelfie(map)async {
    final formData = FormData.fromMap(map);
    final response = await _dio.post('capture-selfie',
        data:formData);
    return VerifyOtp.fromJson(response.data);
  }

  Future<VerifyOtp> incomeProof(map)async {
    final formData = FormData.fromMap(map);
    final response = await _dio.post('income-proof',
        data:formData);
    return VerifyOtp.fromJson(response.data);
  }

  Future<VerifyOtp> bankProof(map)async {
    final formData = FormData.fromMap(map);
    final response = await _dio.post('bank-proof',
        data:formData);
    return VerifyOtp.fromJson(response.data);
  }

 Future<VerifyOtp> clientSignature(map)async {
    final formData = FormData.fromMap(map);
    final response = await _dio.post('client-signature',
        data:formData);
    return VerifyOtp.fromJson(response.data);
  }

  Future<VerifyOtp> beforeEsign(
      String mobile
      ) async {
    final response = await _dio.post('before-esign',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "mobile": mobile,
          "utmGetData":[]
        });
    return VerifyOtp.fromJson(response.data);
  }

  Future<VerifyOtp> afterEsign(
     String mobile ) async {
    final response = await _dio.post('after-esign',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "mobile":mobile,
          "esign_status":1
        });
    return VerifyOtp.fromJson(response.data);
  }

  Future<VerifyOtp> postSegements(String mobile,int stage
      ) async {
    final response = await _dio.post('ddpi-segment-details',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "mobile":mobile,
          "ddpi":"Yes",
          "t_type":"All transactions",
          "stage": stage,
        });
    return VerifyOtp.fromJson(response.data);
  }

  Future<VerifyOtp> occupation(
      String mobile,
      String occId,String occName,String annId,String annName,String eduId,String expId
      ) async {
    final response = await _dio.post('save-occupation-details',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "mobile":mobile,
          "occupation": "11",
          "occupation_name": "Others",
          "annualincome": "6",
          "annualincome_name": ">1 CR",
          "educationId": "2",
          "experience": "1"
        });
    return VerifyOtp.fromJson(response.data);
  }

  Future<VerifyOtp> saveDigilockerData(
      String mobile,
    String? crnNumber,
    String? responseId,
    String? responseActionId,
    DigioResponse? jsonData,
  ) async {
    final response = await _dio.post('digilocker-data',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "mobile": mobile,
          "crn_number": crnNumber,
          "response_id": responseId,
          "response_action_id": responseActionId,
          "json_data": jsonData?.toJson(),
        });
    return VerifyOtp.fromJson(response.data);
  }

  Future<VerifyOtp> savePersonalData(
   SavePersonalRequest savePersonalRequest
  ) async {
    final response = await _dio.post('save-personal-details',
        options: Options(contentType: Headers.jsonContentType),
        data: savePersonalRequest.toJson());
    return VerifyOtp.fromJson(response.data);
  }

  Future<VerifyOtp> welcomeSurvey(String mobile,List<Interest> list
  ) async {

    final response = await _dio.post('welcome-survey',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "mobile":mobile,
          "automated_trading" : list[0].isSelected! ? 1 :0,
          "equity_baskets" : list[1].isSelected! ? 1 :0,
          "chart_analysis" : list[2].isSelected! ? 1 :0,
          "debt_products" : list[3].isSelected! ? 1 :0
        });
    return VerifyOtp.fromJson(response.data);
  }
}
