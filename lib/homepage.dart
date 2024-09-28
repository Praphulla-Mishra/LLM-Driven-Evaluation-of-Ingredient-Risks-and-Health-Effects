import 'package:flutter/material.dart';
import 'ocr.dart';
import 'package:ingredients_summarizer/gemini.dart';
import 'final_screen.dart';
import 'package:image_picker/image_picker.dart';
class NutriScanPage extends StatelessWidget {
  final ocr = Ocr();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('NutriScan', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.image, color: Colors.white),
                label:
                    Text('Upload Image', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  await ocr.pickImage(ImageSource.gallery);
                  String response = await gemini(ocr.recognizedText);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinalScreen(text: response),
                    ),
                  );
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 60),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.camera_alt, color: Colors.white),
                label: Text(
                  'Use Camera',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await ocr.pickImage(ImageSource.camera);
                  String response = await gemini(ocr.recognizedText);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinalScreen(text: response),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 60),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
