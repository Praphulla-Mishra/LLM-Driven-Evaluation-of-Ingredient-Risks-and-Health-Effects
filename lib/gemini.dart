import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> gemini(String sendtextAI, List<String> healthConditions) async {
  await dotenv.load(fileName: ".env");
  final apiKey = dotenv.env['GEMINI_API']!;
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
    generationConfig: GenerationConfig(
      temperature: 0,
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
    systemInstruction: Content.system('''
    You are an Ingredient Validator. Only analyze and summarize ingredient lists from packaged food. Use the  If the text does not clearly contain ingredients, respond only with: "The provided text is not an ingredient list," and do not provide any further interpretation or summary:

      1.The primary task is to generate a summary of ingredients from the text extracted from an ingredient list on packaged foods. 

      2. The summary should:
        - Include a brief list of key ingredients and their summary.
        - Specifically highlight any substances that might not be healthy for user found in the ingredients, if present.
        
      3. Text provided is extracted via OCR, so there may be spelling or recognition errors. Based on context, accurately predict ingredient names and correct obvious misspellings wherever possible.

      4. Communicate directly to the user in clear and formal language, maintaining abstraction by avoiding overly technical or informal explanations.

      5. Do not use Markdown, as the app cannot render it. But please give new lines for different lines and format it as much as you can without using markdown to make it look good. Give 2 new lines to separate different lines. Give response as points not in a single paragraph.

      6. If the text provided does not appear to contain an ingredient list, clarify to the user that no relevant ingredients were found and refrain from further comments.

      7. MOST IMPORTANT: If the text is not related to ingredient list, say it directly to the user and do not give any other input at all cost. Do not give any comment if the given text is not about product ingredient. No other text than ingredient summarization and guidance on that, DO NOT summarize any other thing. Instead, respond with exactly: "The provided text is not an ingredient list."

      8. Consider the patient's history when crafting your response.  Take name of all these conditions,
   Personalize the guidance based on the specific health conditions provided (if these some values are false or empty then ignore these conditions):
   - Diabetic Status: ${healthConditions[0]}
   - Hypertensive Status: ${healthConditions[1]}
   - Custom Condition: ${healthConditions[2]}
   This ensures that the recommendations are relevant, beneficial, and tailored to the individual's health profile. If some ingredient may cause problem with these particular symptoms then call it out.
      '''),
  );

  final chat = model.startChat(history: [
    Content.multi([
      TextPart(
          'wheat flour, palm oil, salt, wheat gluten, calcium carbonate, potassium chloride, sodium phosphate, potassium carbonate, sodium carbonate, guar gum\n'),
    ]),
    Content.model([
      TextPart(
          'This ingredient list primarily consists of common food ingredients like wheat flour, palm oil, and salt.  However, it also includes some additives that may be considered harmful by some:\n\n Sodium Phosphate:  This is a common food additive used for leavening and texture, but some studies link high consumption to bone health issues.\n Potassium Chloride: This is a salt substitute and generally considered safe, but it can be harmful to people with kidney problems. \n Calcium Carbonate: A common mineral found naturally, it is used here as an anti-caking agent. While generally safe, some individuals might have sensitivities.\n\nOverall, this list contains several ingredients that are common in processed foods. However, the presence of sodium phosphate and potassium chloride  could be a concern for some individuals, depending on their health conditions. \n'),
    ]),
  ]);
  String healthcon = "  health conditions: ${healthConditions[0]},${healthConditions[1]},${healthConditions[2]} :[Personalize response based on these]";
  final message = sendtextAI+healthcon;
  final content = Content.text(message);

  final response = await chat.sendMessage(content);
  final decodedResponse = json.decode(response.text!);
  // print(decodedResponse['response']);
  print(healthConditions[0]);
  print(healthConditions[1]);
  print(healthConditions[2]);
  return decodedResponse['response'];
}
