import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyc_app/constants/api_helpers/api_paths.dart';
import 'package:kyc_app/merchant_finger_capture_screen.dart';
import 'package:kyc_app/models/response_models/bank_kyc_response_model.dart';
import 'package:kyc_app/models/response_models/yes_biometric_kyc_response_model.dart';
import 'package:kyc_app/models/response_models/yes_otp_creation_response_model.dart';
import 'package:kyc_app/network/generate_headers.dart';
import 'package:kyc_app/network/generate_request.dart';
import 'package:kyc_app/network/network_post_call.dart';
import 'package:kyc_app/network/network_response.dart';
import 'package:kyc_app/success_screen.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../bank_kyc_otp_verification.dart';
import '../merchants_documents_upload_screen.dart';

class BankKycProvider extends ChangeNotifier {
  BankKycResponseModel? _bankKycResponseModel;

  BankKycResponseModel? get bankKycResponseModel => _bankKycResponseModel;

  YesOtpCreationResponseModel? _yesOtpCreationResponseModel;

  YesOtpCreationResponseModel? get yesOtpCreationResponseModel => _yesOtpCreationResponseModel;

  YesBiometricKycResponseModel? _yesBiometricKycResponseModel;

  YesBiometricKycResponseModel? get yesBiometricKycResponseModel => _yesBiometricKycResponseModel;

  void setBankKycResponseModel(BankKycResponseModel value) {
    _bankKycResponseModel = value;
    notifyListeners();
  }

  void setYesOtpCreationResponseModel(YesOtpCreationResponseModel value) {
    _yesOtpCreationResponseModel = value;
    notifyListeners();
  }

  void setYesBiometricKycResponseModel(YesBiometricKycResponseModel value) {
    _yesBiometricKycResponseModel = value;
    notifyListeners();
  }

  Future<void> onboardAgent(
    BuildContext context,
    String firstName,
    String lastName,
    String soapAddress,
    String city,
    String state,
    String pincode,
    String soapName,
    String mobile,
    String dob,
    String gender,
    String pan,
    String email,
    String aadhaar,
  ) async {
    final String apiUrl = APIUrl.yesInitiateAgent;
    Map<String, String> headers = await GenerateHeaders.withToken();
    String body = GenerateRequest.yesInitiateAgent(
        firstName: firstName, lastName: lastName, shopAddress: soapAddress, city: city, state: state, pincode: pincode, shopName: soapName, mobile: mobile, dob: dob, gender: gender, pan: pan, email: email, aadhaar: aadhaar);

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
        if (networkResponseData.containsKey('InitiateAgent')) {
          BankKycResponseModel responseModel = BankKycResponseModel.fromJson(networkResponseData['InitiateAgent']);
          setBankKycResponseModel(responseModel);
          String status = responseModel.status;

          if (status == 'SUCCESS') {
            Logger().i('Proceed To OTP Screen');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BankKycOtpVerificationScreen(
                  message: responseModel.responseMessage,
                  mobile: responseModel.mobile,
                  otpToken: responseModel.otpToken,
                  agentId: responseModel.agentId ?? '',
                ),
              ),
            );
          }
        } else {
          Logger().e('InitiateAgent key not found in network response data');
        }
      } else {
        Logger().e('Network response data is null');
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  otpCreation(
    BuildContext context,
    String mobile,
    String otpToken,
    String otp,
    String agentId,
  ) async {
    final String apiUrl = APIUrl.yesOtpCreation;
    Map<String, String> headers = await GenerateHeaders.withToken();
    String body = GenerateRequest.yesOtpCreation(
      mobile: mobile,
      otp_token: otpToken,
      otp: otp,
      agent_id: agentId,
    );

    // Logger().i(body.toString());

    try {
      NetworkResponse networkResponse = await NetworkCall.post(
        url: apiUrl,
        headers: headers,
        body: body,
      );

      Logger().w(body.toString());
      // Logger().i(networkResponse.data);

      Map<dynamic, dynamic> networkResponseData = jsonDecode(networkResponse.data ?? '');
      Logger().i(networkResponseData);

      if (networkResponse.data != null) {
        // Logger().i('networkResponseData is not null');
        Map<String, dynamic> networkResponseData = jsonDecode(networkResponse.data ?? '');
        if (networkResponseData.containsKey('OtpWadh')) {
          YesOtpCreationResponseModel responseModel = YesOtpCreationResponseModel.fromJson(networkResponseData['OtpWadh']);
          setYesOtpCreationResponseModel(responseModel);

          String status = responseModel.status;
          // String message = responseModel.responseMessage;

          if (status == 'SUCCESS') {
            Logger().i('Proceed To MerchantFingerCaptureScreen');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MerchantFingerCaptureScreen(mobile: mobile, agentId: agentId, kycToken: responseModel.kycToken,),
              ),
            );
          }
        } else {
          Logger().e('OtpWadh key not found in network response data');
        }
      } else {
        Logger().e('Network response data is null');
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  yesBiometricKyc(
    BuildContext context,
    String mobile,
    String agentId,
    String aadhar,
    String biometricData,
    String kycToken,
    String wadh,
  ) async {
    final String apiUrl = APIUrl.yesBiometricKyc;
    Map<String, String> headers = await GenerateHeaders.withToken();
    String body = GenerateRequest.yesBiometricKyc(
      mobile: mobile,
      agent_id: agentId,
      aadhaar: aadhar,
      BiometricData: biometricData,
      kyc_token: kycToken,
      wadh: wadh,
    );

    // Logger().i(body.toString());

    try {
      NetworkResponse networkResponse = await NetworkCall.post(
        url: apiUrl,
        headers: headers,
        body: body,
      );

      Logger().w(body.toString());
      Logger().i(networkResponse.data);

      Map<dynamic, dynamic> networkResponseData = jsonDecode(networkResponse.data ?? '');
      Logger().i(networkResponseData);

      if (networkResponse.data != null) {
        Logger().i('networkResponseData is not null');
        Map<String, dynamic> networkResponseData = jsonDecode(networkResponse.data ?? '');
        if (networkResponseData.containsKey('BiometricKyc')) {
          YesBiometricKycResponseModel responseModel = YesBiometricKycResponseModel.fromJson(networkResponseData['BiometricKyc']);
          setYesBiometricKycResponseModel(responseModel);

          String status = responseModel.status;
          // String message = responseModel.responseMessage;

          if (status == 'SUCCESS') {
            Logger().i('Proceed To OTP Screen');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MerchantDocumentsUploadScreen(),
              ),
            );
          }
        } else {
          Logger().e('OtpWadh key not found in network response data');
        }
      } else {
        Logger().e('Network response data is null');
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
