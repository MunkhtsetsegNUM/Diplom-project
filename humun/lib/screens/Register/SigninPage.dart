import 'package:flutter/material.dart';
import 'package:humun/screens/MainPage.dart';
import 'package:humun/widget/button_primary.dart';
import 'package:humun/widget/general_logo_space.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogo(
        h: 250,
        Width: 200,
        child:Column(
          children: [
            SizedBox(height: 50,),
            Column(
              children: [
                Text(
                  "Аюулгүй байдлын үүднээс та утасны дугаар эсвэл майл хаягаа баталгаажуулах боломжтой",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 20,),
            ButtonPrimary(
              text: " Алгасах", 
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage()));
              },
            ),
            SizedBox(height: 20,),
            ButtonPrimary(
              text: "Баталгаажуулах", 
              onPressed: (){
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPageUsername()));
              },
            ),
          ]  
        )
      ),
    );
  }
}