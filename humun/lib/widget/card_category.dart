import 'package:flutter/material.dart';
import 'package:humun/theme.dart';

class CardCatergory extends StatelessWidget {
  final String imageCat;
  final String nameCat;
  CardCatergory({required this.imageCat, required this.nameCat});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container( 
        height: 90,
        width: 70,
        
        child:Column(
            children: [
              Material(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100), // half of the width or height to make it a circle
                    color: mainColor,
                  ),
                  child: Center(
                    child: Container(
                      width: 60, // Adjust this value to change the size of the circle
                      height: 60, // Adjust this value to change the size of the circle
                      decoration: BoxDecoration(// Change this to whatever color you want for the circle
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.network(
                          imageCat,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                nameCat,
                style: TextStyle(fontSize: 10),
              )
      ])
    )
    );
  }
}