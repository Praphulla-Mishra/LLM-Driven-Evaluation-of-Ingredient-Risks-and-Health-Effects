import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ingredients_summarizer/homepage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Text Recognition with ML Kit',
        theme: ThemeData(
        primarySwatch: Colors.blueGrey, 
        fontFamily:
            GoogleFonts.outfit().fontFamily, 
      ),
        home: NutriScanPage()
        );
  }
}
