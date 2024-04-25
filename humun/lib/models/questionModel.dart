class Question {
  final String question;
  final String id;

  Question({
    required this.question,
    required this.id,
  });

  factory Question.fromJSON(Map<String, dynamic> data) {
    return Question(
      question: data['question'] ?? '',
      id: data['ID'],
    );
  }
}
