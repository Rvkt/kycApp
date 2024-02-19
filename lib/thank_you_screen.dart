import 'package:flutter/material.dart';
import 'package:kyc_app/widgets/custom_dropdown_widget.dart';
import 'package:kyc_app/widgets/custom_text_form_field_widget.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

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
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Thank You',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
            child: const Text(
              '''Your Merchant Kyc Uploaded Successfully. Kindly Wait for Final Approval. Dont forget to explore the other features of our app. ''',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,

                // fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            width: 400.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.indigo.shade500,
              border: Border.all(
                color: Colors.indigo.shade500,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Go To Dashboard',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
