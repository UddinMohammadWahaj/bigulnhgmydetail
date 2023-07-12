

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    // Customize the printer
    printer: PrettyPrinter(
        methodCount: 0,
        printTime: false,



    ),
  );

  static String  parseErrorMessage(String data) {
    try {
      final jsonResponse = jsonDecode(data);
      return jsonResponse['message'] ?? jsonResponse['msg'] ??'Something went wrong';
    } catch (_) {
      return 'Something went wrong';
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.d( ' ${err.response?.statusMessage}');
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request => $requestPath');  // Debug log
    logger.d('Error: ${err.type}, Message:${err.response.toString()} ${err.response?.statusMessage} ${err.response?.toString()}'); // Error log
    logger.d('Error: ${parseErrorMessage(err.response.toString())}');

    if(err.type == DioErrorType.connectionTimeout){
Fluttertoast.showToast(msg: "Connection Timeout!");
      throw Exception("Connection  Timeout Exception");
    }

    else{
      try{
        Fluttertoast.showToast(msg: parseErrorMessage(err.response.toString()));
      }catch(e){
        throw Exception(e.toString());
      }
    }
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request => $requestPath'); // Info log
    logger.i('Request data: ${options.data}');
    if (options.data is FormData) {
      FormData formData = options.data as FormData;
      for (var field in formData.fields) {
        logger.i('${field.key}: ${field.value}');
      }
    }
    logger.i(options.headers.toString()); // Info log
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('StatusCode: ${response.statusCode}, Data: ${response.data}'); // Debug log
    return super.onResponse(response, handler);
  }
}

