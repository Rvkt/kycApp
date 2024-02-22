import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyc_app/camera_screen.dart';
import 'package:kyc_app/constants/api_helpers/api_paths.dart';
import 'package:kyc_app/constants/http_constants.dart';
import 'package:kyc_app/core/login/login_screen.dart';
import 'package:kyc_app/merchants_documents_upload_screen.dart';
import 'package:kyc_app/network/generate_headers.dart';
import 'package:kyc_app/network/network_response.dart';
import 'package:kyc_app/widgets/custom_cta_button.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import 'network/network_post_call.dart';

final MethodChannel _channel = const MethodChannel('camera_channel');
String shopImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/shopName.jpg';
String userImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/userImage.jpg';

class ShopVerificationScreen extends StatefulWidget {
  // final String? shopImage;
  // final String? userImage;

  const ShopVerificationScreen({
    super.key,
  });

  @override
  State<ShopVerificationScreen> createState() => _ShopVerificationScreenState();
}

class _ShopVerificationScreenState extends State<ShopVerificationScreen> {
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
    // Widget shopImageWidget = shopImageFile.existsSync() ? Image.file(shopImageFile, height: 36, fit: BoxFit.fill,) : const Icon(Icons.image_rounded, size: 36);
    // Widget userImageWidget = userImageFile.existsSync() ? Image.file(userImageFile, height: 36, fit: BoxFit.fill,) : const Icon(Icons.image_rounded, size: 36);
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CameraApp(
                          imageName: 'shopName',
                        ),
                      ),
                    );
                    // CameraHandler.openCamera().catchError((error) {
                    //   Logger().i("Failed to open camera: '$error'.");
                    // });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade50,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: shopImageWidget,
                        ),
                        // const Icon(
                        //   Icons.image_rounded,
                        //   size: 36,
                        // ),
                        // Image.file(File(widget.shopImage ?? ''),),
                        const Text(
                          'Upload Shop"s Image',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        shopImageFile.existsSync()
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.lightGreenAccent.shade700,
                              )
                            : Icon(
                                Icons.upload,
                                color: Colors.grey.shade100,
                              ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CameraApp(
                          imageName: 'userImage',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade50,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: userImageWidget,
                        ),
                        const Text(
                          'Upload Your Image',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        userImageFile.existsSync()
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.lightGreenAccent.shade700,
                              )
                            : Icon(
                                Icons.upload,
                                color: Colors.grey.shade100,
                              ),
                        // Icon(
                        //   Icons.upload,
                        //   color: Colors.black54,
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),

          // Display an empty container if file does not exist

          // Row(
          //   children: [
          //     shopImageWidget,
          //     userImageWidget,
          //   ],
          // ),

          // Image.asset('/data/user/0/com.softmintindia.kyc_app/cache/${'shopName'}.jpg' ?? 'assets/logo/logo.png'),
          CustomCtaButton(
            label: 'Proceed',
            onTap: () {
              uploadFile(shopImageFilePath, userImageFilePath);
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
          //       'Upload',
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

// class CameraHandler {
//   static const MethodChannel _channel = MethodChannel('camera_handler');
//
//   static Future<void> openCamera() async {
//     try {
//       await _channel.invokeMethod('openCamera');
//     } on PlatformException catch (e) {
//       Logger().i("Failed to open camera: '${e.message}'.");
//     }
//   }
// }
