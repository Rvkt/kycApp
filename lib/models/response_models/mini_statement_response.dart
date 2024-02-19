// To parse this JSON data, do
//
//     final miniStatementResponse = miniStatementResponseFromJson(jsonString);

import 'dart:convert';

MiniStatementResponse miniStatementResponseFromJson(String str) => MiniStatementResponse.fromJson(json.decode(str));

String miniStatementResponseToJson(MiniStatementResponse data) => json.encode(data.toJson());

class MiniStatementResponse {
  List<MiniStatement>? miniStatement;
  String? message;
  int? status;

  MiniStatementResponse({
    this.miniStatement,
    this.message,
    this.status,
  });

  factory MiniStatementResponse.fromJson(Map<String, dynamic> json) => MiniStatementResponse(
    miniStatement: json["miniStatement"] == null ? [] : List<MiniStatement>.from(json["miniStatement"]!.map((x) => MiniStatement.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "miniStatement": miniStatement == null ? [] : List<dynamic>.from(miniStatement!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class MiniStatement {
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

  MiniStatement({
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

  factory MiniStatement.fromJson(Map<String, dynamic> json) => MiniStatement(
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
