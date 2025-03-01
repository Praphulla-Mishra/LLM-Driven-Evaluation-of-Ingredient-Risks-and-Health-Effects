import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'utils.dart';
class HealthText extends StatefulWidget {
  const HealthText({Key? key}) : super(key: key);
  @override
  State<HealthText> createState() => _HealthTextState();
}

class _HealthTextState extends State<HealthText> {
  bool _isDiabetic = false;
  bool _hasHypertension = false;
  late TextEditingController _customConditionController;


  Future<void> saveHealthConditions(
      bool isDiabetic, bool hasHypertension, String customCondition) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDiabetic', isDiabetic);
      await prefs.setBool('hasHypertension', hasHypertension);
      await prefs.setString('customCondition', customCondition);
    } catch (e) {
      print("Error saving health conditions: $e");
    }
  }


  Future<void> loadHealthConditions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _isDiabetic = prefs.getBool('isDiabetic') ?? false;
        _hasHypertension = prefs.getBool('hasHypertension') ?? false;
        String? customCondition = prefs.getString('customCondition');
        _customConditionController.text = customCondition ?? "";
      });
    } catch (e) {
      print("Error loading health conditions: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _customConditionController = TextEditingController();
    loadHealthConditions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
          child: SingleChildScrollView( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Text(
                  'Health Details', 
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800], 
                    fontFamily: GoogleFonts.outfit().fontFamily, 
                  ),
                  textAlign: TextAlign.start, 
                ),
                SizedBox(height: 40), 

                Text(
                  "Select your health conditions:",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500, 
                      color: Colors.grey[700], 
                      fontFamily: GoogleFonts.outfit().fontFamily),
                ),
                SizedBox(height: 20), 

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0), 
                  child: CheckboxListTile(
                    title: Text("Diabetes",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal, 
                            color: Colors.grey[800], 
                            fontFamily: GoogleFonts.outfit().fontFamily)),
                    value: _isDiabetic,
                    onChanged: (value) {
                      setState(() {
                        _isDiabetic = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading, 
                    activeColor: Colors.blueGrey[700], 
                    checkColor: Colors.white, 
                    contentPadding: EdgeInsets.symmetric(horizontal: 0), 
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0), 
                  child: CheckboxListTile(
                    title: Text("Hypertension",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal, 
                            color: Colors.grey[800], 
                            fontFamily: GoogleFonts.outfit().fontFamily)),
                    value: _hasHypertension,
                    onChanged: (value) {
                      setState(() {
                        _hasHypertension = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading, 
                    activeColor: Colors.blueGrey[700], 
                    checkColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  ),
                ),
                SizedBox(height: 20), 

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextField(
                    controller: _customConditionController,
                    maxLines: 3,
                    minLines: 3,
                    decoration: InputDecoration(
                      labelText: "Other health conditions",
                      hintText: "List any additional health conditions here...",
                      labelStyle: TextStyle(color: Colors.grey[600], fontFamily: GoogleFonts.outfit().fontFamily), // Label text color
                      hintStyle: TextStyle(color: Colors.grey[500], fontFamily: GoogleFonts.outfit().fontFamily), // Hint text color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12), 
                        borderSide: BorderSide(color: Colors.blueGrey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder( 
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blueGrey.shade500), 
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16), 
                    ),
                    keyboardType: TextInputType.multiline,
                    scrollPadding: const EdgeInsets.all(20.0),
                    textInputAction: TextInputAction.newline,
                    style: TextStyle(color: Colors.grey[800], fontFamily: GoogleFonts.outfit().fontFamily), 
                  ),
                ),
                SizedBox(height: 30), 

                ModernButton( 
                  onPressed: () async {
                    await saveHealthConditions(_isDiabetic, _hasHypertension,
                        _customConditionController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Health Condition Saved',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.blueGrey[700], 
                        elevation: 6,
                        margin: const EdgeInsets.all(10),
                        action: SnackBarAction(
                          label: 'DISMISS',
                          textColor: Colors.tealAccent,
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                    Navigator.pop(context); 
                  },
                  text: "Save Conditions",
                  icon: Icons.save_outlined, 
                ),
                SizedBox(height: 20), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}