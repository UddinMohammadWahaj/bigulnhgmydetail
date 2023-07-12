// To parse this JSON data, do
//
//     final getPanStatusResponse = getPanStatusResponseFromJson(jsonString);

import 'dart:convert';

GetPanStatusResponse getPanStatusResponseFromJson(String str) => GetPanStatusResponse.fromJson(json.decode(str));

String getPanStatusResponseToJson(GetPanStatusResponse data) => json.encode(data.toJson());

class GetPanStatusResponse {
    AppResRoot appResRoot;

    GetPanStatusResponse({
        required this.appResRoot,
    });

    factory GetPanStatusResponse.fromJson(Map<String, dynamic> json) => GetPanStatusResponse(
        appResRoot: AppResRoot.fromJson(json["APP_RES_ROOT"]),
    );

    Map<String, dynamic> toJson() => {
        "APP_RES_ROOT": appResRoot.toJson(),
    };
}

class AppResRoot {
    AppPanInq appPanInq;
    AppPanSumm appPanSumm;

    AppResRoot({
        required this.appPanInq,
        required this.appPanSumm,
    });

    factory AppResRoot.fromJson(Map<String, dynamic> json) => AppResRoot(
        appPanInq: AppPanInq.fromJson(json["APP_PAN_INQ"]),
        appPanSumm: AppPanSumm.fromJson(json["APP_PAN_SUMM"]),
    );

    Map<String, dynamic> toJson() => {
        "APP_PAN_INQ": appPanInq.toJson(),
        "APP_PAN_SUMM": appPanSumm.toJson(),
    };
}

class AppPanInq {
     String? appPanNo;
     String? appName;
     String? appStatus;
     String? appStatusdt;
     String? appEntrydt;
     String? appModdt;
     String?  appStatusDelta;
     String? appUpdtStatus;
     String?  appHoldDeactiveRmks;
     String? appUpdtRmks;
     String? appKycMode;
     String? appIpvFlag;
     String?  appUboFlag;
     String? appPerAddProof;
     String? appCorAddProof;

    AppPanInq({
        this.appPanNo,
        this.appName,
        this.appStatus,
        this.appStatusdt,
        this.appEntrydt,
        this.appModdt,
        this.appStatusDelta,
        this.appUpdtStatus,
        this.appHoldDeactiveRmks,
        this.appUpdtRmks,
        this.appKycMode,
        this.appIpvFlag,
        this.appUboFlag,
        this.appPerAddProof,
        this.appCorAddProof,
    });

    factory AppPanInq.fromJson(Map<String, dynamic> json) => AppPanInq(
        appPanNo: json["APP_PAN_NO"],
        appName: json["APP_NAME"],
        appStatus: json["APP_STATUS"],
        appStatusdt: json["APP_STATUSDT"],
        appEntrydt: json["APP_ENTRYDT"],
        appModdt: json["APP_MODDT"],
        appStatusDelta: json["APP_STATUS_DELTA"],
        appUpdtStatus: json["APP_UPDT_STATUS"],
        appHoldDeactiveRmks: json["APP_HOLD_DEACTIVE_RMKS"],
        appUpdtRmks: json["APP_UPDT_RMKS"],
        appKycMode: json["APP_KYC_MODE"],
        appIpvFlag: json["APP_IPV_FLAG"],
        appUboFlag: json["APP_UBO_FLAG"],
        appPerAddProof: json["APP_PER_ADD_PROOF"],
        appCorAddProof: json["APP_COR_ADD_PROOF"],
    );

    Map<String, dynamic> toJson() => {
        "APP_PAN_NO": appPanNo,
        "APP_NAME": appName,
        "APP_STATUS": appStatus,
        "APP_STATUSDT": appStatusdt,
        "APP_ENTRYDT": appEntrydt,
        "APP_MODDT": appModdt,
        "APP_STATUS_DELTA": appStatusDelta,
        "APP_UPDT_STATUS": appUpdtStatus,
        "APP_HOLD_DEACTIVE_RMKS": appHoldDeactiveRmks,
        "APP_UPDT_RMKS": appUpdtRmks,
        "APP_KYC_MODE": appKycMode,
        "APP_IPV_FLAG": appIpvFlag,
        "APP_UBO_FLAG": appUboFlag,
        "APP_PER_ADD_PROOF": appPerAddProof,
        "APP_COR_ADD_PROOF": appCorAddProof,
    };
}

class AppPanSumm {
    String? batchId;
    String? appResponseDate;
    String? appTotalRec;

    AppPanSumm({
        this.batchId,
        this.appResponseDate,
        this.appTotalRec,
    });

    factory AppPanSumm.fromJson(Map<String, dynamic> json) => AppPanSumm(
        batchId: json["BATCH_ID"],
        appResponseDate: json["APP_RESPONSE_DATE"],
        appTotalRec: json["APP_TOTAL_REC"],
    );

    Map<String, dynamic> toJson() => {
        "BATCH_ID": batchId,
        "APP_RESPONSE_DATE": appResponseDate,
        "APP_TOTAL_REC": appTotalRec,
    };
}
