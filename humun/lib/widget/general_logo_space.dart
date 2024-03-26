import 'package:flutter/material.dart';

class GeneralLogo extends StatelessWidget {
  final Widget child;
  final double Width;
  final double h;
  GeneralLogo({required this.child, required this.Width, required this.h});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(height: h,),
        Image.asset(
          "assets/image/logo.png",
           width: Width,
          ),
        child ?? SizedBox(),
      ]),
    );
  }
}