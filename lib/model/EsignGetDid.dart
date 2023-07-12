
import 'dart:convert';

EsignGetDid esignGetDidFromJson(String str) => EsignGetDid.fromJson(json.decode(str));

String esignGetDidToJson(EsignGetDid data) => json.encode(data.toJson());

class EsignGetDid {
    bool? success;
    String? message;
    Data? data;

    EsignGetDid({
        this.success,
        this.message,
        this.data,
    });

    factory EsignGetDid.fromJson(Map<String, dynamic> json) => EsignGetDid(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : json["data"] == ""? null :Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? isESign;
    String? xml;
    String? urll;
    dynamic pdfPath;

    Data({
        this.isESign,
        this.xml,
        this.urll,
        this.pdfPath,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        isESign: json["IsESign"],
        xml: json["XML"],
        urll: json["URLL"],
        pdfPath: json["PdfPath"],
    );

    Map<String, dynamic> toJson() => {
        "IsESign": isESign,
        "XML": xml,
        "URLL": urll,
        "PdfPath": pdfPath,
    };
}
