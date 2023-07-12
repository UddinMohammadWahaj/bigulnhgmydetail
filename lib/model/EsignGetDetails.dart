// To parse this JSON data, do
//
//     final esignGetDetails = esignGetDetailsFromJson(jsonString);

import 'dart:convert';

EsignGetDetails esignGetDetailsFromJson(String str) => EsignGetDetails.fromJson(json.decode(str));

String esignGetDetailsToJson(EsignGetDetails data) => json.encode(data.toJson());

class EsignGetDetails {
    bool? success;
    String? message;
    List<Map<String, String?>>? data;

    EsignGetDetails({
        this.success,
        this.message,
        this.data,
    });

    factory EsignGetDetails.fromJson(Map<String, dynamic> json) => EsignGetDetails(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null||json["data"].toString().isEmpty ? [] : List<Map<String, String?>>.from(json["data"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    };
}
