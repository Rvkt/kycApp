import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kyc_app/constants/api_helpers/api_paths.dart';
import 'package:kyc_app/constants/http_constants.dart';
import 'package:kyc_app/core/login/login_screen.dart';
import 'package:kyc_app/dashboard_screen.dart';
import 'package:kyc_app/network/generate_headers.dart';
import 'package:kyc_app/network/network_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/network_post_call.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool userStatus = false;

  // @override
  // void didChangeDependencies() {
  //   final authProvider = Provider.of<AuthProvider>(context, listen: false);
  //   userStatus = authProvider.isUserActive;
  //
  //   userLogged(); // Move the logic here
  //
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // userStatus = authProvider.isUserActive;

    userLogged();
    super.initState();
  }

  userLogged() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool hasToken = preferences.containsKey("token");

    if (hasToken) {
      String tk = preferences.getString('token') ?? '';
      await validateToken(token: tk);
    }
  }

  validateToken({required String token}) async {
    Map<String, String> headers = GenerateHeaders.normal;

    String body = "Bearer $token";

    NetworkResponse response = await NetworkCall.post(
      url: APIUrl.validateToken,
      headers: headers,
      body: body,
    );

    Map<String, dynamic> responseMap = json.decode(response.data ?? '');

    // logger.w(responseMap);

    int status = responseMap['status'];

    if (status == FAILED || status == INVALID_TOKEN) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
            (route) => false,
      );
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool hasToken = preferences.containsKey("token");
      if (hasToken) {
        preferences.remove('token');
      }
    } else {
      setState(() {
        userStatus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userStatus != true) {
      // User is not authenticated, show a sign-in or registration form
      return const LoginScreen();
    } else {
      // User is authenticated, show the main app screen
      return const DashboardScreen();
    }
  }
}
