import 'package:flutter/material.dart';
import '../model/api_model.dart';

class KeywordScreen extends StatelessWidget {
  GptData gptReponseData;
  KeywordScreen({super.key, required this.gptReponseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "the AI has spoken 🥳",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            gptReponseData.choices[0].text,
          ),
        )
      ]),
    );
  }
}
