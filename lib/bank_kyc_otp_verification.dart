import 'package:flutter/material.dart';
import 'package:kyc_app/merchant_finger_capture_screen.dart';
import 'package:kyc_app/models/response_models/login_response.dart';
import 'package:kyc_app/providers/auth_provider.dart';
import 'package:kyc_app/providers/kyc_provider.dart';
import 'package:kyc_app/widgets/custom_cta_button.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import 'models/response_models/yes_otp_creation_response_model.dart';

class BankKycOtpVerificationScreen extends StatefulWidget {
  final String message;
  final String mobile;
  final String otpToken;
  final String agentId;

  const BankKycOtpVerificationScreen({
    super.key,
    required this.message,
    required this.mobile,
    required this.otpToken,
    required this.agentId,
  });

  @override
  State<BankKycOtpVerificationScreen> createState() => _BankKycOtpVerificationScreenState();
}

class _BankKycOtpVerificationScreenState extends State<BankKycOtpVerificationScreen> {
  String otp = '';

  // late String username;
  // late String password;

  Future<void> validateAgentOtp(
    BuildContext context,
    String mobile,
    String otpToken,
    String agentId,
  ) async {
    final bankKycProvider = Provider.of<BankKycProvider>(context, listen: false);
    await bankKycProvider.otpCreation(context, widget.mobile, widget.otpToken, otp, widget.agentId);
    YesOtpCreationResponseModel? yesOtpCreationResponseModel = bankKycProvider.yesOtpCreationResponseModel;
    // Logger().i(bankKycProvider.yesOtpCreationResponseModel);
    String? status = yesOtpCreationResponseModel?.status;

    if (status == "SUCCESS") {
      Logger().i('Proceed to merchant finger capture screen');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MerchantFingerCaptureScreen(
            mobile: mobile,
            agentId: agentId,
            kycToken: yesOtpCreationResponseModel!.kycToken,
            wadh: yesOtpCreationResponseModel.wadh,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
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
              'Bank Kyc Otp Verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 36, left: 36, right: 36, top: 16),
            child: Text(
              widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 20,
              ),
            ),
          ),
          Pinput(
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: Colors.indigo),
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
          CustomCtaButton(
            label: 'Verify',
            onTap: () {
              validateAgentOtp(
                context,
                widget.mobile,
                widget.otpToken,
                widget.agentId,
              );
            },
          ),
        ],
      ),
    );
  }
}
