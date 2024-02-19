// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:softmint/constants/api_helpers/api_paths.dart';
// import 'package:softmint/network/generate_headers.dart';
// import 'package:softmint/network/generate_request.dart';
// import 'package:softmint/network/network_post_call.dart';
// import 'package:softmint/network/network_response.dart';
// import 'package:softmint/utils/dialog_utils.dart';
//
// class RechargeProvider extends ChangeNotifier {
//   List<Map<String, dynamic>> _dthRechargeOperators = [];
//
//   List<Map<String, dynamic>> get dthRechargeOperators => _dthRechargeOperators;
//
//   void initialize() {
//     // Function to be called at the start of the app
//     Logger().i('Provider initialized');
//     getRechargeOperatorsList;
//     // Perform any setup or initialization logic here
//   }
//
//   setDthRechargeOperatorsResponse(List<Map<String, dynamic>> value) {
//     _dthRechargeOperators = value;
//     notifyListeners();
//   }
//
//   Future<List<Map>?> getRechargePlans(context) async {
//     // final List<Map<String, dynamic>> banksInfoListMap = [];
//
//     final String apiUrl = APIUrl.fetchRechargePlans;
//     Map<String, String> headers = await GenerateHeaders.withToken();
//     String body = GenerateRequest.fetchRechargePlan(
//       type: 'INFO',
//       mobile: '8860733786',
//     );
//
//     try {
//       NetworkResponse response = await NetworkCall.post(
//         url: apiUrl,
//         headers: headers,
//         body: body,
//       );
//
//       dynamic decodedData = jsonDecode(response.data ?? '');
//
//       if (decodedData is List) {
//         // Handle if the decoded data is a List<Map<String, dynamic>>
//         List<Map<dynamic, dynamic>> responseData = List<Map<dynamic, dynamic>>.from(decodedData.map((dynamic item) {
//           return item as Map<String, dynamic>;
//         }));
//
//         Logger().w(responseData);
//         return responseData;
//       } else if (decodedData is Map) {
//         // Handle if the decoded data is a Map<String, dynamic>
//         Logger().w(decodedData);
//         // You might want to return a list with a single map or handle it accordingly
//         return [decodedData];
//       } else {
//         Logger().e('Unexpected data structure');
//         return null;
//       }
//     } catch (e) {
//       Logger().e(e.toString());
//       return null; // Return null in case of an error
//     }
//   }
//
//   Future<List<Map<String, dynamic>>> getRechargeOperatorsList(context) async {
//     List<Map<String, dynamic>> rechargeOperatorsListMap = [];
//
//     final String apiUrl = APIUrl.fetchRechargeOperators;
//     Map<String, String> headers = await GenerateHeaders.withOnlyToken();
//
//     try {
//       NetworkResponse networkResponse = await NetworkCall.post(
//         url: apiUrl,
//         headers: headers,
//       );
//
//       // Logger().i(networkResponse.data);
//
//       bool networkResponseStatus = networkResponse.status ?? false;
//
//       if (networkResponseStatus) {
//         final String responseData = networkResponse.data ?? '';
//
//         if (responseData.isNotEmpty) {
//           final Map<String, dynamic> networkResponseData = jsonDecode(responseData);
//
//           for (var item in networkResponseData['report']) {
//             // Logger().w(item);
//             String operatorName = item['operatorName'];
//             String operatorOutcode = item['operatorOutcode'];
//
//             rechargeOperatorsListMap.add(
//               {
//                 'label': operatorName,
//                 'value': operatorOutcode,
//               },
//             );
//           }
//         }
//       }
//     } catch (e) {
//       Logger().i(e);
//     }
//
//     return rechargeOperatorsListMap;
//   }
//
//   fetchDthRechargeOperatorsList() async {
//     // Logger().i('getMoveToBankUser is called..');
//     final String apiUrl = APIUrl.fetchDthRechargeOperators;
//     Map<String, String> headers = await GenerateHeaders.withToken();
//
//     try {
//       NetworkResponse networkResponse = await NetworkCall.post(
//         url: apiUrl,
//         headers: headers,
//         body: jsonEncode({}),
//       );
//
//       bool responseStatus = networkResponse.status ?? false;
//
//       // Logger().i(networkResponse.data);
//
//       if (responseStatus) {
//         // Parse the response data
//         final Map<String, dynamic> networkResponseData = json.decode(networkResponse.data ?? "");
//
//         Logger().i(networkResponseData['report']);
//
//         List<Map<String, dynamic>> dthRechargeOperatorList = [];
//
//         for (var item in networkResponseData['report']) {
//           Logger().i(item);
//           dthRechargeOperatorList.add(
//             {
//               "label": item['operatorName'],
//               "value": item['operatorOutcode'],
//             },
//           );
//         }
//
//
//
//         // List<Map<String, dynamic>>.from(networkResponseData['report']);
//
//         setDthRechargeOperatorsResponse(dthRechargeOperatorList);
//       }
//     } catch (e) {
//       Logger().e(e);
//     }
//   }
//
//   Future<List<Map<String, dynamic>>> getRechargeReports(context, String startDate, String endDate) async {
//     List<Map<String, dynamic>> rechargeReportsList = [];
//
//     final String apiUrl = APIUrl.fetchRechargeReports;
//     Map<String, String> headers = await GenerateHeaders.withToken();
//     String body = GenerateRequest.fetchRechargeReport(userId: '', status: '', startDate: startDate, endDate: endDate);
//
//     Logger().i(body.toString());
//
//     try {
//       NetworkResponse networkResponse = await NetworkCall.post(url: apiUrl, headers: headers, body: body);
//
//       bool networkResponseStatus = networkResponse.status ?? false;
//
//       if (networkResponseStatus) {
//         final Map<String, dynamic> networkResponseData = jsonDecode(networkResponse.data ?? '');
//
//         Logger().w(networkResponseData['data']);
//         // for (var item in networkResponseData['data']) {
//         //   Logger().w(item);
//         // String operatorName = item['operatorName'];
//         // String operatorOutcode = item['operatorOutcode'];
//         //
//         // rechargeReportsList.add(
//         //   {
//         //     'label': operatorName,
//         //     'value': operatorOutcode,
//         //   },
//         // );
//         // }
//       }
//     } catch (e) {
//       Logger().i(e);
//     }
//
//     return rechargeReportsList;
//   }
// }
