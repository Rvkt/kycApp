// To parse this JSON data, do
//
//     final yesOtpCreationResponseModel = yesOtpCreationResponseModelFromJson(jsonString);

import 'dart:convert';

class YesOtpCreationResponseModel {
  String status;
  String responseCode;
  String responseMessage;
  String kycToken;
  String wadh;

  YesOtpCreationResponseModel({
    required this.status,
    required this.responseCode,
    required this.responseMessage,
    required this.kycToken,
    required this.wadh,
  });

  factory YesOtpCreationResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return YesOtpCreationResponseModel(
      status: json["status"],
      responseCode: json["responseCode"],
      responseMessage: json["responseMessage"],
      kycToken: json["kycToken"],
      wadh: json["wadh"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "kycToken": kycToken,
        "wadh": wadh,
      };
}
