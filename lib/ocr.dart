import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';

// class Ocr{
//   File? _image;
//   String _recognizedText = '';

//   Future<void> pickImage(ImageSource source) async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: source);
//     if (image != null) {
//       _image = File(image.path);
//       await recognizeText();
//     }
//   }

//   Future<void> recognizeText() async {
//     if (_image == null) return;

//     final inputImage = InputImage.fromFile(_image!);
//     // ignore: deprecated_member_use
//     final textDetector = GoogleMlKit.vision.textRecognizer();
//     final RecognizedText recognizedText = await textDetector.processImage(inputImage);

//     _recognizedText = recognizedText.text;

//     textDetector.close();
//   }
//   String get recognizedText => _recognizedText;

// }

class Ocr {
  File? _image;
  String _recognizedText = '';

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      _image = await _cropImage(File(image.path));
      if (_image != null) {
        await recognizeText();
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ],
        ),
      ],
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }

  Future<void> recognizeText() async {
    if (_image == null) return;

    // final inputImage = InputImage.fromFile(_image!);
    // final textDetector = GoogleMlKit.vision.textRecognizer();
    // final RecognizedText recognizedText = await textDetector.processImage(inputImage);

    // _recognizedText = recognizedText.text;
    // textDetector.close();

    final inputImage = InputImage.fromFile(_image!);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    _recognizedText = recognizedText.text;
    print(_recognizedText);
    textRecognizer.close();
  }

  String get recognizedText => _recognizedText;
}
