import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:humun/api/baseapi.dart';
import 'package:http/http.dart' as http;
import 'package:humun/screens/LoginPage.dart';
import 'package:humun/theme.dart';
import 'package:humun/widget/button_primary.dart';
import 'package:humun/widget/general_logo_space.dart';

class RegisterPageUsername extends StatefulWidget {
  const RegisterPageUsername({super.key});

  @override
  State<RegisterPageUsername> createState() => _RegisterPageUsernameState();
}

class _RegisterPageUsernameState extends State<RegisterPageUsername> {
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstpasswordController = TextEditingController();
  TextEditingController secondpasswordController = TextEditingController();


  bool _passSecurity = true;
  showHide(){
    setState(() {
      _passSecurity = !_passSecurity;
    });
  }
  registerSubmit() async{
    var registerUrl = Uri.parse(BASEURL.ipRegister);
    final response = await http.post(registerUrl, body:{
    "username": userController.text,
    "password": firstpasswordController.text,
    "phonenumber": phoneController.text,
    "email": emailController.text
     });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if(value == 1){
        setState(() {});
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
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
      body: ListView(
        children: [
          Container(
            child: GeneralLogo(
              h: 50,
              Width: 50,
              child: SizedBox(height: 20),),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Нэвтрэх нэр үүсгэх",),
                SizedBox(height: 10,),
                Text("Цаашид ашиглах нэвтрэх нэрээ үүсгэнэ. Мөн та үүнийг дараа нь солих боломжтой"),
                SizedBox(height: 15,),
                //Өөрийн нэр хадгална
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
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "email"
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
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Утасны дугаар"
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
                    controller: firstpasswordController,
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
                    controller: secondpasswordController,
                    obscureText: _passSecurity,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showHide,
                        icon: _passSecurity ? 
                        Icon(Icons.visibility_off, size: 20,): 
                        Icon(Icons.visibility, size: 20,),
                      ),
                      border: InputBorder.none,
                      hintText: "Нууц үг давтах"
                    ),
                  ),
                ),
                SizedBox(height: 24,),
                ButtonPrimary(
                  text: "Үргэлжлүүлэх",
                  onPressed: (){
                    if(userController.text.isEmpty || firstpasswordController.text.isEmpty || secondpasswordController.text.isEmpty){
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
                    else if (firstpasswordController.text != secondpasswordController.text){
                      showDialog(
                        context: context,
                        builder: (context)=>AlertDialog(
                          title: Text("Сануулга"),
                          content: Text("Нууц үг таарахгүй байна"),
                          actions: [TextButton(onPressed: (){}, child: Text("За"))],
                        )
                        );
                    }
                    else{
                      registerSubmit();
                    }
                  },
                ),

                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Хаягтай бол энд дар",
                      textAlign: TextAlign.center,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                      },
                    child:
                    Text(
                      " Нэвтрэх",
                      textAlign: TextAlign.center,
                    ),
                    )
                  ],
                )
                
                ]
              ),
          ),
        ],
      ),
    );
  }
}



