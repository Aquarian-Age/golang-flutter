import 'package:flutter/material.dart';

import 'painter.dart';
import 'show_text.dart';
import 'show_text2.dart';
import 'show_text3.dart';

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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(Object context) {
    return MaterialApp(
      title: "JQH",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Scaffold(
        backgroundColor: Colors.lightBlue, //设置总体背景颜色
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String qian = "干";
  String qianwx = "衰旺";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //  print("屏幕宽/高: $size"); //宽度 高度
    return ListView(
      children: [
        //---
        Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Btn',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Btn2',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            //外侧圆
            SizedBox(
              width: size.width,
              height: size.height,
              child: CustomPaint(
                painter: MyPainter(),
                foregroundPainter: ShowText(size.width, size.height),
                // child: const Center(
                //   child: Text(
                //     "",
                //     // style: TextStyle(fontSize: 12, color: Colors.red),
                //   ),
                // ),
              ),
            ),
            //次外侧圆
            SizedBox(
              width: size.width,
              height: size.height,
              child: CustomPaint(
                painter: ShowText2(size.width * 0.7, size.height * 0.7),
              ),
            ),
            //次次外侧圆
            SizedBox(
              width: size.width,
              height: size.height,
              child: CustomPaint(painter: ShowText3(size.width * 0.4, size.height * 0.4)),
            )
          ],
        ),
      ],
    );
  }
}
