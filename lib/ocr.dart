import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';




class Ocr{
  File? _image;
  String _recognizedText = '';

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      _image = File(image.path);
      await recognizeText();
    }
  }

  Future<void> recognizeText() async {
    if (_image == null) return;

    final inputImage = InputImage.fromFile(_image!);
    // ignore: deprecated_member_use
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textDetector.processImage(inputImage);

    _recognizedText = recognizedText.text;



    textDetector.close();
  }
  String get recognizedText => _recognizedText;

}
