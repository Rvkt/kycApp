// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:softmint/constants/api_helpers/api_paths.dart';
// import 'package:softmint/modules/move_to_bank/models/move_to_bank_model.dart';
// import 'package:softmint/network/generate_headers.dart';
// import 'package:softmint/network/generate_request.dart';
// import 'package:softmint/network/network_response.dart';
//
// import '../network/network_post_call.dart';
// import '../utils/dialog_utils.dart';
//
// class CommissionProvider extends ChangeNotifier {
//   // List<BbpsOperatorModel> _bbpsCategoriesList = [];
//   // List<Map<String, dynamic>> _bbpsOperatorsList = [];
//   //
//   // List<BbpsOperatorModel> get bbpsCategoriesList => _bbpsCategoriesList;
//   //
//   // List<Map<String, dynamic>> get bbpsOperatorsList => _bbpsOperatorsList;
//
//   // setBbpsCategoriesList(List<BbpsOperatorModel> value) {
//   //   _bbpsCategoriesList = value;
//   //   notifyListeners();
//   // }
//   //
//   // setBbpsOperatorsList(List<Map<String, dynamic>> value) {
//   //   _bbpsOperatorsList = value;
//   //   notifyListeners();
//   // }
//
//   // fetchBbpsOperators() async {
//   //   // Logger().i('fetchBbpsOperators is called..');
//   //   final String apiUrl = APIUrl.fetchBbpsOperators;
//   //   Map<String, String> headers = await GenerateHeaders.withToken();
//   //
//   //   try {
//   //     NetworkResponse networkResponse = await NetworkCall.post(
//   //       url: apiUrl,
//   //       headers: headers,
//   //       body: jsonEncode({}),
//   //     );
//   //
//   //     bool networkResponseStatus = networkResponse.status ?? false;
//   //
//   //     // Logger().i(networkResponse.data);
//   //
//   //     // Logger().i(networkResponseStatus);
//   //
//   //     if (networkResponseStatus) {
//   //       // Parse the response data
//   //       final Map<String, dynamic> networkResponseData = json.decode(networkResponse.data ?? "");
//   //
//   //       Logger().i(networkResponseData['report']);
//   //
//   //       List<dynamic> bbpsOperatorsResponseData = networkResponseData['report'];
//   //
//   //       // Update the list using the setter
//   //       setBbpsCategoriesList(operatorList);
//   //     }
//   //   } catch (e) {
//   //     Logger().e(e);
//   //   }
//   // }
//
//   fetchChargeByAmount(int amount, String mode, MoveToBankUserModel moveToBankUserModel) async {
//     final String apiUrl = APIUrl.fetchChargeByAmount;
//     Map<String, String> headers = await GenerateHeaders.withToken();
//     String body = GenerateRequest.fetchChargeByAmount(
//       amount: amount,
//       mode: mode,
//       operatorCode: 'YPN',
//     );
//
//     try {
//       NetworkResponse networkResponse = await NetworkCall.post(
//         url: apiUrl,
//         headers: headers,
//         body: body,
//       );
//
//       Map<String, dynamic> networkResponseData = jsonDecode(networkResponse.data ?? '');
//
//       int status = networkResponseData['status'];
//       String message = networkResponseData['message'];
//
//       Logger().i(networkResponseData);
//
//       if (status == 0) {
//         showCustomDialog(context: context, message: message);
//         setState(() {
//           isFetchingCharge = false; // Set to false if status is 0
//         });
//       }
//       if (status == 1) {
//         Map<String, dynamic> dataMap = networkResponseData['data'];
//
//         Logger().i(dataMap);
//
//         if (dataMap.containsKey('charge')) {
//           setState(() {
//             // Set to true if status is 1
//             transferCharge = dataMap['charge'].toString();
//             isFetchingCharge = false;
//             _showAmountConfirmationBottomSheet(context, moveToBankUserModel, amount, dataMap['charge']);
//           });
//         } else {
//           // Handle the case where 'charge' is not present in the data map
//           Logger().e("'charge' not found in data map");
//         }
//       }
//     } catch (e) {
//       Logger().e(e.toString());
//     }
//   }
//
//
// }