import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthText extends StatefulWidget {
  const HealthText({super.key});

  @override
  State<HealthText> createState() => _HealthTextState();
}

class _HealthTextState extends State<HealthText> {
  bool _isDiabetic = false;
  bool _hasHypertension = false;
  late TextEditingController _customConditionController;

  // Function to save health conditions
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ingredient Insight Assistant',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Select your health conditions:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CheckboxListTile(
                title: const Text("Diabetes",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                value: _isDiabetic,
                onChanged: (value) {
                  setState(() {
                    _isDiabetic = value!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CheckboxListTile(
                title: const Text("Hypertension",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                value: _hasHypertension,
                onChanged: (value) {
                  setState(() {
                    _hasHypertension = value!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                controller: _customConditionController,
                maxLines: 3,
                minLines: 3, // Minimum height for the box
                decoration: const InputDecoration(
                  labelText: "Other health conditions",
                  hintText: "List any additional health conditions here...",
                  border:
                      OutlineInputBorder(), // Adds a border around the TextField
                ),
                keyboardType: TextInputType.multiline,
                scrollPadding: const EdgeInsets.all(
                    20.0), // Optional: adds padding when scrolling
                textInputAction: TextInputAction.newline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () async {
                  saveHealthConditions(_isDiabetic, _hasHypertension,
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
                                behavior: SnackBarBehavior.floating, // Makes it float above other content
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: Colors.grey[900],
                                elevation: 6,
                                margin: const EdgeInsets.all(10), // Adds margin around the snackbar
                                action: SnackBarAction(
                                  label: 'DISMISS',
                                  textColor: Colors.tealAccent, // Modern accent color
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  },
                                ),
                              ),
                            );
                      Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text("Save Conditions",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
