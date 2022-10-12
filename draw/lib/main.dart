import 'dart:io';
import 'dart:math';

import 'package:draw/dr/dr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

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

const double windowWidth = 728;
const double windowHeight = 728;
void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized(); //调用 [runApp] 之前初始化绑定
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      //启动居中?
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

void main() {
  setupWindow();
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
    double x1 = r + r * cos(radians);
    double y1 = r + r * sin(radians);

    print("$x1 , $y1");
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
    print(size); //宽度 高度

    getxy(size.width, size.height);
    return Stack(
      children: [
        CustomPaint(
          painter: MyPainter(),
          child: const Center(
            child: Text(
              "圆心",
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          ),
        ),
        Positioned(
            left: left.toDouble(),
            top: top.toDouble(),
            child: Text(
              "$degree",
              style: const TextStyle(fontSize: 12, color: Colors.blue),
            ))
      ],
    );
  }
}
