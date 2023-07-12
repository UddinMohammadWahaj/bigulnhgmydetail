
import 'dart:convert';

import 'package:bigul_ekyc/model/EducationList.dart';

AnnualIncomeList annualIncomeListFromJson(String str) => AnnualIncomeList.fromJson(json.decode(str));

String annualIncomeListToJson(AnnualIncomeList data) => json.encode(data.toJson());

class AnnualIncomeList {
    int? status;
    List<ListItem>? annualIncomeList;

    AnnualIncomeList({
        this.status,
        this.annualIncomeList,
    });

    factory AnnualIncomeList.fromJson(Map<String, dynamic> json) => AnnualIncomeList(
        status: json["status"],
        annualIncomeList: json["annualIncomeList"] == null ? [] : List<ListItem>.from(json["annualIncomeList"]!.map((x) => ListItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "annualIncomeList": annualIncomeList == null ? [] : List<dynamic>.from(annualIncomeList!.map((x) => x.toJson())),
    };
}


