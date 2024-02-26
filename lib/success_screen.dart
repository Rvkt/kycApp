import 'package:flutter/material.dart';
import 'package:kyc_app/merchants_documents_upload_screen.dart';
import 'package:kyc_app/providers/kyc_provider.dart';
import 'package:kyc_app/widgets/custom_cta_button.dart';
import 'package:kyc_app/widgets/custom_dropdown_widget.dart';
import 'package:kyc_app/widgets/custom_text_form_field_widget.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'models/response_models/yes_otp_creation_response_model.dart';
import 'shop_verification_screen_via_image.dart';

class SuccessScreen extends StatefulWidget {
  final String message;

  const SuccessScreen({super.key, required this.message});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
            // alignment: const Alignment(0, 0),
            // padding: const EdgeInsets.symmetric(vertical: 6),
            child: Image.asset(
              'assets/images/confirmed.png',
              width: screenWidth * 0.6,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Bank Verification Successfully Done',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 24),
            child: Text(
              widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,

                // fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const Spacer(),
          CustomCtaButton(
            label: "Let's Go",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MerchantDocumentsUploadScreen(),
              //   ),
              // );
            },
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          //   width: 400.0,
          //   height: 50.0,
          //   decoration: BoxDecoration(
          //     color: Colors.indigo.shade500,
          //     border: Border.all(
          //       color: Colors.indigo.shade500,
          //     ),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: const Center(
          //     child: Text(
          //       'Lets Go',
          //       style: TextStyle(
          //         fontSize: 20,
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
