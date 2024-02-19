import 'package:flutter/material.dart';

class MerchantDocumentsUploadScreen extends StatefulWidget {
  const MerchantDocumentsUploadScreen({super.key});

  @override
  State<MerchantDocumentsUploadScreen> createState() => _MerchantDocumentsUploadScreenState();
}

class _MerchantDocumentsUploadScreenState extends State<MerchantDocumentsUploadScreen> {
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                'Upload Merchants Documents',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
              child: const Text(
                '''We need to verify your information Please submit the documents bellow to process your application.''',
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
                  ),Container(
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
                  ),Container(
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
                  ), Container(
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
                        const Text(
                          'Upload Your Image',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.upload,
                          color: Colors.black54,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const Spacer(),
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
                  'Submit',
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
      ),
    );
  }
}
