
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:humun/api/baseapi.dart';
import 'package:humun/models/personalityModel.dart';
import 'package:humun/theme.dart';
import 'package:http/http.dart' as http;
import 'package:humun/widget/card_category.dart';
import 'package:humun/widget/home_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  Image.asset(
                    "assets/image/humun.png",
                    width: 100,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                    color: mainColor,
                    iconSize: 25,
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 24),
                      Container(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/image/banner.png",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Зан чанарууд",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6,),
                      SizedBox(height: 150,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Мэдлэг",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6,),
                      NewsSlider()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
