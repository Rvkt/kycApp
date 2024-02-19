import 'package:flutter/material.dart';
import 'package:kyc_app/bank_kyc_screen.dart';
import 'package:kyc_app/fo_verification_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: PageView(
        children: [
          // LoginScreen(),
          // OtpVerificationScreen(),
          // DashboardScreen(),
          BankKycScreen(),
          // MerchantFingerCaptureScreen(),
          // SuccessScreen(),
          // KycDocumentsUploadScreen(),
          // ShowUploadedImageScreen(),
          // MerchantDocumentsUploadScreen(),
          // OtpVerificationScreen(),
          // FoVerificationScreen(),
          // SuccessScreen(),
          // ThankYouScreen(),

        ],
      ),
    );
  }
}

