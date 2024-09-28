import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ingredients_summarizer/gemini.dart';

class TextRecognitionScreen extends StatefulWidget {
  @override
  _TextRecognitionScreenState createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  File? _image;
  String _recognizedText = '';

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      _recognizeText();
    }
  }

  Future<void> _recognizeText() async {
    if (_image == null) return;

    final inputImage = InputImage.fromFile(_image!);
    // ignore: deprecated_member_use
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textDetector.processImage(inputImage);

    setState(() {
      _recognizedText = recognizedText.text;
      gemini(_recognizedText);
    });

    textDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognition'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _image != null
              ? Image.file(_image!, height: 200, width: 200)
              : Container(
                  height: 200,
                  width: 200,
                  color: Colors.grey[300],
                  child: Icon(Icons.image, size: 100, color: Colors.grey),
                ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Image from Gallery'),
          ),
          SizedBox(height: 20),
          Text(
            'Recognized Text:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            _recognizedText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
