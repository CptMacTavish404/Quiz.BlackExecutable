import 'package:flutter/material.dart';
import 'pages/login.dart';

void main() {
  runApp(const Quizz());
}

class Quizz extends StatelessWidget {
  const Quizz({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: const Text(
            "Hamro Quiz",
            style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xff000000),
        body: const Login(),
      ),
    );
  }
}
