
import 'dart:convert';

DigioResponse digioResponseFromJson(String str) => DigioResponse.fromJson(json.decode(str));

String digioResponseToJson(DigioResponse data) => json.encode(data.toJson());

class DigioResponse {
    String? id;
    DateTime? updatedAt;
    DateTime? createdAt;
    String? status;
    String? customerIdentifier;
    List<Action>? actions;
    String? referenceId;
    RequestDetails? requestDetails;
    String? transactionId;
    String? customerName;
    int? expireInDays;
    bool? reminderRegistered;
    String? workflowName;
    bool? autoApproved;

    DigioResponse({
        this.id,
        this.updatedAt,
        this.createdAt,
        this.status,
        this.customerIdentifier,
        this.actions,
        this.referenceId,
        this.requestDetails,
        this.transactionId,
        this.customerName,
        this.expireInDays,
        this.reminderRegistered,
        this.workflowName,
        this.autoApproved,
    });

    factory DigioResponse.fromJson(Map<String, dynamic> json) => DigioResponse(
        id: json["id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        status: json["status"],
        customerIdentifier: json["customer_identifier"],
        actions: json["actions"] == null ? [] : List<Action>.from(json["actions"]!.map((x) => Action.fromJson(x))),
        referenceId: json["reference_id"],
        requestDetails: json["request_details"] == null ? null : RequestDetails.fromJson(json["request_details"]),
        transactionId: json["transaction_id"],
        customerName: json["customer_name"],
        expireInDays: json["expire_in_days"],
        reminderRegistered: json["reminder_registered"],
        workflowName: json["workflow_name"],
        autoApproved: json["auto_approved"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "status": status,
        "customer_identifier": customerIdentifier,
        "actions": actions == null ? [] : List<dynamic>.from(actions!.map((x) => x.toJson())),
        "reference_id": referenceId,
        "request_details": requestDetails?.toJson(),
        "transaction_id": transactionId,
        "customer_name": customerName,
        "expire_in_days": expireInDays,
        "reminder_registered": reminderRegistered,
        "workflow_name": workflowName,
        "auto_approved": autoApproved,
    };
}

class Action {
    String? id;
    String? actionRef;
    String? type;
    String? status;
    String? executionRequestId;
    Details? details;
    RequestDetails? validationResult;
    DateTime? completedAt;
    String? faceMatchObjType;
    String? faceMatchStatus;
    String? objAnalysisStatus;
    bool? processingDone;
    int? retryCount;
    List<SubAction>? subActions;
    String? method;
    RulesData? rulesData;

    Action({
        this.id,
        this.actionRef,
        this.type,
        this.status,
        this.executionRequestId,
        this.details,
        this.validationResult,
        this.completedAt,
        this.faceMatchObjType,
        this.faceMatchStatus,
        this.objAnalysisStatus,
        this.processingDone,
        this.retryCount,
        this.subActions,
        this.method,
        this.rulesData,
    });

    factory Action.fromJson(Map<String, dynamic> json) => Action(
        id: json["id"],
        actionRef: json["action_ref"],
        type: json["type"],
        status: json["status"],
        executionRequestId: json["execution_request_id"],
        details: json["details"] == null ? null : Details.fromJson(json["details"]),
        validationResult: json["validation_result"] == null ? null : RequestDetails.fromJson(json["validation_result"]),
        completedAt: json["completed_at"] == null ? null : DateTime.parse(json["completed_at"]),
        faceMatchObjType: json["face_match_obj_type"],
        faceMatchStatus: json["face_match_status"],
        objAnalysisStatus: json["obj_analysis_status"],
        processingDone: json["processing_done"],
        retryCount: json["retry_count"],
        subActions: json["sub_actions"] == null ? [] : List<SubAction>.from(json["sub_actions"]!.map((x) => SubAction.fromJson(x))),
        method: json["method"],
        rulesData: json["rules_data"] == null ? null : RulesData.fromJson(json["rules_data"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "action_ref": actionRef,
        "type": type,
        "status": status,
        "execution_request_id": executionRequestId,
        "details": details?.toJson(),
        "validation_result": validationResult?.toJson(),
        "completed_at": completedAt?.toIso8601String(),
        "face_match_obj_type": faceMatchObjType,
        "face_match_status": faceMatchStatus,
        "obj_analysis_status": objAnalysisStatus,
        "processing_done": processingDone,
        "retry_count": retryCount,
        "sub_actions": subActions == null ? [] : List<dynamic>.from(subActions!.map((x) => x.toJson())),
        "method": method,
        "rules_data": rulesData?.toJson(),
    };
}

class Details {
    Aadhaar? aadhaar;
    Pan? pan;

    Details({
        this.aadhaar,
        this.pan,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        aadhaar: json["aadhaar"] == null ? null : Aadhaar.fromJson(json["aadhaar"]),
        pan: json["pan"] == null ? null : Pan.fromJson(json["pan"]),
    );

    Map<String, dynamic> toJson() => {
        "aadhaar": aadhaar?.toJson(),
        "pan": pan?.toJson(),
    };
}

class Aadhaar {
    String? idNumber;
    String? documentType;
    String? idProofType;
    String? gender;
    String? image;
    String? name;
    String? dob;
    String? currentAddress;
    String? permanentAddress;
    EntAddressDetails? currentAddressDetails;
    EntAddressDetails? permanentAddressDetails;

    Aadhaar({
        this.idNumber,
        this.documentType,
        this.idProofType,
        this.gender,
        this.image,
        this.name,
        this.dob,
        this.currentAddress,
        this.permanentAddress,
        this.currentAddressDetails,
        this.permanentAddressDetails,
    });

    factory Aadhaar.fromJson(Map<String, dynamic> json) => Aadhaar(
        idNumber: json["id_number"],
        documentType: json["document_type"],
        idProofType: json["id_proof_type"],
        gender: json["gender"],
        image: json["image"],
        name: json["name"],
        dob: json["dob"],
        currentAddress: json["current_address"],
        permanentAddress: json["permanent_address"],
        currentAddressDetails: json["current_address_details"] == null ? null : EntAddressDetails.fromJson(json["current_address_details"]),
        permanentAddressDetails: json["permanent_address_details"] == null ? null : EntAddressDetails.fromJson(json["permanent_address_details"]),
    );

    Map<String, dynamic> toJson() => {
        "id_number": idNumber,
        "document_type": documentType,
        "id_proof_type": idProofType,
        "gender": gender,
        "image": image,
        "name": name,
        "dob": dob,
        "current_address": currentAddress,
        "permanent_address": permanentAddress,
        "current_address_details": currentAddressDetails?.toJson(),
        "permanent_address_details": permanentAddressDetails?.toJson(),
    };
}

class EntAddressDetails {
    String? address;
    String? localityOrPostOffice;
    String? districtOrCity;
    String? state;
    String? pincode;

    EntAddressDetails({
        this.address,
        this.localityOrPostOffice,
        this.districtOrCity,
        this.state,
        this.pincode,
    });

    factory EntAddressDetails.fromJson(Map<String, dynamic> json) => EntAddressDetails(
        address: json["address"],
        localityOrPostOffice: json["locality_or_post_office"],
        districtOrCity: json["district_or_city"],
        state: json["state"],
        pincode: json["pincode"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "locality_or_post_office": localityOrPostOffice,
        "district_or_city": districtOrCity,
        "state": state,
        "pincode": pincode,
    };
}

class Pan {
    String? idNumber;
    String? documentType;
    String? idProofType;
    String? gender;
    String? name;
    String? dob;

    Pan({
        this.idNumber,
        this.documentType,
        this.idProofType,
        this.gender,
        this.name,
        this.dob,
    });

    factory Pan.fromJson(Map<String, dynamic> json) => Pan(
        idNumber: json["id_number"],
        documentType: json["document_type"],
        idProofType: json["id_proof_type"],
        gender: json["gender"],
        name: json["name"],
        dob: json["dob"],
    );

    Map<String, dynamic> toJson() => {
        "id_number": idNumber,
        "document_type": documentType,
        "id_proof_type": idProofType,
        "gender": gender,
        "name": name,
        "dob": dob,
    };
}

class RulesData {
    List<ApprovalRule>? approvalRule;

    RulesData({
        this.approvalRule,
    });

    factory RulesData.fromJson(Map<String, dynamic> json) => RulesData(
        approvalRule: json["approval_rule"] == null ? [] : List<ApprovalRule>.from(json["approval_rule"]!.map((x) => ApprovalRule.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "approval_rule": approvalRule == null ? [] : List<dynamic>.from(approvalRule!.map((x) => x.toJson())),
    };
}

class ApprovalRule {
    String? property;
    String? value;

    ApprovalRule({
        this.property,
        this.value,
    });

    factory ApprovalRule.fromJson(Map<String, dynamic> json) => ApprovalRule(
        property: json["property"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "property": property,
        "value": value,
    };
}

class SubAction {
    String? id;
    String? type;
    String? status;
    String? subActionRef;
    bool? optional;
    String? actioner;
    String? objAnalysisStatus;
    String? faceMatchObjType;
    String? faceMatchStatus;
    DateTime? completedAt;

    SubAction({
        this.id,
        this.type,
        this.status,
        this.subActionRef,
        this.optional,
        this.actioner,
        this.objAnalysisStatus,
        this.faceMatchObjType,
        this.faceMatchStatus,
        this.completedAt,
    });

    factory SubAction.fromJson(Map<String, dynamic> json) => SubAction(
        id: json["id"],
        type: json["type"],
        status: json["status"],
        subActionRef: json["sub_action_ref"],
        optional: json["optional"],
        actioner: json["actioner"],
        objAnalysisStatus: json["obj_analysis_status"],
        faceMatchObjType: json["face_match_obj_type"],
        faceMatchStatus: json["face_match_status"],
        completedAt: json["completed_at"] == null ? null : DateTime.parse(json["completed_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "status": status,
        "sub_action_ref": subActionRef,
        "optional": optional,
        "actioner": actioner,
        "obj_analysis_status": objAnalysisStatus,
        "face_match_obj_type": faceMatchObjType,
        "face_match_status": faceMatchStatus,
        "completed_at": completedAt?.toIso8601String(),
    };
}

class RequestDetails {
    RequestDetails();

    factory RequestDetails.fromJson(Map<String, dynamic> json) => RequestDetails(
    );

    Map<String, dynamic> toJson() => {
    };
}
