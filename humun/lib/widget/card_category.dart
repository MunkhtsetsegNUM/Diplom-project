import 'package:flutter/material.dart';

class CardCatergory extends StatelessWidget {
  final String imageCat;
  final String nameCat;
  CardCatergory({required this.imageCat, required this.nameCat});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
        Image.network(imageCat,
        width: 40,),
        SizedBox(height: 5,),
        Text(
          nameCat,
          style: TextStyle(fontSize: 16),)
      ])
    );
  }
}