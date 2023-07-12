
import 'dart:convert';

GetDigioData getDigioDataFromJson(String str) => GetDigioData.fromJson(json.decode(str));

String getDigioDataToJson(GetDigioData data) => json.encode(data.toJson());

class GetDigioData {
    String? id;
    DateTime? createdAt;
    String? status;
    String? customerIdentifier;
    String? referenceId;
    RequestDetails? requestDetails;
    String? transactionId;
    String? customerName;
    int? expireInDays;
    bool? reminderRegistered;
    AccessToken? accessToken;
    String? workflowName;
    bool? autoApproved;
    String? message;

    GetDigioData({
        this.id,
        this.createdAt,
        this.status,
        this.customerIdentifier,
        this.referenceId,
        this.requestDetails,
        this.transactionId,
        this.customerName,
        this.expireInDays,
        this.reminderRegistered,
        this.accessToken,
        this.workflowName,
        this.autoApproved,
        this.message,
    });

    factory GetDigioData.fromJson(Map<String, dynamic> json) => GetDigioData(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        status: json["status"],
        customerIdentifier: json["customer_identifier"],
        referenceId: json["reference_id"],
        requestDetails: json["request_details"] == null ? null : RequestDetails.fromJson(json["request_details"]),
        transactionId: json["transaction_id"],
        customerName: json["customer_name"],
        expireInDays: json["expire_in_days"],
        reminderRegistered: json["reminder_registered"],
        accessToken: json["access_token"] == null ? null : AccessToken.fromJson(json["access_token"]),
        workflowName: json["workflow_name"],
        autoApproved: json["auto_approved"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "status": status,
        "customer_identifier": customerIdentifier,
        "reference_id": referenceId,
        "request_details": requestDetails?.toJson(),
        "transaction_id": transactionId,
        "customer_name": customerName,
        "expire_in_days": expireInDays,
        "reminder_registered": reminderRegistered,
        "access_token": accessToken?.toJson(),
        "workflow_name": workflowName,
        "auto_approved": autoApproved,
        "message": message,
    };
}

class AccessToken {
    DateTime? createdAt;
    String? id;
    String? entityId;
    DateTime? validTill;

    AccessToken({
        this.createdAt,
        this.id,
        this.entityId,
        this.validTill,
    });

    factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
        entityId: json["entity_id"],
        validTill: json["valid_till"] == null ? null : DateTime.parse(json["valid_till"]),
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "entity_id": entityId,
        "valid_till": validTill?.toIso8601String(),
    };
}

class RequestDetails {
    RequestDetails();

    factory RequestDetails.fromJson(Map<String, dynamic> json) => RequestDetails(
    );

    Map<String, dynamic> toJson() => {
    };
}
