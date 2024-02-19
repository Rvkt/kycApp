// To parse this JSON data, do
//
//     final rechargeResponseModel = rechargeResponseModelFromJson(jsonString);

import 'dart:convert';

RechargeResponseModel rechargeResponseModelFromJson(String str) => RechargeResponseModel.fromJson(json.decode(str));

String rechargeResponseModelToJson(RechargeResponseModel data) => json.encode(data.toJson());

class RechargeResponseModel {
  int status;
  String message;
  dynamic errorMessage;
  Data data;

  RechargeResponseModel({
    required this.status,
    required this.message,
    required this.errorMessage,
    required this.data,
  });

  factory RechargeResponseModel.fromJson(Map<String, dynamic> json) => RechargeResponseModel(
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
  int id;
  String userId;
  String mobile;
  String operatorId;
  double openBal;
  double amount;
  double charge;
  double comm;
  double closeBal;
  String tid;
  String status;
  String source;
  int apiId;
  int roleId;
  String wlId;
  DateTime date;
  String time;
  String ip;
  String requestLog;
  String responseLog;
  String orderId;

  Data({
    required this.id,
    required this.userId,
    required this.mobile,
    required this.operatorId,
    required this.openBal,
    required this.amount,
    required this.charge,
    required this.comm,
    required this.closeBal,
    required this.tid,
    required this.status,
    required this.source,
    required this.apiId,
    required this.roleId,
    required this.wlId,
    required this.date,
    required this.time,
    required this.ip,
    required this.requestLog,
    required this.responseLog,
    required this.orderId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["userId"],
    mobile: json["mobile"],
    operatorId: json["operatorId"],
    openBal: json["openBal"],
    amount: json["amount"],
    charge: json["charge"],
    comm: json["comm"],
    closeBal: json["closeBal"],
    tid: json["tid"],
    status: json["status"],
    source: json["source"],
    apiId: json["apiId"],
    roleId: json["roleId"],
    wlId: json["wlId"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    ip: json["ip"],
    requestLog: json["requestLog"],
    responseLog: json["responseLog"],
    orderId: json["orderId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "mobile": mobile,
    "operatorId": operatorId,
    "openBal": openBal,
    "amount": amount,
    "charge": charge,
    "comm": comm,
    "closeBal": closeBal,
    "tid": tid,
    "status": status,
    "source": source,
    "apiId": apiId,
    "roleId": roleId,
    "wlId": wlId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "ip": ip,
    "requestLog": requestLog,
    "responseLog": responseLog,
    "orderId": orderId,
  };
}
