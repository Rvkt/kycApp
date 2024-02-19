// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:softmint/constants/http_constants.dart';
// import 'package:softmint/models/response_models/balance_enquiry_response.dart';
// import 'package:softmint/models/response_models/cash_withdrawal_response.dart';
// import 'package:softmint/models/response_models/mini_statement_response.dart';
// import 'package:softmint/modules/aeps/aeps_screen.dart';
// import 'package:softmint/network/generate_request.dart';
//
// import '../constants/api_helpers/api_paths.dart';
// import '../network/generate_headers.dart';
// import '../network/network_post_call.dart';
// import '../network/network_response.dart';
//
// final logger = Logger();
//
// class AepsProvider with ChangeNotifier {
//   BalanceEnquiryResponse? _balanceEnquiryResponse;
//   CashWithdrawalResponse? _cashWithdrawalResponse;
//   MiniStatementResponse? _miniStatementResponse;
//
//   String? _remainingBalance = '';
//
//   List<String?>? _balanceEnquiry = [];
//   List<String?>? _cashWithdrawal = [];
//   List<String?>? _miniStatement = [];
//
//   setBalanceEnquiryDataResponse(BalanceEnquiryResponse value) {
//     _balanceEnquiryResponse = value;
//     notifyListeners();
//   }
//
//   setBalance(String value) {
//     _remainingBalance = value;
//
//     // Notify listeners to rebuild widgets that depend on this provider
//     notifyListeners();
//   }
//
//   setCashWithdrawal(List<String> value) {
//     _cashWithdrawal = value;
//
//     // Notify listeners to rebuild widgets that depend on this provider
//     notifyListeners();
//   }
//
//   setBalanceEnquiry(List<String> value) {
//     _balanceEnquiry = value;
//
//     // Notify listeners to rebuild widgets that depend on this provider
//     notifyListeners();
//   }
//
//   setMiniStatement(List<String> value) {
//     _miniStatement = value;
//
//     // Notify listeners to rebuild widgets that depend on this provider
//     notifyListeners();
//   }
//
//   String? get remainingBalance => _remainingBalance;
//
//   List<String?>? get cashWithdrawal => _cashWithdrawal;
//
//   List<String?>? get balanceEnquiry => _balanceEnquiry;
//
//   List<String?>? get miniStatement => _miniStatement;
//
//   setCashWithdrawalDataResponse(CashWithdrawalResponse value) {
//     _cashWithdrawalResponse = value;
//     notifyListeners();
//   }
//
//   setMiniStatementDataResponse(MiniStatementResponse value) {
//     _miniStatementResponse = value;
//     notifyListeners();
//   }
//
//   Future<Map<String, dynamic>> checkBalanceEnquiry() async {
//     Map<String, String> headers = await GenerateHeaders.withOnlyToken();
//
//     NetworkResponse response = await NetworkCall.post(
//       url: APIUrl.fetchUserBalance,
//       headers: headers,
//     );
//
//     if (response.status != null && response.status == true) {
//       // Logger('User Balance').info(response.data ?? '');
//       Map<String, dynamic> responseBody = jsonDecode(response.data ?? '{}');
//
//       int status = responseBody['status'];
//       String errMsg = responseBody['errorMessage'] ?? "No Error";
//       double data = responseBody['data'];
//
//       return responseBody;
//     }
//     return {
//       'status': 0,
//       'message': "BALANCE NOT FETCHED!!",
//       'data': 0.0,
//     };
//   }
//
//   Future<Map<String, dynamic>> doAepsTransaction(
//       {required String iin,
//       required String aadhar,
//       required String operatorCode,
//       required String mobile,
//       required String txnAmount,
//       required String biometricData}) async {
//     Map<String, String> headers = await GenerateHeaders.withOtpToken();
//
//     String body = GenerateRequest.aepsBalanceEnquiry(
//       iin: iin,
//       aadhar: aadhar,
//       mobile: mobile,
//       operatorIncode: operatorCode,
//       txnAmount: txnAmount,
//       BiometricData: biometricData,
//     );
//
//     // Logger('Balance response').info(body);
//     log(body.toString(), name: 'AEPS Request Body');
//
//     // log(body, name: 'Login response');
//     NetworkResponse response = await NetworkCall.post(
//       url: APIUrl.twoFactorLogin,
//       headers: headers,
//       body: body,
//     );
//
//     // Map<String, dynamic> balanceEnqRes = {
//     //   "BalanceEnquiry": [
//     //     {
//     //       "aadhar": "********7156",
//     //       "iin": "INDIA POST PAYMENTS BANK LIMITED",
//     //       "type": "BALANCE ENQUIRY",
//     //       "amount": "NA",
//     //       "stan": "417470610",
//     //       "rrn": "335317411032",
//     //       "responsecode": "0101",
//     //       "responsemessage": "FAILURE",
//     //       "merchantcode": "SOFTAG9ZJOAS",
//     //       "location": "NA",
//     //       "remainingbal": "00",
//     //       "terminalid": "88989",
//     //       "errormessage": "ERR:Invalid terminal",
//     //       "requestid": "NSDLTXN583027131",
//     //       "statement": null,
//     //       "status": "FAILED"
//     //     }
//     //   ],
//     //   "message": "AEPS BALANCE ENQUIRY FAILED!!",
//     //   "status": 0
//     // };
//     //
//     // Map<String, dynamic> responseMap = {
//     //   "CashWithdraw": [
//     //     {
//     //       "aadhar": "********7156",
//     //       "iin": "INDIA POST PAYMENTS BANK LIMITED",
//     //       "type": "Withdrawl",
//     //       "amount": "100",
//     //       "stan": "792638276",
//     //       "rrn": "335318422461",
//     //       "responsecode": "0101",
//     //       "responsemessage": "FAILURE",
//     //       "merchantcode": "SOFTAG9ZJOAS",
//     //       "location": "NA",
//     //       "remainingbal": "00",
//     //       "terminalid": "88989",
//     //       "errormessage": "ERR:Invalid terminal",
//     //       "requestid": "NSDLTXN339484883",
//     //       "statement": null,
//     //       "status": "FAILED"
//     //     }
//     //   ],
//     //   "status": 0,
//     //   "message": "AEPS TRANSACTION FAILED!!"
//     // };
//     // Map<String, dynamic> responseMap = {
//     //   "miniStatement": [
//     //     {
//     //       "aadhar": "********7156",
//     //       "iin": "INDIA POST PAYMENTS BANK LIMITED",
//     //       "type": "Mini Statement",
//     //       "amount": "NA",
//     //       "stan": "1085795602",
//     //       "rrn": "335313591414",
//     //       "responsecode": "0101",
//     //       "responsemessage": "FAILURE",
//     //       "merchantcode": "SOFTAG9ZJOAS",
//     //       "location": "NA",
//     //       "remainingbal": "00",
//     //       "terminalid": "88989",
//     //       "errormessage": "ERR:Invalid terminal",
//     //       "requestid": "NSDLTXN788328603",
//     //       "statement": null,
//     //       "status": "FAILED"
//     //     }
//     //   ],
//     //   "message": "AEPS MINI STATEMENT FAILED!!",
//     //   "status": 0
//     // };
//
//     Map<String, dynamic> responseMap = jsonDecode(response.data ?? "{}");
//     logger.i(responseMap);
//     if (operatorCode == "ABE") {
//       // Handle Balance Enquiry Response
//       int stCode = responseMap['status'];
//       if (stCode == SUCCESS) {
//         List<dynamic> balList = responseMap['BalanceEnquiry'] ?? [];
//         if (balList.isNotEmpty) {
//           Map<String, dynamic> balResData = balList[0];
//           return {"status": SUCCESS, "data": balResData};
//         } else {
//           return {"message": '${responseMap['message']}', "status": FAILED};
//         }
//       } else if (stCode == FAILED) {
//         List<dynamic> balList = responseMap['BalanceEnquiry'] ?? [];
//         if (balList.isNotEmpty) {
//           Map<String, dynamic> balResData = balList[0];
//           return {"status": SUCCESS, "data": balResData};
//         } else {
//           return {"message": '${responseMap['message']}', "status": FAILED};
//         }
//       } else if (stCode == INVALID_TOKEN) {
//         return {
//           "message": '${responseMap['message']}',
//           "status": INVALID_TOKEN
//         };
//       }
//     } else if (operatorCode == "ACW") {
//       int stCode = responseMap['status'];
//       if (stCode == SUCCESS) {
//         List<dynamic> balList = responseMap['CashWithdraw'] ?? [];
//         if (balList.isNotEmpty) {
//           Map<String, dynamic> balResData = balList[0];
//           return {"status": SUCCESS, "data": balResData};
//         } else {
//           return {"message": '${responseMap['message']}', "status": FAILED};
//         }
//       } else if (stCode == FAILED) {
//         List<dynamic> balList = responseMap['CashWithdraw'] ?? [];
//         if (balList.isNotEmpty) {
//           Map<String, dynamic> balResData = balList[0];
//           return {"status": SUCCESS, "data": balResData};
//         } else {
//           return {"message": '${responseMap['message']}', "status": FAILED};
//         }
//       }
//     } else if (operatorCode == "AMS") {
//       int stCode = responseMap['status'];
//       if (stCode == SUCCESS) {
//         List<dynamic> balList = responseMap['miniStatement'] ?? [];
//         if (balList.isNotEmpty) {
//           Map<String, dynamic> balResData = balList[0];
//           return {"status": SUCCESS, "data": balResData};
//         } else {
//           return {"message": '${responseMap['message']}', "status": FAILED};
//         }
//       } else if (stCode == FAILED) {
//         List<dynamic> balList = responseMap['miniStatement'] ?? [];
//         if (balList.isNotEmpty) {
//           Map<String, dynamic> balResData = balList[0];
//           return {"status": SUCCESS, "data": balResData};
//         } else {
//           return {"message": '${responseMap['message']}', "status": FAILED};
//         }
//       }
//     } else {
//       return {"status": FAILED, "message": "INVALID TRANSACTION TYPE!!"};
//     }
//
//     // if (response.status == true) {
//     //   Map<String, dynamic> responseBody = jsonDecode(response.data ?? '{}');
//     //
//     //   int statusCode = responseBody['status'];
//     //
//     //   if (statusCode == SUCCESS) {
//     //     if (operatorCode == "ABE") {
//     //       // Handle Balance Enquiry Response
//     //     } else if (operatorCode == "ACW") {
//     //       // Handle Cash Withdrawl Response
//     //     } else if (operatorCode == "AMS") {
//     //       // Handle Ministatement Response
//     //     } else {
//     //       // Handle Default response data
//     //     }
//     //   }
//     // }
//
//     // if (response.status != null && response.status == true) {
//     //   log(response.data.toString(), name: 'Balance response');
//     //   BalanceEnquiryResponse balanceEnquiryResponse =
//     //       balanceEnquiryResponseFromJson(response.data ?? "");
//     //   List<BalanceEnquiry> balanceEnquiries =
//     //       balanceEnquiryResponse.balanceEnquiry ?? [];
//     //
//     //   String? remainingBalance = balanceEnquiries.first.remainingbal ?? "";
//     //   setBalance(remainingBalance);
//     //   setBalanceEnquiryDataResponse(balanceEnquiryResponse);
//     //   SharedPreferences preferences = await SharedPreferences.getInstance();
//     //   preferences.setString("balance", remainingBalance);
//     //   // log('${response.toJson()}', name: 'LoginResponse');
//     //
//     //   Logger('UserProvider').info('User Logged-In: ${response.toJson()}');
//     //
//     //   return true;
//     //   // logger.info('${response.toJson()}');
//     //   // logger('UserProviderDataResponse: ${response.toJson()}');
//     // }
//     return {};
//   }
// }
