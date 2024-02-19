// To parse this JSON data, do
//
//     final balanceEnquiryResponse = balanceEnquiryResponseFromJson(jsonString);

import 'dart:convert';

BalanceEnquiryResponse balanceEnquiryResponseFromJson(String str) => BalanceEnquiryResponse.fromJson(json.decode(str));

String balanceEnquiryResponseToJson(BalanceEnquiryResponse data) => json.encode(data.toJson());

class BalanceEnquiryResponse {
  List<BalanceEnquiry>? balanceEnquiry;
  String? message;
  int? status;

  BalanceEnquiryResponse({
    this.balanceEnquiry,
    this.message,
    this.status,
  });

  factory BalanceEnquiryResponse.fromJson(Map<String, dynamic> json) => BalanceEnquiryResponse(
    balanceEnquiry: json["BalanceEnquiry"] == null ? [] : List<BalanceEnquiry>.from(json["BalanceEnquiry"]!.map((x) => BalanceEnquiry.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "BalanceEnquiry": balanceEnquiry == null ? [] : List<dynamic>.from(balanceEnquiry!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class BalanceEnquiry {
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

  BalanceEnquiry({
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

  factory BalanceEnquiry.fromJson(Map<String, dynamic> json) => BalanceEnquiry(
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
