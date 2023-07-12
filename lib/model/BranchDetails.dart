
import 'dart:convert';

BranchDetails branchDetailsFromJson(String str) => BranchDetails.fromJson(json.decode(str));

String branchDetailsToJson(BranchDetails data) => json.encode(data.toJson());

class BranchDetails {
    String? branch;
    String? centre;
    String? district;
    String? state;
    String? address;
    String? contact;
    bool? imps;
    String? city;
    bool? upi;
    String? micr;
    bool? rtgs;
    bool? neft;
    String? swift;
    String? iso3166;
    String? bank;
    String? bankcode;
    String? ifsc;

    BranchDetails({
        this.branch,
        this.centre,
        this.district,
        this.state,
        this.address,
        this.contact,
        this.imps,
        this.city,
        this.upi,
        this.micr,
        this.rtgs,
        this.neft,
        this.swift,
        this.iso3166,
        this.bank,
        this.bankcode,
        this.ifsc,
    });

    factory BranchDetails.fromJson(Map<String, dynamic> json) => BranchDetails(
        branch: json["BRANCH"],
        centre: json["CENTRE"],
        district: json["DISTRICT"],
        state: json["STATE"],
        address: json["ADDRESS"],
        contact: json["CONTACT"],
        imps: json["IMPS"],
        city: json["CITY"],
        upi: json["UPI"],
        micr: json["MICR"],
        rtgs: json["RTGS"],
        neft: json["NEFT"],
        swift: json["SWIFT"],
        iso3166: json["ISO3166"],
        bank: json["BANK"],
        bankcode: json["BANKCODE"],
        ifsc: json["IFSC"],
    );

    Map<String, dynamic> toJson() => {
        "BRANCH": branch,
        "CENTRE": centre,
        "DISTRICT": district,
        "STATE": state,
        "ADDRESS": address,
        "CONTACT": contact,
        "IMPS": imps,
        "CITY": city,
        "UPI": upi,
        "MICR": micr,
        "RTGS": rtgs,
        "NEFT": neft,
        "SWIFT": swift,
        "ISO3166": iso3166,
        "BANK": bank,
        "BANKCODE": bankcode,
        "IFSC": ifsc,
    };
}
