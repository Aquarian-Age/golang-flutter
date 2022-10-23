//画圆
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const List list = [
  "寒露",
  "霜降",
  "立冬",
  "小雪",
  "大雪",
  "冬至",
  "小寒",
  "大寒",
  "立春",
  "雨水",
  "惊蛰",
  "春分",
  "清明",
  "谷雨",
  "立夏",
  "小满",
  "芒种",
  "夏至",
  "小暑",
  "大暑",
  "立秋",
  "处暑",
  "白露",
  "秋分",
];

class ExampleCustomPainter extends StatefulWidget {
  const ExampleCustomPainter({super.key});

  @override
  State<ExampleCustomPainter> createState() => _ExampleCustomPainterState();
}

class _ExampleCustomPainterState extends State<ExampleCustomPainter> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //  print("屏幕宽/高: $size"); //宽度 高度
    var wh = min(size.width / 2, size.height / 2);
    return Scaffold(
      appBar: AppBar(actions: []),
      body: Stack(
        children: [
          _xywidget(wh, wh), //-20 粗略控制文本和圆边距离
        ],
      ),
    );
  }

  // 自定义Widget 节气显示样例
  double x2 = 0;
  double y2 = 0;
  Widget _xywidget(double width, double height) {
    List<Widget> items = [];
    Widget item = Positioned(
        child: RichText(
      text: const TextSpan(),
    )); //要显示的单个元素

    double degree = 0.0;
    var r = min(width / 2, height / 2);
    DR dr = DR();

    for (var i = 0; i <= 360; i += 15) {
      degree = i.toDouble();
      double radians = dr.degreeToRadian(degree); // 弧度

      // double x1 = r + r * cos(radians); // *  0.86910文字在圆内显示
      // double y1 = r + r * sin(radians);

      x2 = -cos(radians) * 90 / pi + r + r * cos(radians);
      y2 = -sin(radians) * 90 / pi + r + r * sin(radians);

      var index = i ~/ 15;
      items.add(
        Positioned(
          // left: x1,
          // top: y1,
          left: x2,
          top: y2,
          child: RichText(
            text: TextSpan(
                text: "${(i % 15) == 0 && index < 24 ? list[index] + "$i" : ""}",
                style: const TextStyle(fontSize: 10, color: Colors.blue, decoration: TextDecoration.none),
                //文本点击
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print("${(i % 15) == 0 && index < 24 ? list[index] : ""} is clicked");
                  }),
          ),
        ),
      );
    }
    setState(() {
      items;
    });

    item = Stack(
      children: items,
    );
    return item;
  }
}

class DR {
  // ignore: non_constant_identifier_names
  double PI = 3.14159265358979323846264338327950288419716939937510582097494459;

  double degreeToRadian(double degree) {
    return degree * PI / 180;
  }

  double radianToDegree(double radian) {
    return radian * 180 / PI;
  }
}
        // Positioned(
        //   left: x1,
        //   top: y1,
        //   child: Text(
        //     "${(i % 15) == 0 && index < 24 ? list[index] : ""}",
        //     //"${x1.toInt()},${y1.toInt()}", //left:x1 top:y1
        //     style: const TextStyle(fontSize: 10, color: Colors.blue, decoration: TextDecoration.none),
        //   ),
        // ),