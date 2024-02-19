// To parse this JSON data, do
//
//     final bankKycResponseModel = bankKycResponseModelFromJson(jsonString);

import 'dart:convert';

BankKycResponseModel bankKycResponseModelFromJson(String str) => BankKycResponseModel.fromJson(json.decode(str));

String bankKycResponseModelToJson(BankKycResponseModel data) => json.encode(data.toJson());

class BankKycResponseModel {
  InitiateAgent initiateAgent;

  BankKycResponseModel({
    required this.initiateAgent,
  });

  factory BankKycResponseModel.fromJson(Map<String, dynamic> json) => BankKycResponseModel(
    initiateAgent: InitiateAgent.fromJson(json["InitiateAgent"]),
  );

  Map<String, dynamic> toJson() => {
    "InitiateAgent": initiateAgent.toJson(),
  };
}

class InitiateAgent {
  String requestId;
  String mobile;
  String status;
  String responseCode;
  String responseMessage;
  String otpToken;
  dynamic agentId;

  InitiateAgent({
    required this.requestId,
    required this.mobile,
    required this.status,
    required this.responseCode,
    required this.responseMessage,
    required this.otpToken,
    required this.agentId,
  });

  factory InitiateAgent.fromJson(Map<String, dynamic> json) => InitiateAgent(
    requestId: json["requestId"],
    mobile: json["mobile"],
    status: json["status"],
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    otpToken: json["otpToken"],
    agentId: json["agent_id"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "mobile": mobile,
    "status": status,
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "otpToken": otpToken,
    "agent_id": agentId,
  };
}
