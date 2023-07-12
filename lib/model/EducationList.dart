
import 'dart:convert';

EducationList educationListFromJson(String str) => EducationList.fromJson(json.decode(str));

String educationListToJson(EducationList data) => json.encode(data.toJson());

class EducationList {
    int? status;
    List<ListItem>? educationList;

    EducationList({
        this.status,
        this.educationList,
    });

    factory EducationList.fromJson(Map<String, dynamic> json) => EducationList(
        status: json["status"],
        educationList: json["educationList"] == null ? [] : List<ListItem>.from(json["educationList"]!.map((x) => ListItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "educationList": educationList == null ? [] : List<dynamic>.from(educationList!.map((x) => x.toJson())),
    };
}

class ListItem {
    String? id;
    String? name;

    ListItem({
        this.id,
        this.name,
    });

    factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
        id: json["id"].toString(),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": "$id",
        "name": name,
    };
}
