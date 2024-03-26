class Diary{
  final String userid;
  final String date;
  final String emoji;
  final String description;
  
  Diary({
    required this.userid,
    required this.date, 
    required this.emoji,
    required this.description});

  factory Diary.fromJSON(Map < String, dynamic> data){
    return Diary(
      userid: data['user_id'], 
      date: data['date'], 
      emoji: data['emoji'],
      description: data['description']);
  }


}