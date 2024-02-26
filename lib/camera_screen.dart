import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kyc_app/providers/image_provider.dart';
import 'package:kyc_app/shop_verification_screen_via_image.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'merchants_documents_upload_screen.dart';

class CameraApp extends StatefulWidget {
  final String? imageName;

  const CameraApp({Key? key, this.imageName}) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  Future<void>? _initializeControllerFuture;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      cameras = await availableCameras();
      controller = CameraController(cameras[0], ResolutionPreset.max);
      _initializeControllerFuture = controller!.initialize();
      await _initializeControllerFuture; // Wait for controller initialization
      setState(() {}); // Update the state once the camera is initialized
    } catch (e) {
      print('Failed to initialize camera: $e');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      XFile? file = await controller?.takePicture();
      Uint8List data = await file!.readAsBytes();

      Directory cacheDir = await getTemporaryDirectory();
      Logger().i(cacheDir);

      String filePath = '${cacheDir.path}/${widget.imageName}.jpg';
      File newImageFile = File(filePath);

      await newImageFile.writeAsBytes(data);

      Logger().i(newImageFile.path);
      setState(() {
        imageFile = newImageFile;
      });

      CustomImageProvider imageProvider = Provider.of<CustomImageProvider>(context, listen: false);
      if (widget.imageName != null && imageFile != null) {
        imageProvider.saveImage(widget.imageName!, imageFile!);
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ShopVerificationScreen(userImage: newImageFile.path,),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      // appBar: AppBar(title: const Text('Camera Example')),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    Container(
                      // alignment: Alignment.center,
                      // alignment: const Alignment(0, 0),
                      // margin: const EdgeInsets.all(16),
                      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      // width: screenWidth,
                      height: screenHeight,

                      // foregroundDecoration: Decoration(),
                      foregroundDecoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.75),
                        // borderRadius: BorderRadius.circular(20),
                        // border: Border.all(
                        //   width: 2,
                        //   color: Colors.tealAccent,
                        // ),
                      ),
                      child: CameraPreview(controller!),
                    ),
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.5,
                      alignment: const Alignment(0, 0),
                      // padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
                      decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.circular(20),
                          // border: Border.all(width: 2, color: Colors.tealAccent)
                          ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CameraPreview(controller!),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Colors.white.withOpacity(0.5),
              onPressed: () async {
                Logger().i('Capture Image');
                await _takePicture();
              },
              child: const Icon(Icons.camera_alt),
            ),
          ],
        ),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(
        File(imagePath),
      ),
    );
  }
}
