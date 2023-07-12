// To parse this JSON data, do
//
//     final verifyOtp = verifyOtpFromJson(jsonString);

import 'dart:convert';

VerifyOtp verifyOtpFromJson(String str) => VerifyOtp.fromJson(json.decode(str));

String verifyOtpToJson(VerifyOtp data) => json.encode(data.toJson());

class VerifyOtp {
    int? status;
    String? msg;
    UserData? userData;

    VerifyOtp({
        this.status,
        this.msg,
        this.userData,
    });

    factory VerifyOtp.fromJson(Map<String, dynamic> json) => VerifyOtp(
        status: json["status"],
        msg: json["msg"]??json["message"],
        userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "user_data": userData?.toJson(),
    };
}

class UserData {
    int? id;
    String? mobile;
    String? email;
    String? mobileOtp;
    String? emailOtp;
    int? mobileVerify;
    int? emailVerificationSend;
    int? emailVerify;
    dynamic pan;
    dynamic fname;
    dynamic mname;
    dynamic lname;
    dynamic fullName;
    dynamic dob;
    dynamic seeding;
    dynamic stage;
    String? leadSquareId;
    dynamic clientCode;
    dynamic partnerCode;
    dynamic clientPassword;
    String? otpDateTime;
    String? emailOtpDateTime;
    int? derivativeStatus;
    dynamic signatureUploadResponse;
    dynamic photoUploadResponse;
    dynamic otherUploadResponse;
    dynamic browserName;
    dynamic crnNumber;
    dynamic responseId;
    dynamic responseActionId;
    dynamic jsonData;
    dynamic accountNo;
    dynamic ifsc;
    dynamic pennyDropData;
    int? esignStatus;
    DateTime? createdAt;
    DateTime? updatedAt;

    UserData({
        this.id,
        this.mobile,
        this.email,
        this.mobileOtp,
        this.emailOtp,
        this.mobileVerify,
        this.emailVerificationSend,
        this.emailVerify,
        this.pan,
        this.fname,
        this.mname,
        this.lname,
        this.fullName,
        this.dob,
        this.seeding,
        this.stage,
        this.leadSquareId,
        this.clientCode,
        this.partnerCode,
        this.clientPassword,
        this.otpDateTime,
        this.emailOtpDateTime,
        this.derivativeStatus,
        this.signatureUploadResponse,
        this.photoUploadResponse,
        this.otherUploadResponse,
        this.browserName,
        this.crnNumber,
        this.responseId,
        this.responseActionId,
        this.jsonData,
        this.accountNo,
        this.ifsc,
        this.pennyDropData,
        this.esignStatus,
        this.createdAt,
        this.updatedAt,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        mobile: json["mobile"],
        email: json["email"],
        mobileOtp: json["mobile_otp"],
        emailOtp: json["email_otp"],
        mobileVerify: json["mobile_verify"],
        emailVerificationSend: json["email_verification_send"],
        emailVerify: json["email_verify"],
        pan: json["pan"],
        fname: json["fname"],
        mname: json["mname"],
        lname: json["lname"],
        fullName: json["fullName"],
        dob: json["dob"],
        seeding: json["seeding"],
        stage: json["stage"],
        leadSquareId: json["leadSquareId"],
        clientCode: json["clientCode"],
        partnerCode: json["partnerCode"],
        clientPassword: json["clientPassword"],
        otpDateTime: json["otp_date_time"],
        emailOtpDateTime: json["email_otp_date_time"],
        derivativeStatus: json["derivativeStatus"],
        signatureUploadResponse: json["signature_upload_response"],
        photoUploadResponse: json["photo_upload_response"],
        otherUploadResponse: json["other_upload_response"],
        browserName: json["browser_name"],
        crnNumber: json["crn_number"],
        responseId: json["response_id"],
        responseActionId: json["response_action_id"],
        jsonData: json["json_data"],
        accountNo: json["accountNo"],
        ifsc: json["ifsc"],
        pennyDropData: json["pennyDropData"],
        esignStatus: json["esign_status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mobile": mobile,
        "email": email,
        "mobile_otp": mobileOtp,
        "email_otp": emailOtp,
        "mobile_verify": mobileVerify,
        "email_verification_send": emailVerificationSend,
        "email_verify": emailVerify,
        "pan": pan,
        "fname": fname,
        "mname": mname,
        "lname": lname,
        "fullName": fullName,
        "dob": dob,
        "seeding": seeding,
        "stage": stage,
        "leadSquareId": leadSquareId,
        "clientCode": clientCode,
        "partnerCode": partnerCode,
        "clientPassword": clientPassword,
        "otp_date_time": otpDateTime,
        "email_otp_date_time": emailOtpDateTime,
        "derivativeStatus": derivativeStatus,
        "signature_upload_response": signatureUploadResponse,
        "photo_upload_response": photoUploadResponse,
        "other_upload_response": otherUploadResponse,
        "browser_name": browserName,
        "crn_number": crnNumber,
        "response_id": responseId,
        "response_action_id": responseActionId,
        "json_data": jsonData,
        "accountNo": accountNo,
        "ifsc": ifsc,
        "pennyDropData": pennyDropData,
        "esign_status": esignStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
