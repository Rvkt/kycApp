// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:provider/provider.dart';
// import 'package:softmint/constants/api_helpers/api_paths.dart';
// import 'package:softmint/models/bbps_operator_model.dart';
// import 'package:softmint/models/response_models/FetchRechargeFieldResponseModel.dart';
// import 'package:softmint/network/generate_headers.dart';
// import 'package:softmint/network/generate_request.dart';
// import 'package:softmint/network/network_post_call.dart';
// import 'package:softmint/network/network_response.dart';
// import 'package:softmint/utils/dialog_utils.dart';
//
// import '../models/bbps_operators_by_category_model.dart';
//
// class BbpsProvider extends ChangeNotifier {
//   List<BbpsOperatorModel> _bbpsCategoriesList = [];
//   List<Map<String, dynamic>> _bbpsOperatorsList = [];
//
//   List<BbpsOperatorModel> get bbpsCategoriesList => _bbpsCategoriesList;
//
//   List<Map<String, dynamic>> get bbpsOperatorsList => _bbpsOperatorsList;
//
//   setBbpsCategoriesList(List<BbpsOperatorModel> value) {
//     _bbpsCategoriesList = value;
//     notifyListeners();
//   }
//
//   setBbpsOperatorsList(List<Map<String, dynamic>> value) {
//     _bbpsOperatorsList = value;
//     notifyListeners();
//   }
//
//   fetchBbpsOperators() async {
//     // Logger().i('fetchBbpsOperators is called..');
//     final String apiUrl = APIUrl.fetchBbpsOperators;
//     Map<String, String> headers = await GenerateHeaders.withToken();
//
//     try {
//       NetworkResponse networkResponse = await NetworkCall.post(
//         url: apiUrl,
//         headers: headers,
//         body: jsonEncode({}),
//       );
//
//       bool networkResponseStatus = networkResponse.status ?? false;
//
//       // Logger().i(networkResponse.data);
//
//       // Logger().i(networkResponseStatus);
//
//       if (networkResponseStatus) {
//         // Parse the response data
//         final Map<String, dynamic> networkResponseData = json.decode(networkResponse.data ?? "");
//
//         Logger().i(networkResponseData['report']);
//
//         List<dynamic> bbpsOperatorsResponseData = networkResponseData['report'];
//
//         List<BbpsOperatorModel> operatorList = bbpsOperatorsResponseData.map((operator) {
//           return BbpsOperatorModel(
//             id: operator['id'],
//             operatorName: operator['operatorName'],
//             operatorIncode: operator['operatorIncode'],
//             operatorOutcode: operator['operatorOutcode'],
//             operatorProviderName: operator['operatorProviderName'],
//             serviceType: operator['serviceType'],
//             apiId: operator['apiId'],
//             status: operator['status'],
//           );
//         }).toList();
//
//         // Update the list using the setter
//         setBbpsCategoriesList(operatorList);
//       }
//     } catch (e) {
//       Logger().e(e);
//     }
//   }
//
//   fetchOperatorsByCategory(BuildContext context, String category) async {
//     Logger().i('fetchOperatorsByCategory');
//     final String apiUrl = APIUrl.fetchOperatorsByCategory;
//     Map<String, String> headers = await GenerateHeaders.withToken();
//     String body = GenerateRequest.fetchOperatorsByCategory(
//       category: category,
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
//       Logger().i(networkResponseData);
//
//       int status = networkResponseData['status'];
//
//       if (status == 1) {
//         List<dynamic> operatorsByCategoryList = networkResponseData['data'];
//
//         // Logger().i(operatorsByCategoryList);
//
//         List<Map<String, dynamic>> updatedList = operatorsByCategoryList.map((item) {
//           return {'label': item['operatorName'], 'value': item['id']};
//         }).toList();
//
//         setBbpsOperatorsList(updatedList);
//
//         Logger().i(networkResponseData['data']);
//       } else {
//         showCustomDialog(
//           // context: context,
//           message: '${networkResponseData['message']}',
//         );
//       }
//     } catch (e) {
//       Logger().e(e);
//     }
//   }
//
//   fetchRechargeField(BuildContext context, String id) async {
//     final String apiUrl = APIUrl.fetchRechargeField;
//     Map<String, String> headers = await GenerateHeaders.withToken();
//     String body = GenerateRequest.fetchViewFieldByOperator(
//       id: id,
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
//       Logger().i(networkResponseData);
//
//       if (status == 14) {
//         Logger().i('${networkResponseData['message']}\nProceed to the BBPS-RECHARGE');
//       }
//
//       FetchRechargeFieldResponseModel fetchRechargeFieldResponseModel = FetchRechargeFieldResponseModel.fromJson(networkResponseData);
//     } catch (e) {
//       Logger().e(e);
//     }
//   }
// }
