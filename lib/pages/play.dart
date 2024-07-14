  import 'dart:convert';
  import 'dart:io';

  import 'package:flutter/material.dart';
  import 'package:myquiz/components/options.dart';
  import 'package:flutter/services.dart' show rootBundle;
  import 'completed.dart';
  import 'package:myquiz/question.dart'; // Add this import

  class Play extends StatefulWidget {
    const Play({super.key});

    @override
    _PlayState createState() => _PlayState();
  }

  class _PlayState extends State<Play> {
    Future<List<Question>>? _questionsFuture;
    int _currentQuestionIndex = 0;
    String _result = '';
    List<String?> _selectedAnswers = [];

    @override
    void initState() {
      super.initState();
      _questionsFuture = _loadQuestions();
      _selectedAnswers = List.filled(10, null); // assuming 10 questions
    }

    Future<List<Question>> _loadQuestions() async {
      final jsonString = await rootBundle.loadString('assets/questions.json');
      final jsonMap = jsonDecode(jsonString) as List;
      final List<Question> questions = jsonMap.map((json) => Question.fromJson(json)).toList();
      return questions;
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Skip',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        body: FutureBuilder<List<Question>>(
          future: _questionsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Question> questions = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    SizedBox(
                      height: 421,
                      width: 500,
                      child: Stack(
                        children: [
                          Container(
                            height: 280,
                            width: 490,
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          // FOR QUESTION INDEX BOX
                          Positioned(
                            bottom: 60,
                            left: 22,
                            right: 22,
                            child: Container(
                              height: 200,
                              width: 380,
                              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20), boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 5,
                                  spreadRadius: 3,
                                  color: Colors.indigoAccent,
                                )
                              ]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 9),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Text(
                                        'Question ${_currentQuestionIndex + 1}/${questions.length}',
                                        style: const TextStyle(
                                          color: Color(0xFF003399),
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    //FOR QUESTIONS
                                    Text(
                                      questions[_currentQuestionIndex].question,
                                      style: const TextStyle(fontSize: 18,color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 300,
                            left: 210,
                            child: CircleAvatar(
                              //FOR TIMER
                              radius: 42,
                              backgroundColor: Colors.indigo,
                              child: Center(
                                child: Text(
                                  'Timer',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ...questions[_currentQuestionIndex].answers.map((answer) =>
                        RadioListTile(
                          title: DefaultTextStyle(
                            style: TextStyle(color: Colors.white), // Set the text color to white
                            child: Text(answer),
                          ),
                          value: answer,
                          groupValue: _selectedAnswers[_currentQuestionIndex],
                          onChanged: (value) {
                            setState(() {
                              _selectedAnswers[_currentQuestionIndex] = value as String?;
                            });
                          },
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                          ),
                          onPressed: () async {
                            if (_currentQuestionIndex < questions.length - 1) {
                              setState(() {
                                _currentQuestionIndex++;
                              });
                            } else {
                              List<Question> questionsList = await _questionsFuture!; // Add ! here
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CompletePage(selectedAnswers: _selectedAnswers, questions: questionsList)));
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'NEXT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        backgroundColor: const Color(0xff000000),
      );
    }
  }

