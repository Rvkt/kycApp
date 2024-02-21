import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      cameras = await availableCameras();
      controller = CameraController(cameras[0], ResolutionPreset.low);
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
      ByteBuffer byte = data.buffer;
      Navigator.push(
        this.context,
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(imagePath: file.path),
        ),
      );
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Camera Example')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(controller!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () async {
          Logger().i('Capture Image');
          _takePicture();
          // try {
          //   await _initializeControllerFuture;
          //   final image = await controller!.takePicture();
          //   // Use the captured image
          //   print('Image saved to ${image.path}');
          // } catch (e) {
          //   print('Error: $e');
          // }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}


