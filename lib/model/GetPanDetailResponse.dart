
import 'dart:convert';

GetPanDetailResponse getPanDetailResponseFromJson(String str) => GetPanDetailResponse.fromJson(json.decode(str));

String getPanDetailResponseToJson(GetPanDetailResponse data) => json.encode(data.toJson());

class GetPanDetailResponse {
    Root root;

    GetPanDetailResponse({
        required this.root,
    });

    factory GetPanDetailResponse.fromJson(Map<String, dynamic> json) => GetPanDetailResponse(
        root: Root.fromJson(json["ROOT"]),
    );

    Map<String, dynamic> toJson() => {
        "ROOT": root.toJson(),
    };
}

class Root {
    KYCData? kycData;
    AppPanSumm? appPanSumm;

    Root({
        required this.kycData,
         this.appPanSumm,
    });

    factory Root.fromJson(Map<String, dynamic> json) => Root(
        kycData: KYCData.fromJson(json["KYC_DATA"]),
        appPanSumm:json["APP_PAN_SUMM"]!=null? AppPanSumm.fromJson(json["APP_PAN_SUMM"]):null,
    );

    Map<String, dynamic> toJson() => {
        "KYC_DATA": kycData?.toJson(),
        "APP_PAN_SUMM": appPanSumm?.toJson(),
    };
}

class AppPanSumm {
    String appOthkraCode;
    String appOthkraBatch;
    String appReqDate;
    String appResponseDate;
    String appTotalRec;

    AppPanSumm({
        required this.appOthkraCode,
        required this.appOthkraBatch,
        required this.appReqDate,
        required this.appResponseDate,
        required this.appTotalRec,
    });

    factory AppPanSumm.fromJson(Map<String, dynamic> json) => AppPanSumm(
        appOthkraCode: json["APP_OTHKRA_CODE"],
        appOthkraBatch: json["APP_OTHKRA_BATCH"],
        appReqDate: json["APP_REQ_DATE"],
        appResponseDate: json["APP_RESPONSE_DATE"],
        appTotalRec: json["APP_TOTAL_REC"],
    );

    Map<String, dynamic> toJson() => {
        "APP_OTHKRA_CODE": appOthkraCode,
        "APP_OTHKRA_BATCH": appOthkraBatch,
        "APP_REQ_DATE": appReqDate,
        "APP_RESPONSE_DATE": appResponseDate,
        "APP_TOTAL_REC": appTotalRec,
    };
}

class KYCData {
    String? appPosCode;
    String? appType;
    String? appNo;
    String? appDate;
    String? appPanNo;
    String? appPanCopy;
    String? appExmt;
    String? appExmtCat;
    String? appExmtIdProof;
    String? appIpvFlag;
    String? appIpvDate;
    String? appGen;
    String? appName;
    String? appFName;
    String? appRegNo;
    String? appDobDt;
    String? appCommenceDt;
    String? appNationality;
    String? appOthNationality;
    String? appCompStatus;
    String? appOthCompStatus;
    String? appResStatus;
    String? appResStatusProof;
    String? appUidNo;
    String? appCorAdd1;
    String? appCorAdd2;
    String? appCorAdd3;
    String? appCorCity;
    String? appCorPincd;
    String? appCorState;
    String? appCorCtry;
    String? appOffNo;
    String? appResNo;
    String? appMobNo;
    String? appFaxNo;
    String? appEmail;
    String? appCorAddProof;
    String? appCorAddRef;
    String? appCorAddDt;
    String? appPerAdd1;
    String? appPerAdd2;
    String? appPerAdd3;
    String? appPerCity;
    String? appPerPincd;
    String? appPerState;
    String? appPerCtry;
    String? appPerAddProof;
    String? appPerAddRef;
    String? appPerAddDt;
    String? appIncome;
    String? appOcc;
    String? appOthOcc;
    String? appPolConn;
    String? appDocProof;
    String? appInternalRef;
    String? appBranchCode;
    String? appMarStatus;
    String? appNetwrth;
    String? appNetworthDt;
    String? appIncorpPlc;
    String? appOtherInfo;
    String? appAccOpendt;
    String? appAccActivedt;
    String? appAccUpdtdt;
    String? appFiller1;
    String? appFiller2;
    String? appFiller3;
    String? appStatus;
    String? appStatusdt;
    String? appErrorDesc;
    String? appErrorCode;
    String? appDumpType;
    String? appDnlddt;
    String? appRemarks;
    String? appKycMode;
    String? appUidToken;
    String? appVerNo;
    String? appKraInfo;
    String? appIopFlg;
    String? appSignature;

    KYCData({
         this.appPosCode,
         this.appType,
         this.appNo,
         this.appDate,
         this.appPanNo,
         this.appPanCopy,
         this.appExmt,
         this.appExmtCat,
         this.appExmtIdProof,
         this.appIpvFlag,
         this.appIpvDate,
         this.appGen,
         this.appName,
         this.appFName,
         this.appRegNo,
         this.appDobDt,
         this.appCommenceDt,
         this.appNationality,
         this.appOthNationality,
         this.appCompStatus,
         this.appOthCompStatus,
         this.appResStatus,
         this.appResStatusProof,
         this.appUidNo,
         this.appCorAdd1,
         this.appCorAdd2,
         this.appCorAdd3,
         this.appCorCity,
         this.appCorPincd,
         this.appCorState,
         this.appCorCtry,
         this.appOffNo,
         this.appResNo,
         this.appMobNo,
         this.appFaxNo,
         this.appEmail,
         this.appCorAddProof,
         this.appCorAddRef,
         this.appCorAddDt,
         this.appPerAdd1,
         this.appPerAdd2,
         this.appPerAdd3,
         this.appPerCity,
         this.appPerPincd,
         this.appPerState,
         this.appPerCtry,
         this.appPerAddProof,
         this.appPerAddRef,
         this.appPerAddDt,
         this.appIncome,
         this.appOcc,
         this.appOthOcc,
         this.appPolConn,
         this.appDocProof,
         this.appInternalRef,
         this.appBranchCode,
         this.appMarStatus,
         this.appNetwrth,
         this.appNetworthDt,
         this.appIncorpPlc,
         this.appOtherInfo,
         this.appAccOpendt,
         this.appAccActivedt,
         this.appAccUpdtdt,
         this.appFiller1,
         this.appFiller2,
         this.appFiller3,
         this.appStatus,
         this.appStatusdt,
         this.appErrorDesc,
         this.appDumpType,
         this.appDnlddt,
         this.appRemarks,
         this.appKycMode,
         this.appUidToken,
         this.appVerNo,
         this.appKraInfo,
         this.appIopFlg,
         this.appErrorCode,
         this.appSignature,
    });

    factory KYCData.fromJson(Map<String, dynamic> map) =>
        KYCData(
            appPosCode: map['APP_POS_CODE'],
            appErrorCode: map['APP_ERROR_CODE'],
            appType: map['APP_TYPE'],
            appNo: map['APP_NO'],
            appDate: map['APP_DATE'],
            appPanNo: map['APP_PAN_NO'],
            appPanCopy: map['APP_PAN_COPY'],
            appExmt: map['APP_EXMT'],
            appExmtCat: map['APP_EXMT_CAT'],
            appExmtIdProof: map['APP_EXMT_ID_PROOF'],
            appIpvFlag: map['APP_IPV_FLAG'],
            appIpvDate: map['APP_IPV_DATE'],
            appGen: map['APP_GEN'],
            appName: map['APP_NAME'],
            appFName: map['APP_F_NAME'],
            appRegNo: map['APP_REGNO'],
            appDobDt: map['APP_DOB_DT'],
            appCommenceDt: map['APP_COMMENCE_DT'],
            appNationality: map['APP_NATIONALITY'],
            appOthNationality: map['APP_OTH_NATIONALITY'],
            appCompStatus: map['APP_COMP_STATUS'],
            appOthCompStatus: map['APP_OTH_COMP_STATUS'],
            appResStatus: map['APP_RES_STATUS'],
            appResStatusProof: map['APP_RES_STATUS_PROOF'],
            appUidNo: map['APP_UID_NO'],
            appCorAdd1: map['APP_COR_ADD1'],
            appCorAdd2: map['APP_COR_ADD2'],
            appCorAdd3: map['APP_COR_ADD3'],
            appCorCity: map['APP_COR_CITY'],
            appCorPincd: map['APP_COR_PINCD'],
            appCorState: map['APP_COR_STATE'],
            appCorCtry: map['APP_COR_CTRY'],
            appOffNo: map['APP_OFF_NO'],
            appResNo: map['APP_RES_NO'],
            appMobNo: map['APP_MOB_NO'],
            appFaxNo: map['APP_FAX_NO'],
            appEmail: map['APP_EMAIL'],
            appCorAddProof: map['APP_COR_ADD_PROOF'],
            appCorAddRef: map['APP_COR_ADD_REF'],
            appCorAddDt: map['APP_COR_ADD_DT'],
            appPerAdd1: map['APP_PER_ADD1'],
            appPerAdd2: map['APP_PER_ADD2'],
            appPerAdd3: map['APP_PER_ADD3'],
            appPerCity: map['APP_PER_CITY'],
            appPerPincd: map['APP_PER_PINCD'],
            appPerState: map['APP_PER_STATE'],
            appPerCtry: map['APP_PER_CTRY'],
            appPerAddProof: map['APP_PER_ADD_PROOF'],
            appPerAddRef: map['APP_PER_ADD_REF'],
            appPerAddDt: map['APP_PER_ADD_DT'],
            appIncome: map['APP_INCOME'],
            appOcc: map['APP_OCC'],
            appOthOcc: map['APP_OTH_OCC'],
            appPolConn: map['APP_POL_CONN'],
            appDocProof: map['APP_DOC_PROOF'],
            appInternalRef: map['APP_INTERNAL_REF'],
            appBranchCode: map['APP_BRANCH_CODE'],
            appMarStatus: map['APP_MAR_STATUS'],
            appNetwrth: map['APP_NETWRTH'],
            appNetworthDt: map['APP_NETWORTH_DT'],
            appIncorpPlc: map['APP_INCORP_PLC'],
            appOtherInfo: map['APP_OTHERINFO'],
            appAccOpendt: map['APP_ACC_OPENDT'],
            appAccActivedt: map['APP_ACC_ACTIVEDT'],
            appAccUpdtdt: map['APP_ACC_UPDTDT'],
            appFiller1: map['APP_FILLER1'],
            appFiller2: map['APP_FILLER2'],
            appFiller3: map['APP_FILLER3'],
            appStatus: map['APP_STATUS'],
            appStatusdt: map['APP_STATUSDT'],
            appErrorDesc: map['APP_ERROR_DESC'],
            appDumpType: map['APP_DUMP_TYPE'],
            appDnlddt: map['APP_DNLDDT'],
            appRemarks: map['APP_REMARKS'],
            appKycMode: map['APP_KYC_MODE'],
            appUidToken: map['APP_UID_TOKEN'],
            appVerNo: map['APP_VER_NO'],
            appKraInfo: map['APP_KRA_INFO'],
            appIopFlg: map['APP_IOP_FLG'],
            appSignature: map['APP_SIGNATURE']

        );


    Map<String, dynamic> toJson() =>
        {
            "APP_POS_CODE" :appPosCode,
            "APP_ERROR_CODE" :appErrorCode,
            "APP_TYPE" :appType,
            "APP_NO" :appNo,
            "APP_DATE" :appDate,
            "APP_PAN_NO" :appPanNo,
            "APP_PAN_COPY" :appPanCopy,
            "APP_EXMT" :appExmt,
            "APP_EXMT_CAT" :appExmtCat,
            "APP_EXMT_ID_PROOF" :appExmtIdProof,
            "APP_IPV_FLAG" :appIpvFlag,
            "APP_IPV_DATE" :appIpvDate,
            "APP_GEN" :appGen,
            "APP_NAME" :appName,
            "APP_F_NAME" :appFName,
            "APP_REGNO" :appRegNo,
            "APP_DOB_DT" :appDobDt,
            "APP_COMMENCE_DT" :appCommenceDt,
            "APP_NATIONALITY" :appNationality,
            "APP_OTH_NATIONALITY" :appOthNationality,
            "APP_COMP_STATUS" :appCompStatus,
            "APP_OTH_COMP_STATUS" :appOthCompStatus,
            "APP_RES_STATUS" :appResStatus,
            "APP_RES_STATUS_PROOF" :appResStatus,
            "APP_UID_NO" :appUidNo,
            "APP_COR_ADD1" :appCorAdd1,
            "APP_COR_ADD2" :appCorAdd2,
            "APP_COR_ADD3" :appCorAdd3,
            "APP_COR_CITY" :appCorCity,
            "APP_COR_PINCD" :appCorPincd,
            "APP_COR_STATE" :appCorState,
            "APP_COR_CTRY" :appCorCtry,
            "APP_OFF_NO" :appOffNo,
            "APP_RES_NO" :appResNo,
            "APP_MOB_NO" :appMobNo,
            "APP_FAX_NO" :appFaxNo,
            "APP_EMAIL" :appEmail,
            "APP_COR_ADD_PROOF" :appCorAddProof,
            "APP_COR_ADD_REF" :appCorAddRef,
            "APP_COR_ADD_DT" :appCorAddDt,
            "APP_PER_ADD1" :appPerAdd1,
            "APP_PER_ADD2" :appPerAdd2,
            "APP_PER_ADD3" :appPerAdd3,
            "APP_PER_CITY" :appPerCity,
            "APP_PER_PINCD" :appPerPincd,
            "APP_PER_STATE" :appPerState,
            "APP_PER_CTRY" :appPerCtry,
            "APP_PER_ADD_PROOF" :appPerAddProof,
            "APP_PER_ADD_REF" :appPerAddRef,
            "APP_PER_ADD_DT" :appPerAddDt,
            "APP_INCOME" :appIncome,
            "APP_OCC" :appOcc,
            "APP_OTH_OCC" :appOthOcc,
            "APP_POL_CONN" :appPolConn,
            "APP_DOC_PROOF" :appDocProof,
            "APP_INTERNAL_REF" :appInternalRef,
            "APP_BRANCH_CODE" :appBranchCode,
            "APP_MAR_STATUS" :appMarStatus,
            "APP_NETWRTH" :appNetwrth,
            "APP_NETWORTH_DT" :appNetworthDt,
            "APP_INCORP_PLC" :appIncorpPlc,
            "APP_OTHERINFO" :appOtherInfo,
            "APP_ACC_OPENDT" :appAccOpendt,
            "APP_ACC_ACTIVEDT" :appAccActivedt,
            "APP_ACC_UPDTDT" :appAccUpdtdt,
            "APP_FILLER1" :appFiller1,
            "APP_FILLER2" :appFiller2,
            "APP_FILLER3" :appFiller3,
            "APP_STATUS" :appStatus,
            "APP_STATUSDT" :appStatusdt,
            "APP_ERROR_DESC" :appErrorDesc,
            "APP_DUMP_TYPE" :appDumpType,
            "APP_DNLDDT" :appDnlddt,
            "APP_REMARKS" :appRemarks,
            "APP_KYC_MODE" :appKycMode,
            "APP_UID_TOKEN" :appUidToken,
            "APP_VER_NO" :appVerNo,
            "APP_KRA_INFO" :appKraInfo,
            "APP_IOP_FLG" :appIopFlg,
            "APP_SIGNATURE" :appSignature,
        };
}
