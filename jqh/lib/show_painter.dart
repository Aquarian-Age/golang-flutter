import 'dart:math';

//import 'dart:ui';

import 'package:flutter/material.dart';

import 'dr.dart';

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
// // 需要旋转的弧度
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
class ShowPainter extends CustomPainter {
  double width;
  double height;

  late double radius;
  List<Offset> offsetXy = [];
  late TextPainter textPainter;
  late double angle;
  late double borderWidth;
  late List<int> angles = [];
  DR dr = DR();

  ShowPainter(
    this.height,
    this.width, {
    this.radius = 0.0,
  }) {
    radius = min(width / 2, height / 2);

    borderWidth = radius / 14;
    final secondDistance = radius - borderWidth * 2;

    for (var i = 0; i < 45; i++) {
      angles.add(i * 8);
      Offset offset = Offset(
        cos(dr.degreeToRadian(8 * i - 90)) * secondDistance + radius,
        sin(dr.degreeToRadian(8 * i - 90)) * secondDistance + radius,
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
    canvas.save(); //必要的第一步
    var dx = size.width / 2;
    var dy = size.height / 2;
    canvas.translate(dx, dy); //保持文字随圆心自动移动
    //
    for (var i = 0; i < offsetXy.length; i++) {
      canvas.save();
      canvas.translate(0.0, -radius + borderWidth * 1.5); // *1.5 x1，y1的距离
      //----------------------
      var n = (angles[i] ~/ 8) ~/ 6;
      // print("${angles[i]} ~/8 ~/6= $n");
      // 9离
      if (angles[i] == 352 || angles[i] == 0 || angles[i] == 8 || angles[i] == 16) {
        textPainter.text = TextSpan(
          text: "${angles[i]}",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
        );
      }
      //2坤
      if (angles[i] == 32 || angles[i] == 40 || angles[i] == 48 || angles[i] == 56) {
        textPainter.text = TextSpan(
          text: "${angles[i]}",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
        );
      }
      //7兑
      if (angles[i] == 80 || angles[i] == 88 || angles[i] == 96 || angles[i] == 104) {
        textPainter.text = TextSpan(
          text: "${angles[i]}",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
        );
      }
      // 8乾
      if (angles[i] == 120 || angles[i] == 128 || angles[i] == 136 || angles[i] == 144) {
        textPainter.text = TextSpan(
          text: "${angles[i]}",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
        );
      }
      // 1坎
      if (angles[i] == 168 || angles[i] == 176 || angles[i] == 184 || angles[i] == 192) {
        textPainter.text = TextSpan(
          text: "${angles[i]}",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
        );
      }
      // 8艮
      if (angles[i] == 216 || angles[i] == 224 || angles[i] == 232 || angles[i] == 240) {
        textPainter.text = TextSpan(
          text: "${angles[i]}",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
        );
      }
      // 3震
      if (angles[i] == 256 || angles[i] == 264 || angles[i] == 272 || angles[i] == 280) {
        textPainter.text = TextSpan(
          text: "${angles[i]}",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
        );
      }
      // 4巽
      if (angles[i] == 304 || angles[i] == 312 || angles[i] == 320 || angles[i] == 328) {
        textPainter.text = TextSpan(
          text: "${angles[i]}",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
        );
      }
      //---------------------
      /// 绘制 数字
      // textPainter.text = TextSpan(
      //   text: "$i",
      //   style: const TextStyle(
      //     color: Colors.red,
      //     fontSize: 18.0,
      //   ),
      // );

      ////文本不随角度变化
      ////注释掉这部分 文本随角度变化
      ///canvas.rotate(-angle * i);

      // textPainter.layout();
      // textPainter.paint(
      //   canvas,
      //   Offset(-(textPainter.width / 2), -(textPainter.height / 2)),
      // );

      ///绘制文本到以上这里
      canvas.restore();
      canvas.rotate(angle); //添加角度旋转
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
