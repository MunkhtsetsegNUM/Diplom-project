import 'package:flutter/material.dart';
import 'package:humun/theme.dart';

class DairyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: mainColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ':) Хөгжилтэй өдөр',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: whiteColor
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              SizedBox(height: 10),
              Text(
                'Өнөөдөр олон шинэ зүйл туршиж үзсэндээ баяртай байна.',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
