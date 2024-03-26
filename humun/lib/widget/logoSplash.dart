import 'package:flutter/material.dart';

class LogoSplash extends StatelessWidget {
  final Widget child;
  LogoSplash({required this.child});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/logo.png",
        width: 250,),
        SizedBox(
          height: 30,
        ),
        Text(
          "Хүмүн",
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16,
        ),
        Column(
          children: [
            Text(
              "Та өөрийнхөө хувь хүний хэв шинжийг мэдэх үү?",
              textAlign: TextAlign.center,
            ),
            child ?? SizedBox(),
          ],
        )
      ],
    );
  }
}