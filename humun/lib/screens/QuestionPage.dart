import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:humun/api/baseapi.dart';
import 'package:humun/models/personalitysModel.dart';
import 'package:humun/models/questionModel.dart';
import 'package:humun/screens/TestResultPage.dart';
import 'package:humun/screens/loadingScreen.dart';
import 'package:humun/screens/splash_screen.dart';
import 'package:humun/widget/question_card.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

import 'package:tflite_flutter/tflite_flutter.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<Question> questions = [];
  int currentPage = 0;
  int questionsPerPage = 5;
  Interpreter? interpreter;
  final InterpreterOptions options = InterpreterOptions();
  List<Map<String, dynamic>> selectedAnswers = [];
  List<String> characters = ['ENFP', 'ISFP', 'INFJ', 'ISTP', 'ENFJ', 'INTJ', 'ENTI', 'ESFP', 'INFP', 'INTP', 'ISTI', 'ENTP', 'ISFJ', 'ESTI', 'ESTP', 'ESFJ'];
  List<int> X_test_custom = [
    0,0,-1,3,-1,-2,-2,0,-1,0,2,1,0,1,3,2,2,0,-2,-3,0,2,0,0,-1,0,2,0,0,1,1,0,0,0,2,1,1,0,2,0,-1,1,1,3,-2,1,2,0,0,0,0,0,2,0,2,0,-1,1,-1,0
  ];



  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }


  List<int> padSequences(List<int> inputData, int maxLen) {
    if (inputData.length >= maxLen) {
      return inputData.sublist(0, maxLen);
    } else {
      return List<int>.filled(maxLen - inputData.length, 0)..setAll(0, inputData);
    }
  }


  Future<String> predictCharacter(List<int> inputData) async {
    final interpreter = await Interpreter.fromAsset('assets/myPersonalityModel.tflite');
    final isolateInterpreter =
        await IsolateInterpreter.create(address: interpreter.address);
    try {
      if (inputData.isEmpty) {
        return 'Input data is empty';
      }

      if (isolateInterpreter == null) {
        return 'Model not loaded';
      }

      final paddedInput = padSequences(inputData, 59);
      final input = paddedInput.map((e) => e.toDouble()).toList();

      var inputBuffer = Float32List.fromList(input);
      var outputBuffer = List<double>.filled(1, 0);
      await Future.delayed(const Duration(seconds: 1));

      isolateInterpreter.run(inputBuffer, outputBuffer);

      print(outputBuffer);
      final predictedIndex = outputBuffer[0].toInt();
      return characters[predictedIndex];
    } catch (e) {
      print('Error: $e');
      return "Prediction failed";
    }
  }

  fetchQuestions() async {
    questions.clear();
    var urlQuestions = Uri.parse(BASEURL.ipQuestions);
    final response = await http.get(urlQuestions, );

    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> item in data) {
          questions.add(Question.fromJSON(item));
        }
        selectedAnswers = List.generate(questions.length, (index) => {'id': questions[index].id, 'index': -1});
      });
    }else{
      print('Request failed with status: ${response.statusCode}');
    }
  }

  void nextPage() {
    if ((currentPage + 1) * questionsPerPage < questions.length) {
      setState(() {
        currentPage++;
      });
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  void onButtonSelected(int index, String questionId) {
  setState(() {
    int answerIndex = selectedAnswers.indexWhere((answer) => answer['id'] == questionId);
    if (answerIndex != -1) {
      selectedAnswers[answerIndex]['index'] = index;
      printSelectedAnswers();
    } else {
      selectedAnswers.add({'id': questionId, 'index': index});
    }
    
  });
}


  void showFinishConfirmationDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Тест дуусгах"),
          content: Text("Та тестийг дуусгахдаа итгэлтэй байна уу?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Үгүй"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                var predictedCharacter = await predictCharacter(X_test_custom);
                print('Predicted Character: $predictedCharacter');
              },
              child: Text("Тийм"),
            ),
          ],
        );
      },
    );
  }

    void showIncompleteQuestionsDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Бүх асуултандаа хариулна уу!"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: Text("Ойлгосон"),
              ),
            ],
          );
        },
      );
    }
    void printSelectedAnswers() {
    print(selectedAnswers);
  }

  @override
  Widget build(BuildContext context) {
    List<Question> currentPageQuestions =
        questions.skip(currentPage * questionsPerPage).take(questionsPerPage).toList();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()));
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: currentPageQuestions.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: QuestionWidget(
                    question: currentPageQuestions[index].question,
                    id: currentPageQuestions[index].id,
                    onButtonSelected: (buttonIndex) {
                      onButtonSelected(buttonIndex, currentPageQuestions[index].id);
                    },
                    selectedButtonIndex: _getSelectedIndex(currentPageQuestions[index].id),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: previousPage,
                    child: Text('Буцах'),
                  ),
                ),
                Container(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: (){
                      if (currentPage == (questions.length / questionsPerPage).ceil() - 1) {
                        bool allQuestionsAnswered = selectedAnswers.every((answer) => answer['index'] != -2);
                        if (allQuestionsAnswered) {
                          showFinishConfirmationDialog(context);
                        } else {
                          showIncompleteQuestionsDialog(context);
                        }
                      } else {
                        nextPage();
                      }
                    },
                    child: Text('Үргэлжлүүлэх'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _getSelectedIndex(String questionId) {
    for (var answer in selectedAnswers) {
      if (answer['id'] == questionId) {
        return answer['index'];
      }
    }
    return -1;
  }
}