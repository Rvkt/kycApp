// To parse this JSON data, do
//
//     final fetchRechargeFieldResponseModel = fetchRechargeFieldResponseModelFromJson(jsonString);

import 'dart:convert';

FetchRechargeFieldResponseModel fetchRechargeFieldResponseModelFromJson(String str) => FetchRechargeFieldResponseModel.fromJson(json.decode(str));

String fetchRechargeFieldResponseModelToJson(FetchRechargeFieldResponseModel data) => json.encode(data.toJson());

class FetchRechargeFieldResponseModel {
  int status;
  String message;
  dynamic errorMessage;
  Data data;

  FetchRechargeFieldResponseModel({
    required this.status,
    required this.message,
    required this.errorMessage,
    required this.data,
  });

  factory FetchRechargeFieldResponseModel.fromJson(Map<String, dynamic> json) => FetchRechargeFieldResponseModel(
    status: json["status"],
    message: json["message"],
    errorMessage: json["errorMessage"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "errorMessage": errorMessage,
    "data": data.toJson(),
  };
}

class Data {
  dynamic cn;
  dynamic ad1;
  dynamic ad2;
  dynamic ad3;
  dynamic ad4;
  dynamic fieldType;
  dynamic dataViewDrop;
  dynamic dataRechDrop;

  Data({
    required this.cn,
    required this.ad1,
    required this.ad2,
    required this.ad3,
    required this.ad4,
    required this.fieldType,
    required this.dataViewDrop,
    required this.dataRechDrop,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cn: json["cn"],
    ad1: json["ad1"],
    ad2: json["ad2"],
    ad3: json["ad3"],
    ad4: json["ad4"],
    fieldType: json["fieldType"],
    dataViewDrop: json["dataViewDrop"],
    dataRechDrop: json["dataRechDrop"],
  );

  Map<String, dynamic> toJson() => {
    "cn": cn,
    "ad1": ad1,
    "ad2": ad2,
    "ad3": ad3,
    "ad4": ad4,
    "fieldType": fieldType,
    "dataViewDrop": dataViewDrop,
    "dataRechDrop": dataRechDrop,
  };
}
