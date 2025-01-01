import 'package:flutter/material.dart';
import 'ocr.dart';
import 'package:ingredients_summarizer/response.dart';
import 'final_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ingredients_summarizer/health.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        appBar: AppBar(
          centerTitle: true,
          title: Text('Ingredient Insight Assistant',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: isLoading
              ? LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.black,
                  size: 200,
                )
              : Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            //upload button
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.image,
                                    color: Colors.white),
                                label: const Text('Upload Image',
                                    style: TextStyle(color: Colors.white)),
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
                                    // String response = await gemini(
                                    // ocr.recognizedText, healthConditions);
                                    String response = await postIngredients(
                                        ocr.recognizedText, healthConditions);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FinalScreen(text: response),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ElevatedButton.icon(
                                icon:
                                    Icon(Icons.camera_alt, color: Colors.white),
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

                                    await loadHealthConditions();
                                    // String response = await gemini(
                                    //     ocr.recognizedText, healthConditions);
                                    String response = await postIngredients(
                                        ocr.recognizedText, healthConditions);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FinalScreen(text: response),
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
                      SizedBox(
                        height: 20,
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          // Navigate to the Health Conditions Page

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HealthText()),
                          );
                        },
                        backgroundColor: Colors.black,
                        icon:
                            Icon(Icons.health_and_safety, color: Colors.white),
                        label: Text(
                          "Add/Update Health Conditions",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
