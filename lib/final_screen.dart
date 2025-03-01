import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'utils.dart';
import 'homepage.dart';

class FinalScreen extends StatefulWidget {
  final String text;
  const FinalScreen({Key? key, required this.text})
      : super(key: key); 

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(
          0xFFF8F9FA), 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, 
            children: [
              Text(
                'AI Analysis Results', 
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[
                      800],
                  fontFamily:
                      GoogleFonts.outfit().fontFamily, 
                ),
                textAlign: TextAlign.start, 
              ),
              SizedBox(height: 30), 
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[
                        100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(
                      30), 
                  child: SingleChildScrollView(
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        fontSize:
                            18, 
                        fontWeight: FontWeight
                            .w400,
                        color: Colors.grey[
                            800], 
                        fontFamily: GoogleFonts.outfit()
                            .fontFamily, 
                        height: 1.5, 
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ModernButton(
                  onPressed: () {
                     Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NutriScanPage(),
                    ),
                  );
                  },
                  text: 'Go Back',
                  icon: Icons
                      .arrow_back_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
