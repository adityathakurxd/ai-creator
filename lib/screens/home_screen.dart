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
      appBar: AppBar(
        centerTitle: false,
        title: const Text("AI Creator"),
      ),
      body: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "At loss for ideas?",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              )),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Let AI recommend you Reels and TikTok topics!",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text("Pick a category to generate ideas 🤩"),
              )),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: TopicSuggestions()),
          const SizedBox(
            height: 20,
          ),
          const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text("Or, start by entering a keyword on your mind 🤯"),
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
                  setState(() {
                    isLoading = false;
                  });
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
                  ? const SizedBox(
                      height: 10, width: 10, child: CircularProgressIndicator())
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
          // const Image(
          //     width: 600,
          //     height: 400,
          //     image: AssetImage("assets/images/home.png")),
        ],
      ),
    );
  }
}

class TopicSuggestions extends StatelessWidget {
  TopicSuggestions({super.key});

  final List<String> topics = [
    "💼 Business",
    "💰 Finance",
    "🩺 Health",
    "🍕 Food"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: topics.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
              child: ElevatedButton(
                child: Text(topics[index]),
                onPressed: () async {
                  var snackBar = SnackBar(
                    content: Row(
                      children: const [
                        Text('Generating topics! This should take some time'),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator()),
                      ],
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  var url =
                      Uri.parse('https://api.openai.com/v1/chat/completions');

                  Map<String, String> headers = {
                    'Content-Type': 'application/json;charset=UTF-8',
                    'Charset': 'utf-8',
                    'Authorization': 'Bearer $apiKey'
                  };

                  String promptData =
                      "only generate a list of youtube ideas for keyword ${topics[index]}.";

                  print(promptData);
                  final data = jsonEncode({
                    "model": "gpt-3.5-turbo",
                    "messages": [
                      {"role": "user", "content": promptData}
                    ],
                  });
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
                },
              ),
            );
          }),
    );
  }
}
