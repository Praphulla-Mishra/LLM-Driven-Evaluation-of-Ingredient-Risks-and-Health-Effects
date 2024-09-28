import 'dart:io';
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<String> gemini(String sendtextAI) async {
  final apiKey = 'AIzaSyDq3YW4c7_2Zv4VjSxsZVQR2d7Xof_9r7o';
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
    generationConfig: GenerationConfig(
      temperature: 0.3,
      topK: 64,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'application/json',
      responseSchema: Schema(
        SchemaType.object,
        properties: {
          "response": Schema(
            SchemaType.string,
          ),
        },
      ),
    ),
    systemInstruction: Content.system(
        'you are given text extracted from ingredient list mentioned in packaged food and you have to give a breif summary of ingredients used and specially highlight harmful substances found in it, make a short summary of it, also since the text you are getting is taken from image using ocr, so it might have some spelling errors, so try to predict the ingredients properly. You are talking directly to user so have abstraction and use official language.\n'),
  );

  final chat = model.startChat(history: [
    Content.multi([
      TextPart(
          'wheat flour, palm oil, salt, wheat gluten, calcium carbonate, potassium chloride, sodium phosphate, potassium carbonate, sodium carbonate, guar gum\n'),
    ]),
    Content.model([
      TextPart(
          'This ingredient list primarily consists of common food ingredients like wheat flour, palm oil, and salt.  However, it also includes some additives that may be considered harmful by some:\n\n* **Sodium Phosphate:**  This is a common food additive used for leavening and texture, but some studies link high consumption to bone health issues.\n* **Potassium Chloride:** This is a salt substitute and generally considered safe, but it can be harmful to people with kidney problems. \n* **Calcium Carbonate:** A common mineral found naturally, it is used here as an anti-caking agent. While generally safe, some individuals might have sensitivities.\n\nOverall, this list contains several ingredients that are common in processed foods. However, the presence of sodium phosphate and potassium chloride  could be a concern for some individuals, depending on their health conditions. \n'),
    ]),
  ]);
  final message = sendtextAI;
  final content = Content.text(message);

  final response = await chat.sendMessage(content);
  final decodedResponse = json.decode(response.text!);
  return decodedResponse['response'];
  
}
