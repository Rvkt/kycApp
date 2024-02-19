import 'package:flutter/material.dart';
import 'package:kyc_app/models/response_models/login_response.dart';
import 'package:kyc_app/providers/auth_provider.dart';
import 'package:kyc_app/widgets/custom_cta_button.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String mobile;
  final String password;

  const OtpVerificationScreen({
    super.key,
    required this.mobile,
    required this.password,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String otp = '';
  // late String username;
  // late String password;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final defaultPinTheme = PinTheme(
      width: 40,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black54),
      ),
    );
    return Scaffold(
      body: Column(
        children: [
          Container(
            // alignment: const Alignment(0, 0),
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Image.asset(
              'assets/logo/logo.png',
              width: screenWidth * 0.6,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'OTP Verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            child: Text(
              '+91 ${widget.mobile}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          Pinput(
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: Colors.green),
              ),
            ),
            onCompleted: (pin) {
              setState(() {
                // mobile = widget.mobile;
                // password = widget.password;
                otp = pin;
              });
            },
          ),
          const SizedBox(
            height: 54,
          ),
          // Container(
          //   constraints: BoxConstraints(maxHeight: screenHeight * 0.08, maxWidth: screenWidth),
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     padding: const EdgeInsets.symmetric(horizontal: 12),
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemBuilder: (context, index) => Container(
          //       margin: const EdgeInsets.symmetric(horizontal: 8),
          //       decoration: BoxDecoration(
          //         color: Colors.grey.shade200,
          //         borderRadius: BorderRadius.circular(20),
          //         border: Border.all(color: Colors.black54),
          //       ),
          //       width: screenWidth * 0.15,
          //       child: Center(
          //         child: Text(index.toString()),
          //       ),
          //     ),
          //     itemCount: 5,
          //   ),
          // ),
          const Spacer(),
          CustomCtaButton(label: 'Verify', onTap: () => verifyUser(context, widget.mobile, widget.password, otp)),
        ],
      ),
    );
  }

  void verifyUser(BuildContext context, String mobile, String password, String otp) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    LoginResponse? loginResponse = await authProvider.validateUserOtp(context, mobile, password, otp);
    Logger().i(loginResponse);
  }
}
