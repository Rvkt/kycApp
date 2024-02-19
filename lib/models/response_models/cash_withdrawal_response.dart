// To parse this JSON data, do
//
//     final cashWithdrawalResponse = cashWithdrawalResponseFromJson(jsonString);

import 'dart:convert';

CashWithdrawalResponse cashWithdrawalResponseFromJson(String str) => CashWithdrawalResponse.fromJson(json.decode(str));

String cashWithdrawalResponseToJson(CashWithdrawalResponse data) => json.encode(data.toJson());

class CashWithdrawalResponse {
  List<CashWithdraw>? cashWithdraw;
  int? status;
  String? message;

  CashWithdrawalResponse({
    this.cashWithdraw,
    this.status,
    this.message,
  });

  factory CashWithdrawalResponse.fromJson(Map<String, dynamic> json) => CashWithdrawalResponse(
    cashWithdraw: json["CashWithdraw"] == null ? [] : List<CashWithdraw>.from(json["CashWithdraw"]!.map((x) => CashWithdraw.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "CashWithdraw": cashWithdraw == null ? [] : List<dynamic>.from(cashWithdraw!.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class CashWithdraw {
  String? aadhar;
  String? iin;
  String? type;
  String? amount;
  String? stan;
  String? rrn;
  String? responsecode;
  String? responsemessage;
  String? merchantcode;
  String? location;
  String? remainingbal;
  String? terminalid;
  String? errormessage;
  String? requestid;
  dynamic statement;
  String? status;

  CashWithdraw({
    this.aadhar,
    this.iin,
    this.type,
    this.amount,
    this.stan,
    this.rrn,
    this.responsecode,
    this.responsemessage,
    this.merchantcode,
    this.location,
    this.remainingbal,
    this.terminalid,
    this.errormessage,
    this.requestid,
    this.statement,
    this.status,
  });

  factory CashWithdraw.fromJson(Map<String, dynamic> json) => CashWithdraw(
    aadhar: json["aadhar"],
    iin: json["iin"],
    type: json["type"],
    amount: json["amount"],
    stan: json["stan"],
    rrn: json["rrn"],
    responsecode: json["responsecode"],
    responsemessage: json["responsemessage"],
    merchantcode: json["merchantcode"],
    location: json["location"],
    remainingbal: json["remainingbal"],
    terminalid: json["terminalid"],
    errormessage: json["errormessage"],
    requestid: json["requestid"],
    statement: json["statement"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "aadhar": aadhar,
    "iin": iin,
    "type": type,
    "amount": amount,
    "stan": stan,
    "rrn": rrn,
    "responsecode": responsecode,
    "responsemessage": responsemessage,
    "merchantcode": merchantcode,
    "location": location,
    "remainingbal": remainingbal,
    "terminalid": terminalid,
    "errormessage": errormessage,
    "requestid": requestid,
    "statement": statement,
    "status": status,
  };
}
