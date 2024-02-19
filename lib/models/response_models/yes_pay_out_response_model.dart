// To parse this JSON data, do
//
//     final yesPayOutResponseModel = yesPayOutResponseModelFromJson(jsonString);

import 'dart:convert';

YesPayOutResponseModel yesPayOutResponseModelFromJson(String str) => YesPayOutResponseModel.fromJson(json.decode(str));

String yesPayOutResponseModelToJson(YesPayOutResponseModel data) => json.encode(data.toJson());

class YesPayOutResponseModel {
  String status;
  String responseCode;
  String responseMessage;
  String beneficiaryName;
  int amount;
  String account;
  String ifsc;
  String bankname;
  String name;
  String charge;
  DateTime date;
  String rrn;

  YesPayOutResponseModel({
    required this.status,
    required this.responseCode,
    required this.responseMessage,
    required this.beneficiaryName,
    required this.amount,
    required this.account,
    required this.ifsc,
    required this.bankname,
    required this.name,
    required this.charge,
    required this.date,
    required this.rrn,
  });

  factory YesPayOutResponseModel.fromJson(Map<String, dynamic> json) => YesPayOutResponseModel(
    status: json["status"],
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    beneficiaryName: json["beneficiaryName"],
    amount: json["amount"],
    account: json["account"],
    ifsc: json["ifsc"],
    bankname: json["bankname"],
    name: json["name"],
    charge: json["charge"],
    date: DateTime.parse(json["date"]),
    rrn: json["rrn"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "beneficiaryName": beneficiaryName,
    "amount": amount,
    "account": account,
    "ifsc": ifsc,
    "bankname": bankname,
    "name": name,
    "charge": charge,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "rrn": rrn,
  };
}
