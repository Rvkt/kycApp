// To parse this JSON data, do
//
//     final bbpsOperatorsResponseModel = bbpsOperatorsResponseModelFromJson(jsonString);

import 'dart:convert';

List<BbpsOperatorsResponseModel> bbpsOperatorsResponseModelFromJson(String str) => List<BbpsOperatorsResponseModel>.from(json.decode(str).map((x) => BbpsOperatorsResponseModel.fromJson(x)));

String bbpsOperatorsResponseModelToJson(List<BbpsOperatorsResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BbpsOperatorsResponseModel {
  int id;
  String operatorName;
  String operatorIncode;
  String operatorOutcode;
  String operatorProviderName;
  int serviceType;
  int apiId;
  bool status;

  BbpsOperatorsResponseModel({
    required this.id,
    required this.operatorName,
    required this.operatorIncode,
    required this.operatorOutcode,
    required this.operatorProviderName,
    required this.serviceType,
    required this.apiId,
    required this.status,
  });

  factory BbpsOperatorsResponseModel.fromJson(Map<String, dynamic> json) => BbpsOperatorsResponseModel(
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