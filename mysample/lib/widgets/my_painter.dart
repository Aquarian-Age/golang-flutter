//画圆
import 'dart:math';

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //画圆
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..color = Colors.lightBlue
      //..color = Colors.white
      //..style = PaintingStyle.fill //填充为白色
      ..invertColors = false;

    var c = Offset(size.width / 2, size.height / 2); //圆心偏移
    double radius = min(size.width / 2, size.height / 2); //半径
    canvas.drawCircle(c, radius, paint);
    // 2层圆
    var paint2 = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..invertColors = false;

    double radius2 = radius * 0.7;
    canvas.drawCircle(c, radius2, paint2);
    // // 3层圆
    // var paint3 = Paint()
    //   ..isAntiAlias = true
    //   ..strokeWidth = 1.0
    //   ..style = PaintingStyle.stroke
    //   ..color = Colors.green
    //   ..invertColors = false;
    // //double radius3 = radius - sp * 2;
    // double radius3 = radius * 0.6; //0.7;
    // canvas.drawCircle(c, radius3, paint3);
    // // 3层圆
    // var paint4 = Paint()
    //   ..isAntiAlias = true
    //   ..strokeWidth = 1.0
    //   ..style = PaintingStyle.stroke
    //   ..color = Colors.lightBlue
    //   ..invertColors = false;
    // //double radius4 = radius - sp * 3;
    // double radius4 = radius * 0.4; //0.55;
    // canvas.drawCircle(c, radius4, paint4);

    // //角度线
    // double width = size.width;
    // double height = size.height;
    // DR dr = DR();
    // var i = 22.5;
    // for (i; i <= 360; i += 45) {
    //   //  print("i==$i");
    //   double degree = i.toDouble(); //角度
    //   double radians = dr.degreeToRadian(degree); // 弧度
    //   double x1 = width / 2 + radius * cos(radians); // left
    //   double y1 = height / 2 + radius * sin(radians); // top
    //   Offset offset = Offset(x1, y1);
    //   canvas.drawLine(c, offset, paint);
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
