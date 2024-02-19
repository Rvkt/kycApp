import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kyc_app/constants/api_helpers/api_paths.dart';
import 'package:kyc_app/models/response_models/bank_kyc_response_model.dart';
import 'package:kyc_app/network/generate_headers.dart';
import 'package:kyc_app/network/generate_request.dart';
import 'package:kyc_app/network/network_post_call.dart';
import 'package:kyc_app/network/network_response.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class BankKycProvider extends ChangeNotifier {
  BankKycResponseModel? _bankKycResponseModel;

  BankKycResponseModel? get bankKycResponseModel => _bankKycResponseModel;

  setBankKycResponseModel(BankKycResponseModel value) {
    _bankKycResponseModel = value;
    notifyListeners();
  }

  initiateAgent(String firstName, String lastName, String soapAddress, String city, String state, String pincode, String soapName, String mobile, String dob, String gender, String pan, String email, String aadhaar) async {
    // BankKycResponseModel? bankKycResponseModel;

    final String apiUrl = APIUrl.initiateAgent;
    Map<String, String> headers = await GenerateHeaders.withToken();
    String body = GenerateRequest.initiateAgent(
      firstName: firstName,
      lastName: lastName,
      shopAddress: soapAddress,
      city: city,
      state: state,
      pincode: pincode,
      shopName: soapName,
      mobile: mobile,
      dob: dob,
      gender: gender,
      pan: pan,
      email: email,
      aadhaar: aadhaar,
    );

    try {
      NetworkResponse networkResponse = await NetworkCall.post(
        url: apiUrl,
        headers: headers,
        body: body,
      );

      Logger().w(body.toString());
      Logger().i(networkResponse.data);

      if (networkResponse.data != null) {
        Map<String, dynamic> networkResponseData = jsonDecode(networkResponse.data ?? '');
        // BankKycResponseModel bankKycResponseModel = bankKycResponseModelFromJson(networkResponse.data ?? '');
        Logger().i(networkResponseData['InitiateAgent']);

        // Logger().i(bankKycResponseModel);

        // setBankKycResponseModel(bankKycResponseModel);

      } else {
        Logger().e('Network response data is null');
      }

      // Map<String, dynamic> networkResponseData = jsonDecode(networkResponse.data ?? '');

      // BankKycResponseModel bankKycResponseModel = bankKycResponseModelFromJson(networkResponse.data ?? '');

      // Logger().i(networkResponseData);

      //
    } catch (e) {
      Logger().e(e);
    }
  }
}
