import 'dart:developer';
import 'dart:io';

// import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:device_info/device_info.dart';
// import 'package:softmint/core/auth/login/login_page.dart';
// import 'package:softmint/providers/auth_provider.dart';




class GenerateHeaders {
  static Map<String, String> normal = {"Content-Type": "application/json"};

  static Future<Map<String, String>> withToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // bool hasToken = prefs.containsKey('token');

    // if (hasToken) {
    //   log(prefs.getString("token").toString(), name: 'Contains Token:');
    // }

    // bool? userStatus = await AuthProvider().verifyUser();
    //
    // if (userStatus != null || userStatus == true) {
    //   Logger().i(userStatus);
    // } else {
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const LoginPage(),
    //     ),
    //     (route) => false,
    //   );
    //   // Handle the case where verifyUser returns null
    //   // Logger().e('verifyUser returned null');
    // }

    String token = prefs.getString("token") ?? "";
    Map<String, String> headers = {};
    headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    // log(headers.toString(), name: 'Header With Token');
    return headers;
  }

  static Future<Map<String, String>> withOtpToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // bool hasToken = prefs.containsKey('token');
    //
    // if (hasToken) {
    //   prefs.remove('token');
    // }

    String token = prefs.getString("token") ?? "";

    Map<String, String> headers = {};
    headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    // log(headers.toString(), name: 'Header With OTP Token');
    return headers;
  }

  static Future<Map<String, String>> fetchUserBalanceHeader() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    Map<String, String> headers = {};
    headers = {
      "Authorization": "Bearer $token",
    };
    return headers;
  }

  static Future<Map<String, String>> withOnlyToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    Map<String, String> headers = {};
    headers = {
      "Authorization": "Bearer $token",
    };
    return headers;
  }

  static Future<Map<String, String>> withDeviceId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? deviceId = prefs.getString('deviceId');

    Map<String, String> headers = {};
    headers = {
      "Content-Type": "application/json",
      "deviceId": deviceId!,
    };
    Logger().i('Header With Device ID $headers');
    return headers;
  }
}
