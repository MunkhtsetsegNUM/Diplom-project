import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:humun/api/baseapi.dart';
import 'package:humun/models/blogModel.dart';
import 'package:humun/widget/dairy_widget.dart';
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
    var url = Uri.parse('');
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

_showAddDairyDialog() async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        "Тэмдэглэл хөтлөх",
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.all(32), // Set larger content padding
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextField(
              controller: emojiController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Яг одоогийн сэтгэл хөдлөл',
              ),
            ),
          ),
          SizedBox(height: 24), // Add space
          Expanded(
            child: Container(
              padding: EdgeInsets.all(1), // Add padding
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: descriptionController,
                textCapitalization: TextCapitalization.words,
                maxLines: null, // Allow multiline input
                decoration: const InputDecoration(
                  labelText: 'Тэмдэглэл',
                  border: InputBorder.none, // Remove default border
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Болих'),
        ),
        TextButton(
          onPressed: () {
            if (emojiController.text.isEmpty && descriptionController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Талбарыг бөгөлсний дараа хадгалах үйлдэл хийх боломжтой!'),
                  duration: Duration(seconds: 2),
                ),
              );
              return;
            } else {
              setState(() {
                saveDiary(); // Call the function to save diary entry
                Navigator.pop(context);
              });
            }
          },
          child: const Text('Хадгалах'),
        ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/image/calendar.png",
                  width: 100,
                )
              ],
            ),
          ),
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
              formatButtonVisible: false,
              titleCentered: true,
              formatButtonShowsNext: false,
            ),
            locale: 'mn_MN',
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        DairyWidget(),
                        SizedBox(height: 8,),
                        ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () => _showAddDairyDialog(),
      label: const Text("Тэмдэглэл хөтлөх")
    )
  );
}

}

