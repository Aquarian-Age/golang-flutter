import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//  富文本点击事件
class ExapmleRichText extends StatefulWidget {
  const ExapmleRichText({super.key});

  @override
  State<ExapmleRichText> createState() => _ExapmleRichTextState();
}

class _ExapmleRichTextState extends State<ExapmleRichText> {
  String str = "click me";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RichText(
        text: TextSpan(
            text: str,
            style: const TextStyle(color: Colors.green, fontSize: 21),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print("Example RichText and TextSpan on clicked");
                setState(() {
                  str = "clicked";
                });
              }),
      ),
    );
  }
}
