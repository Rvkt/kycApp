// To parse this JSON data, do
//
//     final transactionReportResponse = transactionReportResponseFromJson(jsonString);

import 'dart:convert';

TransactionReportResponse transactionReportResponseFromJson(String str) => TransactionReportResponse.fromJson(json.decode(str));

String transactionReportResponseToJson(TransactionReportResponse data) => json.encode(data.toJson());

class TransactionReportResponse {
  String message;
  List<TxnReport> txnReport;
  int status;

  TransactionReportResponse({
    required this.message,
    required this.txnReport,
    required this.status,
  });

  factory TransactionReportResponse.fromJson(Map<String, dynamic> json) => TransactionReportResponse(
    message: json["message"],
    txnReport: List<TxnReport>.from(json["TxnReport"].map((x) => TxnReport.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "TxnReport": List<dynamic>.from(txnReport.map((x) => x.toJson())),
    "status": status,
  };
}

class TxnReport {
  int id;
  String userId;
  String mobile;
  String orderId;
  double openingBal;
  double credit;
  int debit;
  double closingBal;
  String narration;
  String remarks;
  DateTime date;
  String time;
  double adopbal;
  double adclbal;
  String wlId;
  int api;
  String txnReportOperator;
  String service;

  TxnReport({
    required this.id,
    required this.userId,
    required this.mobile,
    required this.orderId,
    required this.openingBal,
    required this.credit,
    required this.debit,
    required this.closingBal,
    required this.narration,
    required this.remarks,
    required this.date,
    required this.time,
    required this.adopbal,
    required this.adclbal,
    required this.wlId,
    required this.api,
    required this.txnReportOperator,
    required this.service,
  });

  factory TxnReport.fromJson(Map<String, dynamic> json) => TxnReport(
    id: json["id"],
    userId: json["userId"],
    mobile: json["mobile"],
    orderId: json["orderId"],
    openingBal: json["openingBal"]?.toDouble(),
    credit: json["credit"]?.toDouble(),
    debit: json["debit"],
    closingBal: json["closingBal"]?.toDouble(),
    narration: json["narration"],
    remarks: json["remarks"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    adopbal: json["adopbal"]?.toDouble(),
    adclbal: json["adclbal"]?.toDouble(),
    wlId: json["wlId"],
    api: json["api"],
    txnReportOperator: json["operator"],
    service: json["service"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "mobile": mobile,
    "orderId": orderId,
    "openingBal": openingBal,
    "credit": credit,
    "debit": debit,
    "closingBal": closingBal,
    "narration": narration,
    "remarks": remarks,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "adopbal": adopbal,
    "adclbal": adclbal,
    "wlId": wlId,
    "api": api,
    "operator": txnReportOperator,
    "service": service,
  };
}
