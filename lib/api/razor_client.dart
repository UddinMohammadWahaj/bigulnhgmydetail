import 'package:bigul_ekyc/model/BranchDetails.dart';
import 'package:dio/dio.dart';

import 'logger_interceptors.dart';

const String baseUrl = "https://ifsc.razorpay.com/";

class RazorClient {
  late final Dio _dio;

  RazorClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 30000),
            receiveTimeout: const Duration(seconds: 10000),
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([

          ]);

  Future<BranchDetails> getBranch(String ifsc
      ) async {
    final response = await _dio.get(ifsc,
        options: Options(contentType: Headers.jsonContentType),
        data: {

        });
    return BranchDetails.fromJson(response.data);
  }

}
