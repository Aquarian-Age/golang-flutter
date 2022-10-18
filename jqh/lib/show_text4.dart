//圆心
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class ShowText4 extends CustomPainter {
  String strm;
  double width;
  double height;
  double radius = 0;
  late TextPainter textPainter;

  ShowText4({
    required this.strm,
    required this.width,
    required this.height,
  }) {
    radius = min(width / 2, height / 2);
    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );
  }
  @override
  void paint(Canvas canvas, Size size) {
    var b = Platform.isWindows || Platform.isLinux;
     double font;
    b ? font = 18.0 : font = 13.0;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    textPainter.text = TextSpan(
      text: strm,
      style: TextStyle(color: Colors.red, fontSize: font),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
