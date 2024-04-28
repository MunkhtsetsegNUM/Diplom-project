import 'package:flutter/material.dart';
import 'package:humun/screens/HomePage.dart';
import 'package:humun/screens/MainPage.dart';
import 'package:humun/widget/button_primary.dart';

class ResultPage extends StatelessWidget {
  final String personalityType;

  const ResultPage({Key? key, required this.personalityType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Таны бие хүний хэв шинж бол',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              personalityType,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 100,),
            ButtonPrimary(text: "Аялалаа эхлүүлэх", 
            onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage()));
              })
          ],
        ),
      ),
    );
  }
}
