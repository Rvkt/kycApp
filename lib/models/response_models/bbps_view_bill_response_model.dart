// To parse this JSON data, do
//
//     final bbpsViewBillResponseModel = bbpsViewBillResponseModelFromJson(jsonString);

import 'dart:convert';

BbpsViewBillResponseModel bbpsViewBillResponseModelFromJson(String str) => BbpsViewBillResponseModel.fromJson(json.decode(str));

String bbpsViewBillResponseModelToJson(BbpsViewBillResponseModel data) => json.encode(data.toJson());

class BbpsViewBillResponseModel {
  ViewBill viewBill;
  String message;
  int status;

  BbpsViewBillResponseModel({
    required this.viewBill,
    required this.message,
    required this.status,
  });

  factory BbpsViewBillResponseModel.fromJson(Map<String, dynamic> json) => BbpsViewBillResponseModel(
    viewBill: ViewBill.fromJson(json["ViewBill"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "ViewBill": viewBill.toJson(),
    "message": message,
    "status": status,
  };
}

class ViewBill {
  List<Datum> data;
  bool success;

  ViewBill({
    required this.data,
    required this.success,
  });

  factory ViewBill.fromJson(Map<String, dynamic> json) => ViewBill(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
  };
}

class Datum {
  String billAmount;
  String billnetamount;
  String dueDate;
  String billdate;
  double minBillAmount;
  bool acceptPartPay;
  String userName;
  bool acceptPayment;
  String cellNumber;

  Datum({
    required this.billAmount,
    required this.billnetamount,
    required this.dueDate,
    required this.billdate,
    required this.minBillAmount,
    required this.acceptPartPay,
    required this.userName,
    required this.acceptPayment,
    required this.cellNumber,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    billAmount: json["billAmount"],
    billnetamount: json["billnetamount"],
    dueDate: json["dueDate"],
    billdate: json["billdate"],
    minBillAmount: json["minBillAmount"],
    acceptPartPay: json["acceptPartPay"],
    userName: json["userName"],
    acceptPayment: json["acceptPayment"],
    cellNumber: json["cellNumber"],
  );

  Map<String, dynamic> toJson() => {
    "billAmount": billAmount,
    "billnetamount": billnetamount,
    "dueDate": dueDate,
    "billdate": billdate,
    "minBillAmount": minBillAmount,
    "acceptPartPay": acceptPartPay,
    "userName": userName,
    "acceptPayment": acceptPayment,
    "cellNumber": cellNumber,
  };
}
