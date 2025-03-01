import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'final_screen.dart';
import 'utils.dart';

class OCRTextPage extends StatelessWidget {
  final String ocrText;
  final List<String> healthConditions;
  final Function(String, List<String>) postIngredients;

  const OCRTextPage({
    Key? key,
    required this.ocrText,
    required this.healthConditions,
    required this.postIngredients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text(
                'Scanned Ingredients', 
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800], 
                  fontFamily: GoogleFonts.outfit().fontFamily, 
                ),
                textAlign: TextAlign.start, 
              ),
              SizedBox(height: 30), 
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Text(
                      ocrText,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18.0, 
                        height: 1.5,
                        fontFamily: GoogleFonts.outfit().fontFamily, 
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40), 
              SizedBox(
                width: double.infinity,
                child: ModernButton( 
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueGrey, 
                          ),
                        );
                      },
                    );
                    String response = await postIngredients(ocrText, healthConditions);
                    Navigator.pop(context); 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalScreen(text: response),
                      ),
                    );
                  },
                  text: 'Analyze Ingredients',
                  icon: Icons.search_outlined, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}