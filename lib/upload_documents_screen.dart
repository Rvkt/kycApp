import 'package:flutter/material.dart';

class KycDocumentsUploadScreen extends StatefulWidget {
  const KycDocumentsUploadScreen({super.key});

  @override
  State<KycDocumentsUploadScreen> createState() => _KycDocumentsUploadScreenState();
}

class _KycDocumentsUploadScreenState extends State<KycDocumentsUploadScreen> {
  bool checkBoxValue = false;

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
              'Shop Verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
            child: const Text(
              '''We need to verify your Shop. Please Capture the required photos listed below to process
your application.''',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                // fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          // CustomTextFormField(labelText: 'Enter Aadhar Number', keyboardType: TextInputType.number),
          // CustomDropdownWidget(),
          Card(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade50,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.image_rounded,
                        size: 36,
                      ),
                      const Text('Upload Shop"s Image', style: TextStyle(fontWeight: FontWeight.w500),),
                      Icon(Icons.check_circle, color: Colors.lightGreenAccent.shade700,)
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade50,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.image_rounded,
                        size: 36,
                      ),
                      const Text('Upload Your Image', style: TextStyle(fontWeight: FontWeight.w500),),
                      Icon(Icons.upload, color: Colors.black54,)
                    ],
                  ),
                ),
              ],
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
                'Scan',
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
