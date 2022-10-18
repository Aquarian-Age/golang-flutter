import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'dr.dart';

//     https://www.jianshu.com/p/d117c66df1d1
//     print("----------");
//     /////////////////////////// 计算画布中心轨迹圆半径
//     double r = sqrt(pow(width, 2) + pow(height, 2));
//     print("r ==$r");
//     // 计算画布中心点初始弧度
//     double startAngle = atan(height / width);
//     print(startAngle);
//     // 计算画布初始中心点坐标
//     Point p0 = Point(r * cos(startAngle), r * sin(startAngle));
//     print(p0);
//     需要旋转的弧度
//     double xAngle = pi / 45;
//     print(xAngle);
//     // 计算旋转后的画布中心点坐标
//     Point px = Point(r * cos(xAngle + startAngle), r * sin(xAngle + startAngle));
//     print(px);
//     // 先平移画布
//     canvas.save();
//     canvas.translate((p0.x - px.x) / 2, (p0.y - px.y) / 2);
//     // 后旋转
//     canvas.rotate(xAngle);
//     // canvas.drawRect(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 100), Paint()..color = Colors.amber);
//     canvas.restore();
////////////////////////////////////
class ShowText extends CustomPainter {
  Map<int, String> mapBm = {}; //八门
  Map<int, String> mapDg = {}; //地盘干
  double width;
  double height;
  late double radius;
  List<Offset> offsetXy = [];
  late TextPainter textPainter;
  late double angle;
  late double borderWidth;
  //[0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 128, 136, 144, 152, 160, 168, 176, 184, 192, 200, 208, 216, 224, 232, 240, 248, 256, 264, 272, 280, 288, 296, 304, 312, 320, 328, 336, 344, 352]
  late List<int> angles = [];
  DR dr = DR();

  ShowText(
    this.mapBm,
    this.mapDg,
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
    var b = Platform.isWindows || Platform.isLinux;
    double font;
    b ? font = 18.0 : font = 13.0;
    //
    canvas.save(); //必要的第一步
   //保持文字随圆心自动移动
    var dx = size.width / 2;
    var dy = size.height / 2;
    canvas.translate(dx, dy);

    for (var i = 0; i < offsetXy.length; i++) {
      canvas.save();
      canvas.translate(0.0, -radius + borderWidth * 1.9); // *数字 数字决定了x1，y1
      switch (angles[i]) {
        // 9 离 (angles[i] == 352 || angles[i] == 0 || angles[i] == 8 || angles[i] == 16)
        case 0:
          textPainter.text = TextSpan(
            text: mapBm[9],
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapDg[9]}",
                style: TextStyle(color: const Color.fromARGB(235, 243, 65, 228), fontSize: font),
              ),
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
            text: mapBm[2], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapDg[2]}",
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
            text: mapBm[7], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapDg[7]}",
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
            text: mapBm[6], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapDg[6]}",
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
            text: mapBm[1], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapDg[1]}",
                style: TextStyle(color: const Color.fromARGB(235, 243, 65, 228), fontSize: font),
              )
            ],
          );
          canvas.rotate(-angle * i); //文字翻转
          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
          );
          break;
        // 8艮 (angles[i] == 216 || angles[i] == 224 || angles[i] == 232 || angles[i] == 240)
        case 224:
          textPainter.text = TextSpan(
            text: mapBm[8], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapDg[8]}",
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
        // 3震  (angles[i] == 256 || angles[i] == 264 || angles[i] == 272 || angles[i] == 280)
        case 264:
          textPainter.text = TextSpan(
            text: mapBm[3], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapDg[3]}",
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
            text: mapBm[4], //"${angles[i]}",
            style: TextStyle(color: Colors.white, fontSize: font),
            children: [
              TextSpan(
                text: "\n${mapDg[4]}",
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