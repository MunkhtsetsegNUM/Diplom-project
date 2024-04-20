import 'package:flutter/material.dart';
import 'package:humun/theme.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  ButtonPrimary({required this.text,  this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed, 
        child: Text(text), 
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
          foregroundColor: Colors.white
        ),
      ),
    );
  }
}
