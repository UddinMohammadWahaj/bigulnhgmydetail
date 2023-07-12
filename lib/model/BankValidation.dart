
import 'dart:convert';

BankValidation bankValidationFromJson(String str) => BankValidation.fromJson(json.decode(str));

String bankValidationToJson(BankValidation data) => json.encode(data.toJson());

class BankValidation {
    String? id;
    bool? verified;
    DateTime? verifiedAt;
    String? beneficiaryNameWithBank;
    String? details;
    String? code;
    String? message;
    String? errorMsg;

    BankValidation({
        this.id,
        this.verified,
        this.verifiedAt,
        this.beneficiaryNameWithBank,
        this.details,
        this.code,
        this.message,
        this.errorMsg,
    });

    factory BankValidation.fromJson(Map<String, dynamic> json) => BankValidation(
        id: json["id"],
        verified: json["verified"],
        verifiedAt: json["verified_at"] == null ? null : DateTime.parse(json["verified_at"]),
        beneficiaryNameWithBank: json["beneficiary_name_with_bank"],
        details: json["details"],
        code: json["code"],
        message: json["message"],
        errorMsg: json["error_msg"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "verified": verified,
        "verified_at": verifiedAt?.toIso8601String(),
        "beneficiary_name_with_bank": beneficiaryNameWithBank,
        "details": details,
        "code": code,
        "message": message,
        "error_msg": errorMsg,
    };
}
