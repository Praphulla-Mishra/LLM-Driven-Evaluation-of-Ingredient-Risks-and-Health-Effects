import 'package:flutter/material.dart';
import 'ocr.dart';
import 'package:ingredients_summarizer/gemini.dart';
import 'final_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NutriScanPage extends StatefulWidget {
  @override
  State<NutriScanPage> createState() => _NutriScanPageState();
}

class _NutriScanPageState extends State<NutriScanPage> {
  final ocr = Ocr();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('NutriScan', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: isLoading
            ? LoadingAnimationWidget.staggeredDotsWave (
                color: Colors.black,
                size: 200,
              ):
        Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.image, color: Colors.white),
                label:
                    const Text('Upload Image', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                  await ocr.pickImage(ImageSource.gallery);
                    setState(() {
                      isLoading = false;
                    });
                  if (ocr.recognizedText.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });
                    String response = await gemini(ocr.recognizedText);
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalScreen(text: response),
                      ),
                    );
                  }
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
                  setState(() {
                      isLoading = true;
                    });
                  await ocr.pickImage(ImageSource.camera);
                  setState(() {
                      isLoading = false;
                    });
                  if (ocr.recognizedText.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });
                    String response = await gemini(ocr.recognizedText);
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalScreen(text: response),
                      ),
                    );
                  }
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
      ),
    );
  }
}
