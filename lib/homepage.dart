import 'package:flutter/material.dart';
import 'ocr.dart';
import 'package:ingredients_summarizer/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ingredients_summarizer/health.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ocrText.dart';
import 'utils.dart';

class NutriScanPage extends StatefulWidget {
  @override
  State<NutriScanPage> createState() => _NutriScanPageState();
}

class _NutriScanPageState extends State<NutriScanPage> {
  final ocr = Ocr();
  bool isLoading = false;
  bool isDiabetic = false;
  bool hasHypertension = false;
  String? customCondition = "none";
  List<String> healthConditions = [];
  Future<void> loadHealthConditions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isDiabetic = prefs.getBool('isDiabetic') ?? false;
        hasHypertension = prefs.getBool('hasHypertension') ?? false;
        customCondition = prefs.getString('customCondition');
        if (customCondition == null) {
          customCondition = "none";
        }
        healthConditions.add("IsDiabetic: $isDiabetic");
        healthConditions.add("HasHypertension: $hasHypertension");
        healthConditions.add("CustomCondition: $customCondition");
      });
    } catch (e) {
      print("Error loading health conditions: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: isLoading
              ? LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.blueGrey[700] ?? Colors.blueGrey,
                  size: 200,
                )
              : Container(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ingredient Insight Assistant',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 60),
                ModernButton(
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
                      await loadHealthConditions();
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OCRTextPage(
                              ocrText: ocr.recognizedText,
                              healthConditions: healthConditions,
                              postIngredients: postIngredients),
                        ),
                      );
                    }
                  },
                  icon: Icons.image_outlined,
                  text: 'Upload Image',
                ),
                SizedBox(height: 20),
                ModernButton(
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

                      await loadHealthConditions();
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OCRTextPage(
                              ocrText: ocr.recognizedText,
                              healthConditions: healthConditions,
                              postIngredients: postIngredients),
                        ),
                      );
                    }
                  },
                  icon: Icons.camera_outlined,
                  text: 'Use Camera',
                ),
                SizedBox(
                    height:
                        30), 
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HealthText()),
                          );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(
                        color: Colors.blueGrey.shade300), 
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HealthText())),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, 
                      children: [
                        Icon(Icons.health_and_safety,
                            color: Colors.blueGrey[600]), 
                        SizedBox(width: 10),
                        Text(
                          'Add/Update Health Conditions',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}
