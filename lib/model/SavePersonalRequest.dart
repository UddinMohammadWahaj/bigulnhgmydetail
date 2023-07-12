import 'dart:convert';

SavePersonalRequest savePersonalRequestFromJson(String str) => SavePersonalRequest.fromJson(json.decode(str));

String savePersonalRequestToJson(SavePersonalRequest data) => json.encode(data.toJson());

class SavePersonalRequest {
    String? mobile;
    String? panNo;
    String? birthDate;
    String? marital;
    String? familyType;
    String? fatherSpouse;
    String? birthplace;
    String? gender;
    String? aadhar;
    String? city;
    String? state;
    String? pincode;
    String? apiType;
    String? crAddr1;
    String? crAddr2;
    String? crAddr3;
    String? crPinCode;
    String? prAddr1;
    String? prAddr2;
    String? prAddr3;
    String? crCity;
    String? crState;
    String? prCity;
    String? prState;
    String? prPinCode;

    SavePersonalRequest({
        this.mobile,
        this.panNo,
        this.birthDate,
        this.marital,
        this.familyType,
        this.fatherSpouse,
        this.birthplace,
        this.gender,
        this.aadhar,
        this.city,
        this.state,
        this.pincode,
        this.apiType,
        this.crAddr1,
        this.crAddr2,
        this.crAddr3,
        this.crPinCode,
        this.prAddr1,
        this.prAddr2,
        this.prAddr3,
        this.crCity,
        this.crState,
        this.prCity,
        this.prState,
        this.prPinCode,
    });

    factory SavePersonalRequest.fromJson(Map<String, dynamic> json) => SavePersonalRequest(
        mobile: json["mobile"],
        panNo: json["PanNo"],
        birthDate: json["BirthDate"],
        marital: json["marital"],
        familyType: json["FamilyType"],
        fatherSpouse: json["father_spouse"],
        birthplace: json["birthplace"],
        gender: json["gender"],
        aadhar: json["aadhar"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        apiType: json["apiType"],
        crAddr1: json["CRAddr1"],
        crAddr2: json["CRAddr2"],
        crAddr3: json["CRAddr3"],
        crPinCode: json["CRPinCode"],
        prAddr1: json["PRAddr1"],
        prAddr2: json["PRAddr2"],
        prAddr3: json["PRAddr3"],
        crCity: json["CRCity"],
        crState: json["CRState"],
        prCity: json["PRCity"],
        prState: json["PRState"],
        prPinCode: json["PRPinCode"],
    );

    Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "PanNo": panNo,
        "BirthDate": birthDate,
        "marital": marital,
        "FamilyType": familyType,
        "father_spouse": fatherSpouse,
        "birthplace": birthplace,
        "gender": gender,
        "aadhar": aadhar,
        "city": city,
        "state": state,
        "pincode": pincode,
        "apiType": apiType,
        "CRAddr1": crAddr1,
        "CRAddr2": crAddr2,
        "CRAddr3": crAddr3,
        "CRPinCode": crPinCode,
        "PRAddr1": prAddr1,
        "PRAddr2": prAddr2,
        "PRAddr3": prAddr3,
        "CRCity": crCity,
        "CRState": crState,
        "PRCity": prCity,
        "PRState": prState,
        "PRPinCode": prPinCode,
    };
}
