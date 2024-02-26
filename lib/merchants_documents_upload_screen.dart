import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kyc_app/core/login/login_screen.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import 'camera_screen.dart';
import 'constants/api_helpers/api_paths.dart';
import 'constants/http_constants.dart';
import 'modules/ImageDisplayWidget.dart';
import 'network/generate_headers.dart';
import 'network/network_post_call.dart';
import 'network/network_response.dart';
import 'package:path/path.dart' as path;

String shopImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/shopName.jpg';
String userImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/userImage.jpg';

class MerchantDocumentsUploadScreen extends StatefulWidget {
  const MerchantDocumentsUploadScreen({super.key});

  @override
  State<MerchantDocumentsUploadScreen> createState() => _MerchantDocumentsUploadScreenState();
}

class _MerchantDocumentsUploadScreenState extends State<MerchantDocumentsUploadScreen> {
  bool checkBoxValue = false;

  Widget shopImageWidget = Container();
  Widget userImageWidget = Container();

  File shopImageFile = File(shopImageFilePath);
  File userImageFile = File(userImageFilePath);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        shopImageWidget = shopImageFile.existsSync() ? Image.file(shopImageFile, height: 36, fit: BoxFit.fill) : const Icon(Icons.image_rounded, size: 36);
        userImageWidget = userImageFile.existsSync() ? Image.file(userImageFile, height: 36, fit: BoxFit.fill) : const Icon(Icons.image_rounded, size: 36);
      });
    });
  }

  uploadFile(String shopImageFilePath, String userImageFilePath) async {
    final String apiUrl = APIUrl.yesKycDocumentUpload;
    Map<String, String> headers = await GenerateHeaders.withToken();

    try {
      NetworkResponse networkResponse = await NetworkCall.multipartRequest(
        url: apiUrl,
        headers: headers,
        fields: {
          // 'panfile': 'panfile_value',
          // 'aadharfile': 'aadharfile_value',
          // 'aadharbackfile': 'aadharbackfile_value',
          // 'bankpassbook': 'bankpassbook_value',
          'livephoto': 'livephoto_value',
          'liveshopphoto': 'liveshopphoto_value',
          'latitude': 'latitude_value',
          'longitude': 'longitude_value',
          'agendId': 'agendId_value',
        },
        files: [
          // File('path_to_panfile'),
          // File('path_to_aadharfile'),
          // File('path_to_aadharbackfile'),
          // File('path_to_bankpassbook'),
          File(userImageFilePath),
          File(shopImageFilePath),
        ],
      );

      Map<String, dynamic> networkResponseData = jsonDecode(networkResponse.data ?? '');

      int status = networkResponseData['status'];

      if (status == INVALID_TOKEN) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) {
            return false;
          },
        );
      } else {
        Logger().i(networkResponse.data);
      }

      // Define the API endpoint
      // String apiUrl = APIUrl.yesInitiateAgent;
      // Uri url = Uri.parse(apiUrl);

      // Define the file path
      // String filePath = shopImageFilePath;

      // Create a multipart request
      // var request = http.MultipartRequest('POST', url);

      // Add file to the request
      // request.files.add(
      //   await http.MultipartFile.fromPath(
      //     'file', // API field name for the file
      //     filePath,
      //   ),
      // );

      // Add other form data
      // request.fields['key1'] = 'value1';
      // request.fields['key2'] = 'value2';
      //
      // // Send the request
      // var response = await request.send();
      //
      // // Check the response status code
      // if (response.statusCode == 200) {
      //   // Request successful, do something with the response
      //   var responseData = await response.stream.bytesToString();
      //   print('Response: $responseData');
      // } else {
      //   // Request failed
      //   print('Request failed with status: ${response.statusCode}');
      // }
    } catch (e) {
      // Exception occurred during request
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // bool hasAadharImage = const ImageDisplayWidget(filename: 'aadharfile',).containsImage(context);
    // bool hasPanImage = const ImageDisplayWidget(filename: 'panfile',).containsImage(context);
    // Future<bool> hasAadharImage = checkFileExists('aadharfile');
    // Future<bool> hasPanImage = checkFileExists('panfile');

    return Scaffold(
      body: Column(
        children: [
          Container(
            // alignment: const Alignment(0, 0),
            padding: const EdgeInsets.symmetric(vertical: 24),
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

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shadowColor: Colors.black87,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraApp(
                      imageName: 'panfile',
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade50,
                ),
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const ImageDisplayWidget(filename: 'panfile',),
                    ),
                    const Text(
                      "Upload Pan Card's Image",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.upload,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // CustomTextFormField(labelText: 'Enter Aadhar Number', keyboardType: TextInputType.number),
          // CustomDropdownWidget(),
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
    );
  }
}
