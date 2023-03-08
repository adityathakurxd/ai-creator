import 'dart:convert';

import 'package:ai_creator/screens/script_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/api_key.dart';
import '../model/api_model.dart';

class KeywordScreen extends StatefulWidget {
  String reponseKeywords;

  KeywordScreen({super.key, required this.reponseKeywords});

  @override
  State<KeywordScreen> createState() => _KeywordScreenState();
}

class _KeywordScreenState extends State<KeywordScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Pick a topic to get started")),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 400,
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SelectableText(widget.reponseKeywords,
                            style: const TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 540,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'Paste a topic from above to generate a script',
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        var url = Uri.parse(
                            'https://api.openai.com/v1/chat/completions');

                        Map<String, String> headers = {
                          'Content-Type': 'application/json;charset=UTF-8',
                          'Charset': 'utf-8',
                          'Authorization': 'Bearer $apiKey'
                        };

                        String promptData =
                            "Generate a tiktok video script for the the topic ${_controller.value.text}. Make it short and sweet.";

                        print(promptData);
                        final data = jsonEncode({
                          "model": "gpt-3.5-turbo",
                          "messages": [
                            {"role": "user", "content": promptData}
                          ],
                        });
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => KeywordScreen(
                        //         reponseKeywords:
                        //             "\n\n1. \"10 Ways to Make Money Online\"\n2. \"How to Invest Your Money for Maximum Returns\"\n3. \"Money Management Tips for Young Adults\"\n4. \"How to Start a Successful Business with Little Money\"\n5. \"5 Side Hustles Anyone Can Start Today\"\n6. \"Saving Money on a Tight Budget\"\n7. \"The Top High-Paying Jobs in 2021\"\n8. \"The Psychology of Money: How to Build Wealth Mindset\"\n9. \"How to Make Money by Selling on eBay or Amazon\"\n10. \"Smart Money Moves to Secure Your Financial Future\""

                        //         // gptData.choices[0].message.content
                        //         )));

                        if (_controller.text.isNotEmpty) {
                          var response = await http.post(url,
                              headers: headers, body: data);

                          if (response.statusCode == 200) {
                            print(response.body);
                            final gptData = chatGptModelFromJson(response.body);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ScriptScreen(
                                    reponseKeywords:
                                        gptData.choices[0].message.content)));
                          } else {
                            print(response.body);
                            print(response.statusCode);
                          }
                        }
                      },
                      child: const Text("Generate"))
                ],
              ));
  }
}
