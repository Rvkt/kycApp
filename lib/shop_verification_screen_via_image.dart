import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyc_app/camera_screen.dart';
import 'package:kyc_app/constants/api_helpers/api_paths.dart';
import 'package:kyc_app/constants/http_constants.dart';
import 'package:kyc_app/core/login/login_screen.dart';
import 'package:kyc_app/merchants_documents_upload_screen.dart';
import 'package:kyc_app/modules/ImageDisplayWidget.dart';
import 'package:kyc_app/network/generate_headers.dart';
import 'package:kyc_app/network/network_response.dart';
import 'package:kyc_app/providers/image_provider.dart';
import 'package:kyc_app/widgets/custom_cta_button.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'network/network_post_call.dart';

const MethodChannel _channel = MethodChannel('camera_channel');

String shopImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/shopName.jpg';
String userImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/userImage.jpg';
String panImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/panImage.jpg';
String aadharFrontImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/aadharFrontImage.jpg';
String aadharBankImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/aadharBankImage.jpg';
String passBookImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/passBookImage.jpg';
String livePhotoImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/livePhotoImage.jpg';
String liveShopPhotoImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/liveShopPhotoImage.jpg';

class ShopVerificationScreen extends StatefulWidget {
  final String? shopImage;
  final String? userImage;
  //
  const ShopVerificationScreen({
    super.key, this.shopImage, this.userImage,
  });

  @override
  State<ShopVerificationScreen> createState() => _ShopVerificationScreenState();
}

class _ShopVerificationScreenState extends State<ShopVerificationScreen> {
  bool checkBoxValue = false;
  Widget shopImageWidget = Container();
  Widget userImageWidget = Container();
  Widget panImageWidget = Container();
  Widget aadharFrontImageWidget = Container();
  Widget aadharBackImageWidget = Container();
  Widget passBookImageWidget = Container();
  Widget livePhotoImageWidget = Container();
  Widget liveShopPhotoImageWidget = Container();

  File shopImageFile = File(shopImageFilePath);
  File userImageFile = File(userImageFilePath);
  File panImageFile = File(panImageFilePath);
  File aadharFrontImageFile = File(aadharFrontImageFilePath);
  File aadharBackImageFile = File(aadharBankImageFilePath);

  File passBookImageFile = File(passBookImageFilePath);
  File livePhotoImageFile = File(livePhotoImageFilePath);
  File liveShopPhotoImageFile = File(liveShopPhotoImageFilePath);

  @override
  void initState() {
    super.initState();
    updateImageWidgets();
  }

  void updateImageWidgets() {
    setState(() {
      shopImageWidget = shopImageFile.existsSync() ? Image.file(shopImageFile, height: 36, fit: BoxFit.fill) : const Icon(Icons.image_rounded, size: 36);
      userImageWidget = userImageFile.existsSync() ? Image.file(userImageFile, height: 36, fit: BoxFit.fill) : const Icon(Icons.image_rounded, size: 36);

      panImageWidget = panImageFile.existsSync() ? Image.file(panImageFile, height: 36, fit: BoxFit.fill) : const Icon(Icons.image_rounded, size: 36);
      aadharFrontImageWidget = aadharFrontImageFile.existsSync() ? Image.file(aadharFrontImageFile, height: 36, fit: BoxFit.fill) : const Icon(Icons.image_rounded, size: 36);
      aadharBackImageWidget = aadharBackImageFile.existsSync() ? Image.file(aadharBackImageFile, height: 36, fit: BoxFit.fill) : const Icon(Icons.image_rounded, size: 36);

      passBookImageWidget = passBookImageFile.existsSync() ? Image.file(passBookImageFile, height: 36, fit: BoxFit.fill) : const Icon(Icons.image_rounded, size: 36);
      livePhotoImageWidget = livePhotoImageFile.existsSync() ? Image.file(livePhotoImageFile, height: 36, fit: BoxFit.fill) : const Icon(Icons.image_rounded, size: 36);
      liveShopPhotoImageWidget = liveShopPhotoImageFile.existsSync() ? Image.file(liveShopPhotoImageFile, height: 36, fit: BoxFit.fill) : const Icon(Icons.image_rounded, size: 36);
    });
  }

  uploadFile(String shopImageFilePath, String userImageFilePath) async {
    final String apiUrl = APIUrl.yesKycDistributorVerify;
    Map<String, String> headers = await GenerateHeaders.withToken();

    try {
      NetworkResponse networkResponse = await NetworkCall.multipartRequest(
        url: apiUrl,
        headers: headers,
        fields: {
          'dismerpic': 'dismerpic_value',
          'shoppic': 'shoppic_value',
          // 'aadharfile': 'aadharfile_value',
          // 'aadharbackfile': 'aadharbackfile_value',
          // 'bankpassbook': 'bankpassbook_value',
          // 'livephoto': 'livephoto_value',
          // 'liveshopphoto': 'liveshopphoto_value',
          // 'latitude': 'latitude_value',
          // 'longitude': 'longitude_value',
          'agendId': 'agendId_value',
          'otp': 'otp'
        },
        files: [
          // File('path_to_panfile'),
          // File('path_to_aadharfile'),
          // File('path_to_aadharbackfile'),
          // File('path_to_bankpassbook'),
          // String shopImageFilePath = '/data/user/0/com.softmintindia.kyc_app/cache/shopName.jpg';
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
    } catch (e) {
      // Exception occurred during request
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool hasImage = const ImageDisplayWidget(
      filename: 'shopName',
    ).containsImage(context);
    bool panImage = const ImageDisplayWidget(
      filename: 'panImage',
    ).containsImage(context);

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


          // const ImageDisplayWidget(
          //   filename: 'shopName',
          // ),
          // CustomTextFormField(labelText: 'Enter Aadhar Number', keyboardType: TextInputType.number),
          // CustomDropdownWidget(),
          // Image.asset(widget.userImage ?? ''),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shadowColor: Colors.black87,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraApp(
                      imageName: 'shopName',
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
                      child: shopImageWidget,
                    ),
                    shopImageFile.existsSync()
                        ? const Text(
                            "Upload Shop's Image",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        : const Text(
                            "Shop's Image Uploaded",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                    shopImageFile.existsSync()
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.lightGreenAccent.shade700,
                          )
                        : Icon(
                            Icons.upload,
                            color: Colors.grey.shade400,
                          ),
                  ],
                ),
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
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: userImageWidget,
                    ),
                    userImageFile.existsSync()
                        ? const Text(
                            "User Image Uploaded",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        : const Text(
                            "Upload User Image",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                    userImageFile.existsSync()
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.lightGreenAccent.shade700,
                          )
                        : Icon(
                            Icons.upload,
                            color: Colors.grey.shade400,
                          ),
                  ],
                ),
              ),
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

class UploadImageWidget extends StatefulWidget {
  const UploadImageWidget({super.key});

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shadowColor: Colors.black87,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CameraApp(
                imageName: 'shopName',
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
                child: File(shopImageFilePath).existsSync()
                    ? Image.file(
                        File(shopImageFilePath),
                        height: 36,
                        fit: BoxFit.fill,
                      )
                    : const Icon(
                        Icons.image_rounded,
                        size: 36,
                      ),
              ),
              const Text(
                'Upload Shop"s Image',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              File(shopImageFilePath).existsSync()
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
    );
  }
}
