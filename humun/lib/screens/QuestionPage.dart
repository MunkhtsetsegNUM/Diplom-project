import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:humun/api/baseapi.dart';
import 'package:humun/models/questionModel.dart';
import 'package:humun/widget/question_card.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }
  fetchQuestions() async {
    questions.clear();
    var urlCategory = Uri.parse(BASEURL.ipCategory);
    final response = await http.get(urlCategory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map< String, dynamic> item in data) {
          questions.add(Question.fromJSON(item)); 
          print(questions.last.question);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 8), 
                  child: QuestionWidget(
                    question: questions[index].question,
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
