
import 'dart:convert';

import 'package:bigul_ekyc/model/EducationList.dart';

ExperienceList experienceListFromJson(String str) => ExperienceList.fromJson(json.decode(str));

String experienceListToJson(ExperienceList data) => json.encode(data.toJson());

class ExperienceList {
    int? status;
    List<ListItem>? experienceList;

    ExperienceList({
        this.status,
        this.experienceList,
    });

    factory ExperienceList.fromJson(Map<String, dynamic> json) => ExperienceList(
        status: json["status"],
        experienceList: json["experienceList"] == null ? [] : List<ListItem>.from(json["experienceList"]!.map((x) => ListItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "experienceList": experienceList == null ? [] : List<dynamic>.from(experienceList!.map((x) => x.toJson())),
    };
}


