import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:humun/api/baseapi.dart';
import 'package:humun/screens/MainPage.dart';
import 'package:humun/screens/Register/RegisterPage.dart';
import 'package:humun/screens/splash_screen.dart';
import 'package:humun/theme.dart';
import 'package:humun/widget/button_primary.dart';
import 'package:humun/widget/general_logo_space.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passSecurity = true;
  showHide(){
    setState(() {
      _passSecurity = !_passSecurity;
    });
  }
  login() async{
    var urlLogin = Uri.parse(BASEURL.ipLogin);
    final response = await http.post(urlLogin, body:{
      "username": userController.text,
      "password": passwordController.text
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if(value == 1){
        setState(() {});
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage()));
    }else{
      showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("Сануулга"),
          content: Text(message),
          actions: [TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Ok"))],
        )
        );

    }
    setState(() { });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()));
          },
        ),
      ),
      body: ListView(
        children:[ Container(
      padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                 Container(
                  child: GeneralLogo(
                    h: 50,
                    Width: 50,
                    child: SizedBox(height: 20),),
                ),
                Text("Нэвтрэх",),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: grayColor,
                        offset: Offset(0,1),
                        blurRadius: 4,
                        spreadRadius: 0
                      ),
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Хэрэглэчийн нэр"
                    ),
                  ),
                ),
                SizedBox(height: 24,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: grayColor,
                        offset: Offset(0,1),
                        blurRadius: 4,
                        spreadRadius: 0
                      ),
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: passwordController,
                    obscureText: _passSecurity,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showHide,
                        icon: _passSecurity ? 
                        Icon(Icons.visibility_off, size: 20,): 
                        Icon(Icons.visibility, size: 20,),
                      ),
                      border: InputBorder.none,
                      hintText: "Нууц үг"
                    ),
                  ),
                ),
                SizedBox(height: 24,),
                ButtonPrimary(
                  text: "Үргэлжлүүлэх",
                  onPressed: (){
                    if(userController.text.isEmpty || passwordController.text.isEmpty){
                      showDialog(
                        context: context,
                        builder: (context)=>AlertDialog(
                          title: Text("Сануулга"),
                          content: Text("Бүх нүдийг бөгөлнө үү"),
                          actions: [TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("За"))],
                        )
                        );
                    }
                    else{
                      login();
                    }
                  },
                ),
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Шинэ хаяг үүсгэх үү?",
                      textAlign: TextAlign.center,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(context, 
                        MaterialPageRoute(builder: (context) => RegisterPageUsername()), 
                        (route) => false);
                      },
                    child:
                    Text(
                      " Үүсгэх.",
                      textAlign: TextAlign.center,
                    ),
                    )
                  ],
                )

              ])
    )]));
  }
}