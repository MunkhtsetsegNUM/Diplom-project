import 'package:flutter/material.dart';
import 'package:humun/screens/LoginPage.dart';
import 'package:humun/screens/Register/RegisterPage.dart';
import 'package:humun/widget/button_primary.dart';
import 'package:humun/widget/general_logo_space.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogo(
        h: 250,
        Width: 200,
        child:Column(
          children: [
            SizedBox(height: 30,),
            Text(
              "Хүмүн",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50,),
            Column(
              children: [
                Text(
                  "Та өөрийнхөө хувь хүний хэв шинжийг мэдэх үү?",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 20,),
            ButtonPrimary(
              text: "Нэвтрэх", 
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              },
            ),
            SizedBox(height: 20,),
            ButtonPrimary(
              text: "Тест өгөх", 
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPageUsername()));
              },
            ),
          ]  
        )
      ),
    );
  }
}