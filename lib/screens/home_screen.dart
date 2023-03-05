import 'dart:convert';
import 'package:ai_creator/model/api_model.dart';
import 'package:flutter/material.dart';
import '../constants/api_key.dart';
import 'keyword_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Creator Suite"),
      ),
      body: Column(
        children: [
          const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text("Start by entering a topic on your mind 🤯"),
              )),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
              setState(() {
                isLoading = true;
              });
              var url = Uri.parse('https://api.openai.com/v1/chat/completions');

              Map<String, String> headers = {
                'Content-Type': 'application/json;charset=UTF-8',
                'Charset': 'utf-8',
                'Authorization': 'Bearer $apiKey'
              };

              String promptData =
                  "only generate a list of youtube ideas for keyword ${_controller.value.text}.";

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
                var response =
                    await http.post(url, headers: headers, body: data);

                if (response.statusCode == 200) {
                  print(response.body);
                  final gptData = chatGptModelFromJson(response.body);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => KeywordScreen(
                          reponseKeywords:
                              gptData.choices[0].message.content)));
                } else {
                  print(response.body);
                  print(response.statusCode);
                }
              }
            },
            child: SizedBox(
              width: 120,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Row(
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
          const SizedBox(
            height: 40,
          ),
          const Image(
              width: 600,
              height: 400,
              image: AssetImage("assets/images/home.png")),
        ],
      ),
    );
  }
}
