// To parse this JSON data, do
//
//     final yesOtpCreationResponseModel = yesOtpCreationResponseModelFromJson(jsonString);

import 'dart:convert';
import 'dart:core';

class YesBiometricKycResponseModel {
  String requestId;
  String status;
  String responseCode;
  String responseMessage;
  String agentImage;
  String aadhaarName;
  String address;
  String gender;
  String dateOfBirth;
  String emailId;

  YesBiometricKycResponseModel(
      {required this.requestId,
      required this.status,
      required this.responseCode,
      required this.responseMessage,
      required this.agentImage,
      required this.aadhaarName,
      required this.address,
      required this.gender,
      required this.dateOfBirth,
      required this.emailId});

  factory YesBiometricKycResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return YesBiometricKycResponseModel(
      status: json["status"],
      responseCode: json["responseCode"],
      responseMessage: json["responseMessage"],
      requestId: json["requestId"],
      agentImage: json["agentImage"],
      aadhaarName: json["aadhaarName"],
      address: json["address"],
      gender: json["gender"],
      dateOfBirth: json["dateOfBirth"],
      emailId: json["emailId"],
    );
  }


  // Map<String, dynamic> toJson() => {
  //       "status": status,
  //       "responseCode": responseCode,
  //       "responseMessage": responseMessage,
  //       "kycToken": kycToken,
  //       "wadh": wadh,
  //     };
}

// "requestId": "1044445956307",
// "status": "SUCCESS",
// "responseCode": "00",
// "responseMessage": "EKYC has been completed successfully",
// "agentImage": "",
// "aadhaarName": "Mithilesh Gupta",
// "address": "gram-NONAR,post-CHHEWARI,  Chhewari,Nonar,Kaimur (Bhabua),Bihar,821110",
// "gender": "M",
// "dateOfBirth": "30-01-1993",
// "
// emailId":
// "
// mithileshgupta2525
// @gmail.com"
