import 'dart:convert';

class KraVerifiedCode {
  KraVerifiedCode({
    this.codename,
    this.code,
  });

  String? codename;
  String? code;

  factory KraVerifiedCode.fromRawJson(String str) =>
      KraVerifiedCode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KraVerifiedCode.fromJson(Map<String, dynamic> json) =>
      KraVerifiedCode(
        codename: json["codename"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() =>
      {
        "codename": codename,
        "code": code,
      };

 static List<KraVerifiedCode> kraVerifiedCodes = [
    KraVerifiedCode(codename: "CVLKRA", code: "002"),
    KraVerifiedCode(codename: "NDML", code: "102"),
    KraVerifiedCode(codename: "DOTEX", code: "202"),
    KraVerifiedCode(codename: "CAMS", code: "302"),
    KraVerifiedCode(codename: "KARVY", code: "402"),
    KraVerifiedCode(codename: "BSE", code: "502"),

   KraVerifiedCode(codename: "CVLKRA", code: "007"),
    KraVerifiedCode(codename: "NDML", code: "107"),
    KraVerifiedCode(codename: "DOTEX", code: "207"),
    KraVerifiedCode(codename: "CAMS", code: "307"),
    KraVerifiedCode(codename: "KARVY", code: "407"),
    KraVerifiedCode(codename: "BSE", code: "507"),
  ];
}

