// This class is used to generate request body for network calls
import 'dart:convert';

class GenerateRequest {
  static String validateToken({
    required String token,
  }) {
    return jsonEncode({
      "token": "Bearer $token",
    });
  }

  static String authenticateUser({required String username, required String password, String source = 'APP', String? otp}) {
    return jsonEncode({"userName": username, "password": password, 'source': source, 'otp': otp});
  }

  static String loginWithUsernameAndPasswordOTP({required String username, required String password, required String source, required String otp}) {
    Map<String, dynamic> requestMap = {'userName': username, 'password': password, 'source': source, 'otp': otp};
    // Convert the map to a JSON string
    String jsonString = jsonEncode(requestMap);
    return jsonString;
  }

  static String operatorIncode({
    required String operatorIncode,
    required String biometricData,
  }) {
    return jsonEncode({
      "operatorIncode": "2FALOGIN",
      "BiometricData": biometricData,
    });
  }

  // NSDL AEPS status check
  static String aepsStatusCheck() {
    return jsonEncode({});
  }

  // nsdl aeps register
  static String nsdlAepsRegister({
    required String operatorIncode,
  }) {
    return jsonEncode({
      'operatorIncode': operatorIncode,
    });
  }

  // NSDL AEPS Login
  static String warehouseAeps({
    required String iin,
    // required String aadhar,
    required String operatorIncode,
    // required String mobile,
    // required String txnAmount,
    required String BiometricData,
  }) {
    return jsonEncode({
      'inn': iin,
      // 'aadhar': aadhar,
      'operatorIncode': operatorIncode,
      // 'mobile': mobile,
      // 'txnAmount': txnAmount,
      'BiometricData': BiometricData,
    });
  }

  static String aepsBalanceEnquiry({
    required String iin,
    required String aadhar,
    String operatorIncode = "ABE",
    required String mobile,
    required String txnAmount,
    required String BiometricData,
  }) {
    return jsonEncode({
      'iin': iin,
      'aadhar': aadhar,
      'operatorIncode': operatorIncode,
      'mobile': mobile,
      'txnAmount': txnAmount,
      'BiometricData': BiometricData,
    });
  }

  static String aepsCashWithdrawal({
    required String iin,
    required String aadhar,
    String operatorIncode = "ACW",
    required String mobile,
    required String txnAmount,
    required String BiometricData,
  }) {
    return jsonEncode({
      'iin': iin,
      'aadhar': aadhar,
      'operatorIncode': operatorIncode,
      'mobile': mobile,
      'txnAmount': txnAmount,
      'BiometricData': BiometricData,
    });
  }

  static String aepsMiniStatement({
    required String iin,
    required String aadhar,
    String operatorIncode = "AMS",
    required String mobile,
    required String txnAmount,
    required String BiometricData,
  }) {
    return jsonEncode({
      'iin': iin,
      'aadhar': aadhar,
      'operatorIncode': operatorIncode,
      'mobile': mobile,
      'txnAmount': txnAmount,
      'BiometricData': BiometricData,
    });
  }

  static String nsdlAepsKyc({
    required String operatorIncode,
    required String bcagentid,
    required String bcagentname,
    required String middlename,
    required String lastname,
    required String address,
    required String statename,
    required String cityname,
    required String district,
    required String pincode,
    required String mobilenumber,
    required String dob,
    required String pancard,
    required String gender,
  }) {
    return jsonEncode({
      'operatorIncode': operatorIncode,
      'bcagentid': bcagentid,
      'bcagentname': bcagentname,
      'middlename': middlename,
      'lastname': lastname,
      'address': address,
      'statename': statename,
      'cityname': cityname,
      'district': district,
      'pincode': pincode,
      'mobilenumber': mobilenumber,
      'dob': dob,
      'pancard': pancard,
      'gender': gender,
    });
  }

  // TODO: User related request bodies
  static String transactionReport({
    String mobile = '',
    required String userId,
    String service = '',
    String operator = '',
    String narration = '',
    String txnid = '',
    String api = '',
    required String startdate,
    required String enddate,
  }) {
    return jsonEncode({
      'mobile': mobile,
      'userId': userId,
      'service': service,
      'operator': operator,
      'narration': narration,
      'txnid': txnid,
      'api': api,
      'startdate': startdate,
      'enddate': enddate,
    });
  }

  static String nsdlAepsReport({
    required String userId,
    required String status,
    required String startDate,
    required String endDate,
  }) {
    return jsonEncode({'userId': userId, 'status': status, 'startDate': startDate, 'endDate': endDate});
  }

  static String addMoveToBankUser({
    final int? id,
    final String? beneId,
    required final String bankName,
    required final String beneAccNo,
    required final String beneIFSC,
    required final String remName,
    required final String remMobile,
    final String? status,
    final String? userId,
    final String? validateName,
  }) {
    return jsonEncode({"id": id, "beneId": beneId, "bankName": bankName, "beneIFSC": beneIFSC, "beneAccNo": beneAccNo, "remName": remName, "remMobile": remMobile, "status": status, "userId": userId, "validateName": validateName});
  }

  static String updateMoveToBankUser({
    final int? id,
    final String? beneId,
    required final String bankName,
    required final String beneAccNo,
    required final String beneIFSC,
    required final String remName,
    required final String remMobile,
    final String? status,
    final String? userId,
    final String? validateName,
  }) {
    return jsonEncode({"id": id, "beneId": beneId, "bankName": bankName, "beneIFSC": beneIFSC, "beneAccNo": beneAccNo, "remName": remName, "remMobile": remMobile, "status": status, "userId": userId, "validateName": validateName});
  }

  static String transferToBankUser({
    required String operatorIncode,
    required String amount,
    required String beneId,
    required String mode,
    required String charge,
  }) {
    return jsonEncode({
      "operatorIncode": operatorIncode,
      "amount": amount,
      "beneId": beneId,
      "mode": mode,
      "charge": charge,
    });
  }

  // TODO: Recharge related api requests
  static String initiateRecharge({
    required String mobile,
    required int amount,
    required String operatorCode,
  }) {
    return jsonEncode({
      'mobile': mobile,
      'amount': amount,
      'operatorCode': operatorCode,
    });
  }

  static String fetchRechargePlan({
    required String type,
    required String mobile,
  }) {
    return jsonEncode({
      'type': type,
      'mobile': mobile,
    });
  }

  static String fetchRechargeReport({
    required String userId,
    required String status,
    required String startDate,
    required String endDate,
  }) {
    return jsonEncode({
      'userid': userId,
      'status': status,
      'toDate': endDate,
      'fromDate': startDate,
    });
  }

  // TODO: commission related api requests
  static String fetchEarningReport({
    required String startDate,
    required String endDate,
    required int roleId,
    required String userId,
  }) {
    return jsonEncode({
      'startDate': startDate,
      'endDate': endDate,
      'roleId': roleId,
      'userId': userId,
    });
  }

  static String fetchChargeByAmount({
    required int amount,
    required String mode,
    required String operatorCode,
  }) {
    return jsonEncode({
      "amount": amount,
      "mode": mode,
      "operatorCode": operatorCode,
    });
  }

  // TODO: Fetch Payout Reports requests
  static String fetchYesPayOutReports({
    required String userId,
    required String status,
    required String startDate,
    required String endDate,
  }) {
    return jsonEncode({
      'userid': userId,
      'status': status,
      'startDate': startDate,
      'endDate': endDate,
    });
  }

  static String fetchOperatorsByCategory({
    required String category,
  }) {
    return jsonEncode({
      'category': category,
    });
  }

  static String fetchViewFieldByOperator({
    required String id,
  }) {
    return jsonEncode({
      'id': id,
    });
  }

  static String fetchBbpsBillByOperator({
    required String operatorInCode,
    required String bbpsOperatorId,
    required String cn,
    required String? mobileNumber,
    String? ad1,
    String? ad2,
    String? ad3,
    String? ad4,
    String? paymentAd1,
    String? paymentAd2,
    String? paymentAd3,
    String? paymentAd4,
  }) {
    return jsonEncode({
      'operatorInCode': operatorInCode,
      'bbpsOperatorId': bbpsOperatorId,
      'cn': cn,
      'mobileNumber': mobileNumber,
      'viewAd1': ad1,
      'viewAd2': ad1,
      'viewAd3': ad1,
      'viewAd4': ad1,
    });
  }

  static String initiateBbpsRecharge({
    required String operatorInCode,
    required String bbpsOperatorId,
    required String cn,
    required String amount,
  }) {
    return jsonEncode({
      'operatorInCode': operatorInCode,
      'bbpsOperatorId': bbpsOperatorId,
      'cn': cn,
      'amount': amount,
    });
  }

  static String yesInitiateAgent({
    String operatorIncode = "YPN",
    required String firstName,
    required String lastName,
    required String shopAddress,
    required String city,
    required String state,
    required String pincode,
    required String shopName,
    required String mobile,
    required String dob,
    required String gender,
    required String pan,
    required String email,
    required String aadhaar,
  }) {
    Map<String, dynamic> requestMap = {
      'operatorIncode': operatorIncode,
      'firstName': firstName,
      'lastName': lastName,
      'shopAddress': shopAddress,
      'city': city,
      'state': state,
      'pincode': pincode,
      'shopName': shopName,
      'mobile': mobile,
      'dob': dob,
      'gender': gender,
      'pan': pan,
      'email': email,
      'aadhaar': aadhaar,
    };
    // Convert the map to a JSON string
    String jsonString = jsonEncode(requestMap);
    return jsonString;
  }

  static String yesOtpCreation({
    String operatorIncode = "YPN",
    required String mobile,
    required String otp_token,
    required String otp,
    required String agent_id,
  }) {
    Map<String, dynamic> requestMap = {
      'operatorIncode': operatorIncode,
      'mobile': mobile,
      'otp_token': otp_token,
      'otp': otp,
      'agent_id': agent_id,
    };
    // Convert the map to a JSON string
    String jsonString = jsonEncode(requestMap);
    return jsonString;
  }

  static String yesBiometricKyc({
    String operatorIncode = "YPN",
    required String mobile,
    required String agent_id,
    required String aadhaar,
    required String BiometricData,
    required String kyc_token,
    required String wadh,
  }) {
    Map<String, dynamic> requestMap = {
      'operatorIncode': operatorIncode,
      'mobile': mobile,
      'agent_id': agent_id,
      'aadhaar': aadhaar,
      'BiometricData': BiometricData,
      'kyc_token': kyc_token,
      'wadh': wadh,
    };
    // Convert the map to a JSON string
    String jsonString = jsonEncode(requestMap);
    return jsonString;
  }
}
