import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kyc_app/constants/http_constants.dart';
import 'package:kyc_app/core/login/login_screen.dart';
import 'package:kyc_app/dashboard_screen.dart';
import 'package:kyc_app/models/response_models/login_response.dart';
import 'package:kyc_app/otp_verification_screen.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_helpers/api_paths.dart';
import '../network/generate_headers.dart';
import '../network/generate_request.dart';
import '../network/network_post_call.dart';
import '../network/network_response.dart';

class AuthProvider with ChangeNotifier {
  LoginResponse? _loginResponse;

  LoginResponse? get loginResponse => _loginResponse;

  setLoginDataResponse(LoginResponse value) {
    _loginResponse = value;
    notifyListeners();
  }

  // bool _isUserActive = false;
  //
  // bool get isUserActive => _isUserActive;
  //
  // void setUserVerification(bool isUserActive) {
  //   _isUserActive = isUserActive;
  //   notifyListeners();
  // }

  void initialize() async {
    Logger().i('Auth Provider initialized');
  }

  authenticateUser(BuildContext context, String username, String password) async {
    final String apiUrl = APIUrl.authenticateUser;
    Map<String, String> headers = await GenerateHeaders.withDeviceId();
    String body = GenerateRequest.authenticateUser(
      username: username,
      password: password,
      source: 'APP',
    );

    try {
      NetworkResponse networkResponse = await NetworkCall.post(
        url: apiUrl,
        headers: headers,
        body: body,
      );
      Logger().i(networkResponse.data);

      LoginResponse loginResponse = loginResponseFromJson(networkResponse.data ?? '');
      setLoginDataResponse(loginResponse);

      SharedPreferences preferences = await SharedPreferences.getInstance();

      // Logger().i(loginResponse.status);

      int status = loginResponse.status;

      if (status == OTP_SUCCESS) {
        Logger().i('Proceed To OTP Screen');
        bool hasToken = preferences.containsKey('token');
        if (hasToken) {
          preferences.remove('token');
        }
        preferences.setString("token", loginResponse.token);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(mobile: username, password: password),
          ),
              (route) => false,
        );
      } else if (status == SUCCESS) {
        Logger().i('Proceed to Dashboard');
        bool hasToken = preferences.containsKey('token');
        if (hasToken) {
          preferences.remove('token');
        }
        preferences.setString("token", loginResponse.token);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
              (route) => false,
        );
      } else if (status == INVALID_TOKEN){
        bool hasToken = preferences.containsKey('token');
        if (hasToken) {
          preferences.remove('token');
        }
        preferences.setString("token", loginResponse.token);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
              (route) => false,
        );
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  validateUserOtp(BuildContext context, String username, String password, String otp) async {
    final String apiUrl = APIUrl.authenticateUser;
    Map<String, String> headers = await GenerateHeaders.withDeviceId();
    String body = GenerateRequest.authenticateUser(
      username: username,
      password: password,
      source: 'APP',
      otp: otp
    );

    try {
      NetworkResponse networkResponse = await NetworkCall.post(
        url: apiUrl,
        headers: headers,
        body: body,
      );
      Logger().i(networkResponse.data);

      LoginResponse loginResponse = loginResponseFromJson(networkResponse.data ?? '');
      setLoginDataResponse(loginResponse);

      SharedPreferences preferences = await SharedPreferences.getInstance();

      // Logger().i(loginResponse.status);

      int status = loginResponse.status;

      if (status == SUCCESS) {
        Logger().i('Proceed to Dashboard');
        bool hasToken = preferences.containsKey('token');
        if (hasToken) {
          preferences.remove('token');
        }
        preferences.setString("token", loginResponse.token);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
              (route) => false,
        );
      } else if (status == FAILED){
        Logger().i(loginResponse.message);
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}



// verifyUser() async {
//   // Logger().i('verifyUser is called....');
//   Map<String, String> headers = GenerateHeaders.normal;
//
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   // bool hasToken = preferences.containsKey('token');
//   // bool hasUserData = preferences.containsKey('user');
//   try {
//     String? token = preferences.getString('token');
//     String body = "Bearer $token";
//     NetworkResponse networkResponse = await NetworkCall.post(
//       url: APIUrl.validateToken,
//       headers: headers,
//       body: body,
//     );
//
//     Logger().i(networkResponse.data);
//
//     int status = jsonDecode(networkResponse.data ?? '')['status'];
//
//     if (status == SUCCESS) {
//       // SharedPreferences preferences = await SharedPreferences.getInstance();
//       // bool hasToken = preferences.containsKey('token');
//       // bool hasUserData = preferences.containsKey('user');
//
//       // if (hasToken) {
//       //   preferences.remove('token');
//       // }
//
//       // if (hasUserData) {
//       //   preferences.remove('user');
//       // }
//
//       // preferences.setString("user", jsonEncode(loginResponse.user));
//       // preferences.setString("token", loginResponse.token ?? "");
//
//       setUserVerification(true);
//       // return true;
//     } else if (status == INVALID_TOKEN) {
//       // Handle the failure case
//       setUserVerification(false);
//       // return false;
//     }
//   } catch (e) {
//     Logger().e(e);
//   }
//
//   // if (hasToken) {
//   //   preferences.remove('token');
//   // }
//
//   // Logger().i(body);
//
//   setUserVerification(false); // Default return value if status is neither SUCCESS nor FAILED
//   // return false;
// }
