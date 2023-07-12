// To parse this JSON data, do
//
//     final segmentHeader = segmentHeaderFromJson(jsonString);

import 'dart:convert';

SegmentHeader segmentHeaderFromJson(String str) => SegmentHeader.fromJson(json.decode(str));

String segmentHeaderToJson(SegmentHeader data) => json.encode(data.toJson());

class SegmentHeader {
    String? header;
    bool? isExpanded;
    List<ListElement>? list;

    SegmentHeader({
        this.header,
        this.isExpanded,
        this.list,
    });

    factory SegmentHeader.fromJson(Map<String, dynamic> json) => SegmentHeader(
        header: json["header"],
        isExpanded: json["isExpanded"],
        list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "header": header,
        "isExpanded": isExpanded,
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
    };
}

class ListElement {
    String? type;
    String? text;
    bool? isChecked;
    List<String>? radiolist;
    String? selectedRadio;

    ListElement({
        this.type,
        this.text,
        this.isChecked,
this.radiolist,
this.selectedRadio,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        type: json["type"],
        text: json["text"],
        isChecked: json["isChecked"],
        radiolist: json["radiolist"],
        selectedRadio: json["selectedRadio"]
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "isChecked": isChecked,
        "radiolist": radiolist,
        "selectedRadio": selectedRadio
    };
}
