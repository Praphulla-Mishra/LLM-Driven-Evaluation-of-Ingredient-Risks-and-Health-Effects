import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ingredients_summarizer/ocr.dart';
import 'package:ingredients_summarizer/homepage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Recognition with ML Kit',
      home: NutriScanPage()  //TextRecognitionScreen(),
    );
  }
}
