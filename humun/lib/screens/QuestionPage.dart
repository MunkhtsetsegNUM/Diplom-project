import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:humun/api/baseapi.dart';
import 'package:humun/models/personalitysModel.dart';
import 'package:humun/models/questionModel.dart';
import 'package:humun/screens/TestResultPage.dart';
import 'package:humun/screens/loadingScreen.dart';
import 'package:humun/screens/splash_screen.dart';
import 'package:humun/widget/question_card.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<Question> questions = [];
  int currentPage = 0;
  int questionsPerPage = 5;
  List<Map<String, dynamic>> selectedAnswers = [];
  late PersonalityModel personalityModel;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
    personalityModel = PersonalityModel(modelPath: 'assets/model.tflite');
  }
  @override
  void dispose() {
    personalityModel.close(); 
    super.dispose();
  }

  fetchQuestions() async {
    questions.clear();
    var urlQuestions = Uri.parse(BASEURL.ipQuestions);
    final response = await http.get(urlQuestions);

    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> item in data) {
          questions.add(Question.fromJSON(item));
        }
        selectedAnswers = List.generate(questions.length, (index) => {'id': questions[index].id, 'index': -1});
      });
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
    }
  });
}

void showFinishConfirmationDialog(BuildContext context) {
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
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Yes"),
          ),
        ],
      );
    },
  ).then((value) {
    if (value != null && value) {
      finishQuiz();
    }
  });
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
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

Future<bool> sendAnswersToServer(List<Map<String, dynamic>> answers) async {
  // Assuming you have an API endpoint to send answers
  var url = Uri.parse('YOUR_API_ENDPOINT');
  var response = await http.post(
    url,
    body: jsonEncode(answers),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}


  Future<void> finishQuiz() async {
  // Collect selected answers indices in order
  List<int> selectedIndices = [];
  for (var answer in selectedAnswers) {
    if (answer['index'] != -1) {
      selectedIndices.add(answer['index']);
    } else {
      // If any question is unanswered, show dialog and return
      showIncompleteQuestionsDialog(context);
      return;
    }
  }

  // Convert selected indices to doubles (required input format)
  List<double> input = selectedIndices.map((index) => index.toDouble()).toList();

  try {
    List<double> prediction = await personalityModel.predict(input);
    String personalityType = _getPersonalityType(prediction);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ResultPage(personalityType: personalityType)),
    );
  } catch (e) {
    print('Prediction error: $e');
  }
}

  String _getPersonalityType(List<double> prediction) {
    // Assuming prediction has 16 values corresponding to personality types
    // You can customize this logic based on how your model outputs results
    int maxIndex = prediction.indexOf(prediction.reduce((curr, next) => curr > next ? curr : next));
    List<String> personalityTypes = ['ESTJ', 'ENTJ', 'ESFJ', 'ENFJ', 'ISTJ', 'ISFJ', 'INTJ', 'INFJ',
      'ESTP', 'ESFP', 'ENTP', 'ENFP', 'ISTP', 'ISFP', 'INTP', 'INFP'];
    return personalityTypes[maxIndex];
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
                      bool allQuestionsAnswered = selectedAnswers.every((answer) => answer['index'] != -1);
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