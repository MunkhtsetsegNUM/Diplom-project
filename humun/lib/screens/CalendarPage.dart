import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:humun/api/baseapi.dart';
import 'package:humun/models/blogModel.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Diary> listofdiary = [];

  DateTime today = DateTime.now();
  DateTime? _selectedDate;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final emojiController = TextEditingController();
  final descriptionController = TextEditingController();

  String? savedEmoji;
  String? savedDescription;

  getDiary() async {
    listofdiary.clear();
    var urlDiary = Uri.parse(BASEURL.ipDiary);
    final response = await http.get(urlDiary);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map< String, dynamic> item in data) {
          listofdiary.add(Diary.fromJSON(item)); 
          print(listofdiary.last.description);
        }
      });
    }
  }


  Future<void> saveDiary() async {
    var url = Uri.parse('YOUR_SERVER_URL/save_diary.php');
    var response = await http.post(url, body: {
      'user_id': 'YOUR_USER_ID', // Pass your user ID here
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'emoji': emojiController.text,
      'description': descriptionController.text,
    });
  //   if (response.statusCode == 200) {
  //   var responseData = jsonDecode(response.body);
  //   if (responseData['value'] == 1) {
  //   } else {
  //   }
  // } else {
  // }
}

  _showAddDairyDialog() async{
    await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text( 
          "Тэмдэглэл хөтлөх",
          textAlign:  TextAlign.center,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emojiController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Яг одоогийн сэтгэл хөдлөл'
                ),
              ),
              TextField(
                controller: descriptionController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Тэмдэглэл'
                ),
              )
          ]
          ),
          actions: [
            TextButton(
              onPressed: ()=>Navigator.pop(context), 
              child: const Text('Болих')),
            TextButton(
              onPressed: (){
                if(emojiController.text.isEmpty && descriptionController.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Талбарыг бөгөлсний дараа хадгалах үйлдэл хийх боломжтой!'),
                      duration: Duration(seconds: 2))
                  );
                  return;
                }
                  else{
                    setState(() {
                    saveDiary(); // Call the function to save diary entry
                    Navigator.pop(context);
                  });
                  }
              }, 
              child: const Text('Хадгалах')),
          ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = today;
    initializeDateFormatting('mn_MN', null);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/image/calendar.png",
                    width: 100,
                  )
                ],
              ),
              SizedBox(height: 24),
              TableCalendar(
                focusedDay: today,
                firstDay: DateTime.utc(2020, 01, 01),
                lastDay: DateTime.utc(2040, 12, 31),
                calendarFormat: _calendarFormat,


                onDaySelected: (selectedDay, focusedDay){
                  if(!isSameDay(_selectedDate, selectedDay)){
                    setState(() {
                      _selectedDate = selectedDay;
                      today = focusedDay;

                    });
                  }
                },
                selectedDayPredicate: (day){
                  return isSameDay(_selectedDate, day);
                },

                onFormatChanged: (format){
                  if(_calendarFormat != format){
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                
                
                headerStyle: HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: true,
                  formatButtonShowsNext: true,
                ),
                locale: 'mn_MN',
              ),
                if (savedEmoji != null || savedDescription != null)
                Column(
                  children: [
                    Text(
                      'Today\'s Emotion: $savedEmoji',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Note: $savedDescription',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
            ],
          ),
          
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
                onPressed: () => _showAddDairyDialog(),
                label: const Text("Тэмдэглэл хөтлөх")
              )
    );
  }
}

List<String> moods = ['😄', '😊', '😐', '😔', '😢', '😡'];
