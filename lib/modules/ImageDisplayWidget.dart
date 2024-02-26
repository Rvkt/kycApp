import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/image_provider.dart';

class ImageDisplayWidget extends StatelessWidget {
  final String filename;

  const ImageDisplayWidget({
    Key? key,
    required this.filename,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomImageProvider>(
      builder: (context, imageProvider, _) {
        File? imageFile = imageProvider.imageFile;
        if (imageFile != null) {
          return Image.file(imageFile, height: 36);
        } else {
          return const Icon(Icons.image, size: 36);
        }
      },
    );
  }

  //
  bool containsImage(BuildContext context) {
    final imageProvider = Provider.of<CustomImageProvider>(context, listen: false);
    return imageProvider.fileExists(filename) != null;
  }
}
