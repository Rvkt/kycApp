import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class CustomImageProvider extends ChangeNotifier {
  File? _imageFile;

  File? get imageFile => _imageFile;

  void setImageFile(File? imageFile) {
    _imageFile = imageFile;
    notifyListeners();
  }

  Future<void> saveImage(String imageName, File imageFile) async {
    try {
      Directory appDir = await getApplicationDocumentsDirectory();
      String imagePath = '${appDir.path}/$imageName.jpg';
      File newImageFile = File(imagePath);

      Logger().i(imagePath);

      if (await newImageFile.exists()) {
        await newImageFile.delete();
      } else {
        await newImageFile.writeAsBytes(await imageFile.readAsBytes());
        setImageFile(newImageFile);
      }
    } catch (e) {
      print('Failed to save image: $e');
    }
  }

  Future<bool> fileExists(String imageName) async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String imagePath = '${appDir.path}/$imageName.jpg';
    File file = File(imagePath);
    return file.exists();
  }



}
