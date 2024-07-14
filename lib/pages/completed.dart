import 'package:flutter/material.dart';
import 'package:myquiz/question.dart'; // Add this import

class CompletePage extends StatelessWidget {
  final List<String?> selectedAnswers;
  final List<Question> questions;
  const CompletePage({super.key, required this.selectedAnswers, required this.questions});

  @override
  Widget build(BuildContext context) {
    int score = 0;
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == null) continue;
      if (selectedAnswers[i] == questions[i].correctAnswer) score++;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 521,
            width: 500,
            child: Stack(
              children: [
                Container(
                  height: 440,
                  width: 500,
                  decoration: BoxDecoration(color: Colors.indigoAccent, borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: CircleAvatar(
                      radius: 120,
                      backgroundColor: Colors.black.withOpacity(.3),
                      child: CircleAvatar(
                        radius: 92,
                        backgroundColor: Colors.black.withOpacity(.4),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Your Score',
                                style: TextStyle(fontSize: 25, color: Colors.blueAccent),
                              ),
                              RichText(
                                  text: TextSpan(text: '$score', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blueAccent), children: const [
                                    TextSpan(
                                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                                      text: ' pt',
                                    )
                                  ])),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.1,
                  left: 22,
                  right: 22,
                  child: Container(
                    height: 190,
                    width: 400,
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20), boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 3,
                        color: Colors.indigoAccent,
                        offset: Offset(0, 1),
                      )
                    ]),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 170,
                              ),
                              Text(
                                'Your score!!',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xff000000),
    );
  }
}