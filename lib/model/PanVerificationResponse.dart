
//
//     final panVerificationResponse = panVerificationResponseFromJson(jsonString);

import 'dart:convert';

class PanVerificationResponse {
    PanVerificationResponse({
        this.status,
        this.redirect,
        this.url,
        this.msg,
        this.userData,
    });

    int? status;
    bool? redirect;
    int? url;
    String? msg;
    UserData? userData;

    factory PanVerificationResponse.fromRawJson(String str) => PanVerificationResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PanVerificationResponse.fromJson(Map<String, dynamic> json) => PanVerificationResponse(
        status: json["status"],
        redirect: json["redirect"],
        url: json["url"],
        msg: json["msg"],
        userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "redirect": redirect,
        "url": url,
        "msg": msg,
        "user_data": userData?.toJson(),
    };
}

class UserData {
    UserData({
        this.firstName,
        this.middleName,
        this.lastName,
        this.seeding,
    });

    String? firstName;
    String? middleName;
    String? lastName;
    String? seeding;

    factory UserData.fromRawJson(String str) => UserData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        seeding: json["seeding"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "seeding": seeding,
    };
}
