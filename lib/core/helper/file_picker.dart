import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class AppFilePicker {
  //  Reusable function for converting a picked file into base64
  static Future<String?> _convertFileToBase64(String? filePath)  async {
    if (filePath == null) return null;
    try {
      final file = File(filePath);
      final fileBytes = await file.readAsBytes();
      return base64Encode(fileBytes);
    } catch (e) {
      log('Error converting file: $e');
      return null;
    }
  }

  // Pick Image
  static Future<String?> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(source: ImageSource.gallery);

      if (file == null) return null; // User cancelled

      final fileName = file.name.toLowerCase();
      const allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
      if (!allowedExtensions.any((ext) => fileName.endsWith(ext))) {
        throw Exception(
          'Invalid file format. Please select JPG, JPEG, PNG, or GIF.',
        );
      }

      return await _convertFileToBase64(file.path);
    } catch (e) {
      log('Error picking image: $e');
      return null;
    }
  }

  // Pick PDF
  static Future<String?> pickPdfFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null || result.files.single.path == null) {
        return null; // User cancelled
      }

      return await _convertFileToBase64(result.files.single.path);
    } catch (e) {
      log('Error picking PDF: $e');
      return null;
    }
  }
}
