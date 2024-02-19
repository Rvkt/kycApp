// To parse this JSON data, do
//
//     final operatorResponse = operatorResponseFromJson(jsonString);

import 'dart:convert';

OperatorResponse operatorResponseFromJson(String str) => OperatorResponse.fromJson(json.decode(str));

String operatorResponseToJson(OperatorResponse data) => json.encode(data.toJson());

class OperatorResponse {
  int? status;
  String? message;
  dynamic errorMessage;
  dynamic size;
  List<Report>? report;

  OperatorResponse({
    this.status,
    this.message,
    this.errorMessage,
    this.size,
    this.report,
  });

  factory OperatorResponse.fromJson(Map<String, dynamic> json) => OperatorResponse(
    status: json["status"],
    message: json["message"],
    errorMessage: json["errorMessage"],
    size: json["size"],
    report: json["report"] == null ? [] : List<Report>.from(json["report"]!.map((x) => Report.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "errorMessage": errorMessage,
    "size": size,
    "report": report == null ? [] : List<dynamic>.from(report!.map((x) => x.toJson())),
  };
}

class Report {
  int? id;
  String? operatorName;
  String? operatorIncode;
  String? operatorOutcode;
  String? operatorProviderName;
  int? serviceType;
  int? apiId;
  bool? status;

  Report({
    this.id,
    this.operatorName,
    this.operatorIncode,
    this.operatorOutcode,
    this.operatorProviderName,
    this.serviceType,
    this.apiId,
    this.status,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    id: json["id"],
    operatorName: json["operatorName"],
    operatorIncode: json["operatorIncode"],
    operatorOutcode: json["operatorOutcode"],
    operatorProviderName: json["operatorProviderName"],
    serviceType: json["serviceType"],
    apiId: json["apiId"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "operatorName": operatorName,
    "operatorIncode": operatorIncode,
    "operatorOutcode": operatorOutcode,
    "operatorProviderName": operatorProviderName,
    "serviceType": serviceType,
    "apiId": apiId,
    "status": status,
  };
}
