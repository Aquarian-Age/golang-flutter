import 'dart:math';

import 'package:flutter/material.dart';

import './dr/dr.dart';

//画圆
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..invertColors = false;

    var c = Offset(size.width / 2, size.height / 2); //圆心偏移
    double radius = min(size.width / 2, size.height / 2); //半径
    canvas.drawCircle(c, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

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
    // print("r==$r");
    DR dr = DR();
    List<Widget> items = [];
    Widget item; //要显示的单个元素

    for (var i = 0; i <= 360; i += 30) {
      degree = i.toDouble();
      double radians = dr.degreeToRadian(degree);
      double x1 = width / 2 + r * cos(radians);
      double y1 = height / 2 + r * sin(radians);
      items.add(Positioned(
          left: x1,
          top: y1,
          child: Text(
            "${x1.toInt()},${y1.toInt()}", //left:x1 top:y1
            style: const TextStyle(fontSize: 12, color: Colors.black),
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
    print("屏幕宽/高: $size"); //宽度 高度

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
