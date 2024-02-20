import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyc_app/bank_kyc_screen.dart';
import 'package:kyc_app/core/auth_screen.dart';
import 'package:kyc_app/dashboard_screen.dart';
import 'package:kyc_app/fo_verification_screen.dart';
import 'package:kyc_app/core/login/login_screen.dart';
import 'package:kyc_app/merchant_finger_capture_screen.dart';
import 'package:kyc_app/merchants_documents_upload_screen.dart';
import 'package:kyc_app/otp_verification_screen.dart';
import 'package:kyc_app/providers/kyc_provider.dart';
import 'package:kyc_app/providers/user_provider.dart';
import 'package:kyc_app/thank_you_screen.dart';
import 'package:kyc_app/upload_documents_screen.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/auth_provider.dart';
import 'show_uploaded_screen.dart';
import 'success_screen.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    const MyApp(),
  );
  getDeviceId();
}

// Future<String?> getDeviceId() async {
//   if (Platform.isAndroid) {
//     try {
//       MethodChannel methodChannel = const MethodChannel('device_id');
//       dynamic result = await methodChannel.invokeMethod('getAndroidId');
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       if (result != null && result is String) {
//         prefs.setString('deviceId', result);
//         Logger().i('Device ID: $result');
//         return result;
//       } else {
//         return 'Failed to get Android ID.';
//       }
//     } on PlatformException {
//       return 'Failed to get Android ID.';
//     }
//   } else if (Platform.isIOS) {
//     // For iOS, you can use the 'identifierForVendor'
//     return Platform.environment['IOS_ID'];
//   } else {
//     // For other platforms, return a default value
//     return 'Unknown';
//   }
// }

Future<String?> getDeviceId() async {
  if (Platform.isAndroid) {
    try {
      MethodChannel methodChannel = const MethodChannel('device_id');
      dynamic result = await methodChannel.invokeMethod('getAndroidId');
      if (result != null && result is String) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('deviceId', result);
        Logger().i('Device ID: $result');
        return result;
      } else {
        return 'Failed to get Android ID.';
      }
    } on PlatformException {
      return 'Failed to get Android ID.';
    }
  }
  return null;
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BankKycProvider(),
        ),
      ],
      child: const MaterialApp(
        // debugShowMaterialGrid: true,
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        // home: PageView(
        //   children: const [
            // LoginScreen(),
            // OtpVerificationScreen(),
            // DashboardScreen(),
            // BankKycScreen(),
            // OtpVerificationScreen(),
            // MerchantFingerCaptureScreen(),
            // SuccessScreen(),
            // KycDocumentsUploadScreen(),
            // ShowUploadedImageScreen(),
            // MerchantDocumentsUploadScreen(),
            // OtpVerificationScreen(),
            // FoVerificationScreen(),
            // ThankYouScreen(),
          // ],
        // ),
        // navigatorKey: navigatorKey,
        home: AuthScreen(),
      ),
    );
  }
}
