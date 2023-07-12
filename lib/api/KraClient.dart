import 'package:bigul_ekyc/model/KraVerifiedCode.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';


import 'logger_interceptors.dart';

const String baseUrl = "https://www.cvlkra.com/PanInquiry.asmx/";

class KraClient {
  late final Dio _dio;

  KraClient()
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

  Future<XmlDocument> GetPanStatus(
      String pan) async {
    final data = <String, dynamic>{
      "panNo":pan,
      "userName":"EKYC",
      "PosCode":"1200000235",
      "password":"TtLQruP6Gbjv3ReRDA8n6Q%3d%3d",
      "PassKey":"m2a22",
    };

    final response = await _dio.post('GetPanStatus',
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: data);

    if (response.statusCode == 200) {
      print("data ${response.data}");
      final document = XmlDocument.parse(response.data);
      print("docuemnt $document");
      return document;
    } else {
      throw Exception('Failed to fetch data');
    }

  }


  Future<XmlDocument> GetPanDetails(
      String pan,
      String dob,
      KraVerifiedCode kraVerifiedCode) async {
    final data = <String, dynamic>{
      "panNo":pan,
      "userName":"EKYC",
      "PosCode":"1200000235",
      "password":"TtLQruP6Gbjv3ReRDA8n6Q%3d%3d",
      "PassKey":"m2a22",
      "inputXML":"<APP_REQ_ROOT><APP_PAN_INQ><APP_PAN_NO>$pan</APP_PAN_NO><APP_DOB_INCORP>$dob</APP_DOB_INCORP><APP_POS_CODE>1200000235</APP_POS_CODE><APP_RTA_CODE>1200000235</APP_RTA_CODE><APP_KRA_CODE>${kraVerifiedCode.codename}</APP_KRA_CODE><FETCH_TYPE>I</FETCH_TYPE></APP_PAN_INQ></APP_REQ_ROOT>"
    };

    final response = await _dio.post('SolicitPANDetailsFetchALLKRA',
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: data);

    if (response.statusCode == 200) {
      print("data ${response.data}");
      final document = XmlDocument.parse(response.data);
      print("docuemnt $document");
      return document;
    } else {
      throw Exception('Failed to fetch data');
    }

  }





}
