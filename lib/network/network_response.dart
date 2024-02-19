// To parse this JSON data, do
//
//     final networkResponse = networkResponseFromJson(jsonString);

import 'dart:convert';

NetworkResponse networkResponseFromJson(String str) => NetworkResponse.fromJson(json.decode(str));

String networkResponseToJson(NetworkResponse data) => json.encode(data.toJson());

class NetworkResponse {
  bool? status;
  String? errorMessage;
  String? data;

  NetworkResponse({
    this.status,
    this.errorMessage,
    this.data,
  });

  factory NetworkResponse.fromJson(Map<String, dynamic> json) => NetworkResponse(
    status: json["status"],
    data: json["data"],
    errorMessage: json["error_message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
    "error_message": errorMessage,
  };
}
