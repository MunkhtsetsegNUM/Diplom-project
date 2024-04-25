import 'package:humun/models/questionModel.dart';

class QuestionAnswer {
  final Question id;
  int selectedAnswer;

  QuestionAnswer({
    required this.id,
    required this.selectedAnswer
  });
}
