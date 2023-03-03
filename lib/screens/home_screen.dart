import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../constants/api_key.dart';
import '../model/api_model.dart';
import 'keyword_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              var url = Uri.parse('https://api.openai.com/v1/completions');

              Map<String, String> headers = {
                'Content-Type': 'application/json;charset=UTF-8',
                'Charset': 'utf-8',
                'Authorization': 'Bearer $apiKey'
              };

              String promptData =
                  "only generate a list of youtube ideas for keyword ${_controller.value.text} and separate them with a comma";

              print(promptData);
              final data = jsonEncode({
                "model": "gpt-3.5-turbo",
                "prompt": promptData,
                "temperature": 0.4,
                "max_tokens": 64,
                "top_p": 1,
                "frequency_penalty": 0,
                "presence_penalty": 0
              });
              if (_controller.text.isNotEmpty) {
                var response =
                    await http.post(url, headers: headers, body: data);
                if (response.statusCode == 200) {
                  print(response.body);
                  final gptData = gptDataFromJson(response.body);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          KeywordScreen(gptReponseData: gptData)));
                } else {
                  print(response.statusCode);
                }
              }
            },
            child: SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Search',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.search)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
