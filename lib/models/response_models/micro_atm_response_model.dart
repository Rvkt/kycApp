// To parse this JSON data, do
//
//     final microAtmResponseModel = microAtmResponseModelFromJson(jsonString);

import 'dart:convert';

MicroAtmResponseModel microAtmResponseModelFromJson(String str) => MicroAtmResponseModel.fromJson(json.decode(str));

String microAtmResponseModelToJson(MicroAtmResponseModel data) => json.encode(data.toJson());

class MicroAtmResponseModel {
  bool isStatus;
  String message;
  int transAmount;
  dynamic balAmount;
  String bankRrn;
  String transType;
  int type;
  String cardNum;
  String bankName;
  String terminalId;
  String fpId;
  String errorCode;

  MicroAtmResponseModel({
    required this.isStatus,
    required this.message,
    required this.transAmount,
    required this.balAmount,
    required this.bankRrn,
    required this.transType,
    required this.type,
    required this.cardNum,
    required this.bankName,
    required this.terminalId,
    required this.fpId,
    required this.errorCode,
  });

  factory MicroAtmResponseModel.fromJson(Map<String, dynamic> json) => MicroAtmResponseModel(
    isStatus: json["isStatus"],
    message: json["message"],
    transAmount: json["transAmount"],
    balAmount: json["balAmount"],
    bankRrn: json["bankRrn"],
    transType: json["transType"],
    type: json["type"],
    cardNum: json["cardNum"],
    bankName: json["bankName"],
    terminalId: json["terminalId"],
    fpId: json["fpId"],
    errorCode: json["errorCode"],
  );

  Map<String, dynamic> toJson() => {
    "isStatus": isStatus,
    "message": message,
    "transAmount": transAmount,
    "balAmount": balAmount,
    "bankRrn": bankRrn,
    "transType": transType,
    "type": type,
    "cardNum": cardNum,
    "bankName": bankName,
    "terminalId": terminalId,
    "fpId": fpId,
    "errorCode": errorCode,
  };
}
