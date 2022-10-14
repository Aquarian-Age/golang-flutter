import 'dart:math';

import 'package:flutter/material.dart';

import './dr/dr.dart';
import 'paint.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(Object context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int left = 0, top = 0;
  // 角度起点在水平线的正右方
  double degree = 0.0; // 0水平正右方 --> 45圆内右下方 --> 90圆内正下方 --> 180圆内正左方 270圆内正上方

  Widget _xywidget(double width, double height) {
    var r = min(width / 2, height / 2);
    DR dr = DR();
    List<Widget> items = [];
    Widget item; //要显示的单个元素
    List list = [
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

    for (var i = 0; i <= 360; i += 15) {
      degree = i.toDouble();
      double radians = dr.degreeToRadian(degree); // 弧度
      double x1 = width / 2 + r * cos(radians);
      double y1 = height / 2 + r * sin(radians);

      var index = i ~/ 15;
      items.add(Positioned(
          left: x1,
          top: y1,
          child: Text(
            "${(i % 15) == 0 && index < 24 ? list[index] : "-"}",
            //"${x1.toInt()},${y1.toInt()}", //left:x1 top:y1
            style: const TextStyle(
                fontSize: 10,
                color: Colors.lightBlue,
                decoration: TextDecoration.none),
          )));
    }
    setState(() {
      items;
    });

    item = Stack(
      children: items,
    );
    return item;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //print("屏幕宽/高: $size"); //宽度 高度

    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: CustomPaint(
            painter: MyPainter(),
            child: const Center(
              child: Text(
                "圆心",
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
            ),
          ),
        ),
        _xywidget(size.width - 20, size.height - 20), //粗略控制文本和圆边距离
      ],
    );
  }
}
