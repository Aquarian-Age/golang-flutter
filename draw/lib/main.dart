import 'dart:math';

import 'package:flutter/material.dart';

import 'dr/dr.dart';

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
  double degree = 210.0;
  void getxy(double width, double height) {
    var r = min(width / 2, height / 2);
    print("r==$r");

    DR dr = DR();
    double radians = dr.degreeToRadian(degree);
    double x1 = width / 2 + r * cos(radians);
    double y1 = height / 2 + r * sin(radians);

    // print("$x1 , $y1");
    print("x1: ${x1.toInt()}, y1: ${y1.toInt()}");
    setState(() {
      degree;
      left = x1.toInt();
      top = y1.toInt();
    });
  }

  MyPainter p = MyPainter();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("屏幕宽/高: $size"); //宽度 高度

    //getxy(size.width, size.height);
    getxy(size.width - 20, size.height - 20); //减去20在四维度角文本可以显示在圆内
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
        Positioned(
          left: left.toDouble(),
          top: top.toDouble(),
          child: Text(
            "$degree",
            style: const TextStyle(fontSize: 12, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
