import 'package:ai_creator/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // Client client = Client();
  // client
  //     .setEndpoint('https://cloud.appwrite.io/v1')
  //     .setProject('ai-creator')
  //     .setSelfSigned(
  //         status:
  //             true); // For self signed certificates, only use for development
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AI Creator Suite',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        debugShowMaterialGrid: false,
        home: HomeScreen());
  }
}
