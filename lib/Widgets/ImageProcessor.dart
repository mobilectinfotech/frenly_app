import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageProcessor {
  static Future<Map<String, dynamic>?> pickAndProcessImage(ImageSource imageSource, CropAspectRatio? aspectRatio) async {
    try {

      //image picker
      final pickedImage = await ImagePicker().pickImage(source: imageSource);
      if (pickedImage == null) return null;
      final originalFileSize = await File(pickedImage.path).length();

      //image cropper


      final croppedFile = await ImageCropper().cropImage(sourcePath: pickedImage.path, aspectRatio: aspectRatio,);
      if (croppedFile == null) return null;

       // image compression

      final compressedImageBytes = await FlutterImageCompress.compressWithList(await croppedFile.readAsBytes());
      final compressedFileSize = compressedImageBytes.length;
      log("originalSize == ${originalFileSize / (1024 * 1024)} in Mb");
      log("compressedSize == ${compressedFileSize / (1024 * 1024)} in Mb");
      return {
        'file': Uint8List.fromList(compressedImageBytes),
        'type': pickedImage.mimeType,
        'name': pickedImage.name,
        'originalSize': originalFileSize,
        'compressedSize': compressedFileSize,
      };
    } catch (e) {
      print('Error picking or processing image: $e');
      return null;
    }
  }
}

