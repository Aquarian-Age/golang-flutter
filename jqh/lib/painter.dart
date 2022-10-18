//画圆
import 'dart:math';

import 'package:flutter/material.dart';

import 'dr.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // print("paint size: $size");
    //画圆
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..color = const Color.fromARGB(255, 208, 208, 85)
      ..style = PaintingStyle.fill //填充
      ..invertColors = false;

    var c = Offset(size.width / 2, size.height / 2); //圆心偏移
    double radius = min(size.width / 2, size.height / 2); //半径
    canvas.drawCircle(c, radius, paint);

    // 2层圆
    var paint2 = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      //..style = PaintingStyle.stroke
      ..style = PaintingStyle.fill
      ..color = Colors.lightBlue
      ..invertColors = false;
    double radius2 = radius * 0.75; // 0.8 ;
    canvas.drawCircle(c, radius2, paint2);
    // 3层圆
    var paint3 = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      // ..style = PaintingStyle.stroke
      ..style = PaintingStyle.fill
      ..color = const Color.fromARGB(255, 227, 140, 134)
      ..invertColors = false;
    double radius3 = radius * 0.5; //0.6;
    canvas.drawCircle(c, radius3, paint3);
    // // 3层圆
    // var paint4 = Paint()
    //   ..isAntiAlias = true
    //   ..strokeWidth = 1.0
    //   ..style = PaintingStyle.fill
    //   ..color = Colors.lightBlue
    //   ..invertColors = false;
    // double radius4 = radius * 0.20; //0.4;
    // canvas.drawCircle(c, radius4, paint4);

    //角度线
    double width = size.width;
    double height = size.height;
    DR dr = DR();
    var i = 22.5;
    paint.color = Colors.green;
    for (i; i <= 360; i += 45) {
      double degree = i.toDouble(); //角度
      double radians = dr.degreeToRadian(degree); // 弧度
      double x1 = width / 2 + radius * cos(radians); // left
      double y1 = height / 2 + radius * sin(radians); // top
      Offset offset = Offset(x1, y1);
      canvas.drawLine(c, offset, paint);
    }
    //内层
    var pn = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    double rp = radius * 0.20;
    canvas.drawCircle(c, rp, pn);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
