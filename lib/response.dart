import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> postIngredients(String sendtextAI, List<String> healthConditions) async {
  final url = Uri.parse('https://groqserver.onrender.com/process_ingredients');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'sendtextAI': sendtextAI, 'healthConditions': healthConditions}),
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    return responseBody['response'];
  } else {
    throw Exception('Failed to post ingredients');
  }
}

