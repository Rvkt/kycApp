import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kyc_app/constants/http_constants.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_helpers/api_paths.dart';
import '../core/login/login_screen.dart';
import '../models/user_model.dart';
import '../network/generate_headers.dart';
import '../network/network_post_call.dart';
import '../network/network_response.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  setUserModelResponse(UserModel value) {
    _userModel = value;
    notifyListeners();
  }

  getUserData(BuildContext context) async {
    UserModel? userModel; // Declare as nullable

    SharedPreferences preferences = await SharedPreferences.getInstance();
    late String? tk;
    bool hasToken = preferences.containsKey('token');

    if (hasToken) {
      tk = preferences.getString('token');
    }

    Map<String, String> headers = GenerateHeaders.normal;
    String body = "Bearer $tk";

    // Logger().i(body);

    try {
      NetworkResponse networkResponse = await NetworkCall.post(
        url: APIUrl.validateToken,
        headers: headers,
        body: body,
      );

      // Logger().i(networkResponse.data);

      if (networkResponse.status != null && networkResponse.status == true) {
        Map<String, dynamic> networkResponseData = jsonDecode(networkResponse.data ?? '');
        int status = networkResponseData['status'];

        if (status == INVALID_TOKEN) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        } else if (status == SUCCESS) {
          Map<String, dynamic> userResponseData = networkResponseData['user'];
          // UserModel userResponseData = networkResponseData['user'];
          Logger().w(userResponseData);
          // userModel = UserModel.fromJson(userResponseData);
          // setUserModelResponse(userResponseData);
        }
        // Logger().w(userModel.name);
      }
    } catch (e) {
      Logger().e(e);
    }
    return userModel;
  }
}
