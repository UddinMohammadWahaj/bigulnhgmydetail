
//
//     final loginWithOtp = loginWithOtpFromJson(jsonString);

import 'dart:convert';

class LoginWithOtp {
    LoginWithOtp({
        this.status,
        this.msg,
    });

    int? status;
    String? msg;

    factory LoginWithOtp.fromRawJson(String str) => LoginWithOtp.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginWithOtp.fromJson(Map<String, dynamic> json) => LoginWithOtp(
        status: json["status"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
    };
}
