import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../constants/api_key.dart';
import '../model/image_model.dart';

class ScriptScreen extends StatefulWidget {
  String reponseKeywords;

  ScriptScreen({super.key, required this.reponseKeywords});

  @override
  State<ScriptScreen> createState() => _ScriptScreenState();
}

class _ScriptScreenState extends State<ScriptScreen> {
  DalleModel? gptData;

  bool isLoading = false;

  bool isImageAvailable = false;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Scipt is ready 🚀")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  height: 600,
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SelectableText(widget.reponseKeywords),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Generate a story board from this script",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 540,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Describe a scene to generate',
                    ),
                  ),
                ),
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        var url = Uri.parse(
                            'https://api.openai.com/v1/images/generations');

                        Map<String, String> headers = {
                          'Content-Type': 'application/json;charset=UTF-8',
                          'Charset': 'utf-8',
                          'Authorization': 'Bearer $apiKey'
                        };

                        String promptData =
                            "Generate a youtube storyboard image for the the topic ${_controller.value.text}. Make it as realistic as possible";

                        print(promptData);
                        final data = jsonEncode({
                          "prompt": promptData,
                          "n": 1,
                          "size": "1024x1024"
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
                            gptData = dalleModelFromJson(response.body);

                            await launchUrl(Uri.parse(gptData!.data[0].url));
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => KeywordScreen(
                            //         reponseKeywords:
                            //             gptData.choices[0].message.content)));
                          } else {
                            print(response.body);
                            print(response.statusCode);
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Text("Generate")),
              const SizedBox(
                width: 400,
                height: 400,
              ),
            ],
          ),
        ));
  }
}
