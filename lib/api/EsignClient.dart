import 'dart:io';

import 'package:bigul_ekyc/model/EsignGetDetails.dart';
import 'package:bigul_ekyc/model/EsignGetDid.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'logger_interceptors.dart';

const String baseUrl = "https://dkyc.bonanzaonline.com/ekycapi/";

class EsignClient {
  late final Dio _dio;

// create a custom HttpClient with a BadCertificateHttpClientAdapter
  final httpClient = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  EsignClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 30000),
            receiveTimeout: const Duration(seconds: 10000),
            responseType: ResponseType.json,
          ),
        )
          ..interceptors.addAll([
            LoggerInterceptor(),
          ]);


  Future<EsignGetDetails> getDetails(String panNumber) async {
    if(!kIsWeb){
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }


    final formData = FormData.fromMap({"pan": panNumber});
    final response = await _dio.post('getDetails',
        options:
            Options(contentType: Headers.formUrlEncodedContentType, headers: {
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjFhMGI1OTI2ZGM4ZDFlN2M1NmE0NTcyZmQwNGI3MDQ0YThhZDUyNWVlMTVlODQ0ZmFlMWFmN2VjNTlmZTQyODY5NWFmYmUwZGFhMjc0MzE3In0.eyJhdWQiOiI1IiwianRpIjoiMWEwYjU5MjZkYzhkMWU3YzU2YTQ1NzJmZDA0YjcwNDRhOGFkNTI1ZWUxNWU4NDRmYWUxYWY3ZWM1OWZlNDI4Njk1YWZiZTBkYWEyNzQzMTciLCJpYXQiOjE2NjU5ODgwOTcsIm5iZiI6MTY2NTk4ODA5NywiZXhwIjoxNjk3NTI0MDk3LCJzdWIiOiIxMiIsInNjb3BlcyI6W119.iLJnrTlZqVpDV-ipc7RH5u3bdK6yB9cOEBcityOMBK8n-nH__c5ITO4MHHc0xaDcxTvIxC8L4GJ7FzJqrol2fdMkjIvS3AhuhIlbEeSU6rDGOwqlfRXZxM-_eszGMF4Py3obK3QjUzBWNM3NAHS4xIVRhx3l7RKZpP2QU3s4DqHNa513N2ieUShDBh5TnPtS1lIVVINLVrePNGVNAdDu4TPGq73eq3t7nZjqcsYGsTGp_d7u67pcy09KtEpU4IHFuLUB9iuyFkEbaSUuXN65FsyDv5_uRQ4-VtrgUph1Sao8kTJ0bkQIBjaTqyKXLgxJkAt9L2h7CfanZ_5rlsr81D1M4UqQ6WW7b1cLPd9eL07JW_mTQnq3_UiePs4GiAKnGfBebLjsMqO0IsjN3g06i8PcOkN1jIxJnvjtz6I93sAJB1PF2bjaVOEyAouPtkw6Z4OOQbjutnYo3k47OUWBJ_iBj_j1ltc3OVSOnzQS0vVZelIB05K-hF6oPlP4dKzFFb3S90KrpHJYg8oiVu-z9-jg_EN5R3TYEp0gf45Z75AxUimgcf7Z5SEg-gHap24vpspsdqUrjsDfhwukdc4y381n1dDdVxeHe-22aGkK50Mwdx2pztYw8i68GgkP9e7sXy94f6dKpMf7A2Kghfm21O5yniXFd0VbO8F8mx26dXY"
        }),
        data: formData);
    return EsignGetDetails.fromJson(response.data);
  }

  Future<EsignGetDid> getDetailsDid(String clientId) async {

    if(!kIsWeb){
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    final formData = FormData.fromMap({ "ClientId": clientId,
      "IsESign": "Yes",
      "IsType": "equity"});


    final response = await _dio.post('GetESignMyetrade',
        options:
            Options(contentType: Headers.formUrlEncodedContentType, headers: {
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjFhMGI1OTI2ZGM4ZDFlN2M1NmE0NTcyZmQwNGI3MDQ0YThhZDUyNWVlMTVlODQ0ZmFlMWFmN2VjNTlmZTQyODY5NWFmYmUwZGFhMjc0MzE3In0.eyJhdWQiOiI1IiwianRpIjoiMWEwYjU5MjZkYzhkMWU3YzU2YTQ1NzJmZDA0YjcwNDRhOGFkNTI1ZWUxNWU4NDRmYWUxYWY3ZWM1OWZlNDI4Njk1YWZiZTBkYWEyNzQzMTciLCJpYXQiOjE2NjU5ODgwOTcsIm5iZiI6MTY2NTk4ODA5NywiZXhwIjoxNjk3NTI0MDk3LCJzdWIiOiIxMiIsInNjb3BlcyI6W119.iLJnrTlZqVpDV-ipc7RH5u3bdK6yB9cOEBcityOMBK8n-nH__c5ITO4MHHc0xaDcxTvIxC8L4GJ7FzJqrol2fdMkjIvS3AhuhIlbEeSU6rDGOwqlfRXZxM-_eszGMF4Py3obK3QjUzBWNM3NAHS4xIVRhx3l7RKZpP2QU3s4DqHNa513N2ieUShDBh5TnPtS1lIVVINLVrePNGVNAdDu4TPGq73eq3t7nZjqcsYGsTGp_d7u67pcy09KtEpU4IHFuLUB9iuyFkEbaSUuXN65FsyDv5_uRQ4-VtrgUph1Sao8kTJ0bkQIBjaTqyKXLgxJkAt9L2h7CfanZ_5rlsr81D1M4UqQ6WW7b1cLPd9eL07JW_mTQnq3_UiePs4GiAKnGfBebLjsMqO0IsjN3g06i8PcOkN1jIxJnvjtz6I93sAJB1PF2bjaVOEyAouPtkw6Z4OOQbjutnYo3k47OUWBJ_iBj_j1ltc3OVSOnzQS0vVZelIB05K-hF6oPlP4dKzFFb3S90KrpHJYg8oiVu-z9-jg_EN5R3TYEp0gf45Z75AxUimgcf7Z5SEg-gHap24vpspsdqUrjsDfhwukdc4y381n1dDdVxeHe-22aGkK50Mwdx2pztYw8i68GgkP9e7sXy94f6dKpMf7A2Kghfm21O5yniXFd0VbO8F8mx26dXY"
        }),
        data: formData);
    return EsignGetDid.fromJson(response.data);
  }
}
