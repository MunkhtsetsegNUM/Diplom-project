import 'package:flutter/material.dart';
import 'package:humun/theme.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  const QuestionWidget({required this.question});
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          question,
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold
            ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCircleButton(50),
            _buildCircleButton(45),
            _buildCircleButton(40),
            _buildCircleButton(30),
            _buildCircleButton(40),
            _buildCircleButton(45),
            _buildCircleButton(50),
          ],
        ),
      ],
    );
  }

  Widget _buildCircleButton(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: mainColor,
      ),
    );
  }
}
