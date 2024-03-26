import 'package:flutter/material.dart';
import 'package:humun/screens/CalendarPage.dart';
import 'package:humun/screens/NewsPage.dart';
import 'package:humun/screens/ProfilePage.dart';
import 'package:humun/screens/homepage.dart';
import 'package:humun/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  final _pageList = [
    HomePage(),
    CalendarPage(),
    NewsPage(),
    ProfilePage(),
  ];
  onTapIndex(int i){
    setState(() {
      _index = i;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList.elementAt(_index),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Нүүр"),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: "Хуанли"),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder),
          label: "Мэдээ"),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "Нүүр"),
      ],
      currentIndex: _index,
      onTap: onTapIndex,
      unselectedItemColor: grayColor,
      selectedItemColor: mainColor,
      ),
    );
  }
}