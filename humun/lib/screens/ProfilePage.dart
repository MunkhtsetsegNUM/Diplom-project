import 'package:flutter/material.dart';
import 'package:humun/api/baseapi.dart';
import 'package:humun/models/personalityModel.dart';
import 'package:humun/theme.dart';
import 'package:humun/widget/button_primary.dart';
import 'package:http/http.dart' as http;
import 'package:humun/widget/card_category.dart';

import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<PersonalityCategory> listCategory = [];

  getCategory() async {
    listCategory.clear();
    var urlCategory = Uri.parse(BASEURL.ipCategory);
    final response = await http.get(urlCategory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map< String, dynamic> item in data) {
          listCategory.add(PersonalityCategory.fromJSON(item)); 
          print(listCategory.last.name);
        }
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getCategory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      ClipOval(
                        child: Image.asset(
                          "assets/image/profile.png",
                          width: 50,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              " Мөнхцэцэг", // Set text color to white
                            ),
                          ),
                          SizedBox(height: 5), // Add some spacing between the name and ISTP text
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: mainColor, // Set the background color to blue
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Text(
                              "ISTP",
                              style: TextStyle(color: Colors.white), // Set text color to white
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings),
                    color: mainColor,
                    iconSize: 30,
                  )
                ],
                
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Таны тухай дэлгэрэнгүй",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ],
                      ),
                      Container(
                        width: 315,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: mainColor, // Set the background color to blue
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Text(
                           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          style: TextStyle(color: Colors.white), // Set text color to white
                        ),
                      ),
                        SizedBox( height: 14,),
                      ButtonPrimary(
                        text: "Давуу болон сул тал",
                        onPressed: (){
                        },
                      ),
                      SizedBox( height: 14,),
                      ButtonPrimary(
                        text: "Хосын харилцаа",
                        onPressed: (){
                        },
                      ),
                      SizedBox( height: 14,),
                      ButtonPrimary(
                        text: "Найз нөхөрлөл",
                        onPressed: (){
                        },
                      ),
                      SizedBox( height: 14,),
                      ButtonPrimary(
                        text: "Ажил мэргэжил",
                        onPressed: (){
                        },
                      ),
                      SizedBox( height: 14,),
                      ButtonPrimary(
                        text: "Зуршил",
                        onPressed: (){
                        },
                      ),
                      SizedBox( height: 14,),
                      ButtonPrimary(
                        text: "Ажил мэргэжил",
                        onPressed: (){
                        },
                      ),
                      SizedBox( height: 14,),
                      ButtonPrimary(
                        text: "Зуршил",
                        onPressed: (){
                        },
                      ),
                      SizedBox( height: 14,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Зан чанарууд",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ],
                      ),
                      SizedBox(height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listCategory.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(right: 8), 
                            child: CardCatergory(
                                  imageCat: listCategory[index].image,
                                  nameCat: listCategory[index].name, 
                                
                            )
                          ),
                        ),
                      ),
                    ],
                  )
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
