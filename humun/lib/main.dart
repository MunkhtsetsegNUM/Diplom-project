import 'package:flutter/material.dart';
import 'package:humun/screens/splash_screen.dart';
import 'package:humun/theme.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: mainColor),
      home: SplashScreen(),
    );
  }
}
//hive