
import 'dart:convert';

import 'package:bigul_ekyc/model/EducationList.dart';

OccupationList occupationListFromJson(String str) => OccupationList.fromJson(json.decode(str));

String occupationListToJson(OccupationList data) => json.encode(data.toJson());

class OccupationList {
    int? status;
    List<ListItem>? occupationList;

    OccupationList({
        this.status,
        this.occupationList,
    });

    factory OccupationList.fromJson(Map<String, dynamic> json) => OccupationList(
        status: json["status"],
        occupationList: json["occupationList"] == null ? [] : List<ListItem>.from(json["occupationList"]!.map((x) => ListItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "occupationList": occupationList == null ? [] : List<dynamic>.from(occupationList!.map((x) => x.toJson())),
    };
}


