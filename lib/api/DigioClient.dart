import 'package:bigul_ekyc/model/BankValidation.dart';
import 'package:bigul_ekyc/model/DigioResponse.dart';
import 'package:bigul_ekyc/model/GetDigioData.dart';
import 'package:dio/dio.dart';


import 'logger_interceptors.dart';

const String baseUrl = "https://api.digio.in/";

class DigioClient {
  late final Dio _dio;

  DigioClient()
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

  Future<BankValidation> bankValidaate(
      String beneficiaryAccountNo,String beneficiaryIfsc) async {
    final data = <String, dynamic>{
      "beneficiary_account_no":beneficiaryAccountNo,
      "beneficiary_ifsc":beneficiaryIfsc,
    };
    final response = await _dio.post('client/verify/bank_account/',
        options: Options(
            contentType: Headers.jsonContentType,
          headers: {
              "Authorization" : "Basic QUlLR1g2RVpFVDMyNDEzSzY4NDhTTUlGMU40VU1TQlE6SE1ROFJFUEI4TkU2SzJJTFRGSlFPOVQ1WFk4QUJDR0M="
          }
        ),
        data: data);
   return BankValidation.fromJson(response.data);

  }


  Future<GetDigioData> getDigioData(
      String customerIdentifier,String customerName ) async {
    final data = <String, dynamic>{
      "customer_identifier":customerIdentifier,
      "customer_name":customerName,
      "template_name":"TESTDIGILOCKER",
      "notify_customer":true
    };
    final response = await _dio.post('client/kyc/v2/request/with_template',
        options: Options(
            contentType: Headers.jsonContentType,
            headers: {
              "Authorization" : "Basic QUlLR1g2RVpFVDMyNDEzSzY4NDhTTUlGMU40VU1TQlE6SE1ROFJFUEI4TkU2SzJJTFRGSlFPOVQ1WFk4QUJDR0M="
            }
        ),
        data: data);
    return GetDigioData.fromJson(response.data);

  }



  Future<DigioResponse> getDigioDataResponse(
      String docId ) async {
    final response = await _dio.post('client/kyc/v2/$docId/response',
        options: Options(
            contentType: Headers.jsonContentType,
            headers: {
              "Authorization" : "Basic QUlLR1g2RVpFVDMyNDEzSzY4NDhTTUlGMU40VU1TQlE6SE1ROFJFUEI4TkU2SzJJTFRGSlFPOVQ1WFk4QUJDR0M="
            }
        ),
      data: {}
       );
    return DigioResponse.fromJson(response.data);

  }




}
