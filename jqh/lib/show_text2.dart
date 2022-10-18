import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'dr.dart';

class ShowText2 extends CustomPainter {
  Map<int, String> mapJx = {}; //九星
  Map<int, String> mapTg = {}; //天盘干

  double width;
  double height;
  late double radius;
  List<Offset> offsetXy = [];
  late TextPainter textPainter;
  late double angle;
  late double borderWidth;
  late List<int> angles = [];
  DR dr = DR();

  ShowText2(
    this.mapJx,
    this.mapTg,
    this.width,
    this.height, {
    this.radius = 0.0,
  }) {
    radius = min(width / 2, height / 2);
    borderWidth = radius / 14;
    final secondDistance = radius - borderWidth * 2;

    for (var i = 0; i < 45; i++) {
      angles.add(i * 8);
      Offset offset = Offset(
        cos(dr.degreeToRadian(8 * i.toDouble())) * secondDistance + radius, //  //x1
        sin(dr.degreeToRadian(8 * i.toDouble())) * secondDistance + radius, //  //y1
        // cos(dr.degreeToRadian(8 * i - 90)) * secondDistance + radius, //(width / 2), //x1
        // sin(dr.degreeToRadian(8 * i - 90)) * secondDistance + radius, //(height / 2), //y1
      );
      offsetXy.add(offset);
    }

    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );
    angle = dr.degreeToRadian(360 / 45);
  }

  @override
  void paint(Canvas canvas, Size size) {
    //
    var b = Platform.isWindows || Platform.isLinux;
    double font;
    b ? font = 18.0 : font = 13.0;
    //
    canvas.save(); //必要的第一步
    //固定圆心位置
    //canvas.translate(radius, radius);

    //保持文字随圆心自动移动
    var dx = size.width / 2;
    var dy = size.height / 2;
    canvas.translate(dx, dy);

    for (var i = 0; i < offsetXy.length; i++) {
      canvas.save();
      canvas.translate(0.0, -radius + borderWidth * 1.5); // *数字 数字决定了x1，y1
      switch (angles[i]) {
        // 9 离 (angles[i] == 352 || angles[i] == 0 || angles[i] == 8 || angles[i] == 16)
        case 0:
          textPainter.text = TextSpan(
            text: mapJx[9], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapTg[9]}",
                style: TextStyle(color: const Color.fromARGB(235, 243, 65, 228), fontSize: font),
              )
            ],
          );
          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
          );
          break;
        // 2 坤 (angles[i] == 32 || angles[i] == 40 || angles[i] == 48 || angles[i] == 56)
        case 40:
          textPainter.text = TextSpan(
            text: mapJx[2], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapTg[2]}",
                style: TextStyle(color: const Color.fromARGB(235, 243, 65, 228), fontSize: font),
              )
            ],
          );
          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
          );
          break;
        //7 兑 (angles[i] == 80 || angles[i] == 88 || angles[i] == 96 || angles[i] == 104)
        case 88:
          textPainter.text = TextSpan(
            text: mapJx[7], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapTg[7]}",
                style: TextStyle(color: const Color.fromARGB(235, 243, 65, 228), fontSize: font),
              )
            ],
          );
          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
          );
          break;
        // 6 乾 (angles[i] == 120 || angles[i] == 128 || angles[i] == 136 || angles[i] == 144)
        case 128:
          textPainter.text = TextSpan(
            text: mapJx[6], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapTg[6]}",
                style: TextStyle(color: const Color.fromARGB(235, 243, 65, 228), fontSize: font),
              )
            ],
          );
          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
          );
          break;
        // 1坎 (angles[i] == 168 || angles[i] == 176 || angles[i] == 184 || angles[i] == 192)
        case 176:
          textPainter.text = TextSpan(
            text: mapJx[1], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapTg[1]}",
                style: TextStyle(color: const Color.fromARGB(235, 243, 65, 228), fontSize: font),
              )
            ],
          );
          canvas.rotate(-angle * i);
          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
          );
          break;
        // 8艮 (angles[i] == 216 || angles[i] == 224 || angles[i] == 232 || angles[i] == 240)
        case 224:
          textPainter.text = TextSpan(
            text: mapJx[8], // "${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapTg[8]}",
                style: TextStyle(color: const Color.fromARGB(235, 243, 65, 228), fontSize: font),
              )
            ],
          );
          //canvas.rotate(-angle * i + 70);
          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
          );
          break;
        // 3震  (angles[i] == 256 || angles[i] == 264 || angles[i] == 272 || angles[i] == 280)
        case 264:
          textPainter.text = TextSpan(
            text: mapJx[3], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapTg[3]}",
                style: TextStyle(color: const Color.fromARGB(235, 243, 65, 228), fontSize: font),
              )
            ],
          );
          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
          );
          break;
        // 4巽 (angles[i] == 304 || angles[i] == 312 || angles[i] == 320 || angles[i] == 328)
        case 312:
          textPainter.text = TextSpan(
            text: mapJx[4], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapTg[4]}",
                style: TextStyle(color: const Color.fromARGB(235, 243, 65, 228), fontSize: font),
              )
            ],
          );

          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
          );
          break;
      }

      ///绘制文本到以上这里
      canvas.restore();
      canvas.rotate(angle); //添加角度旋转
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
