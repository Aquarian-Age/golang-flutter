import 'dart:core';

import 'package:cli/page_second.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '传参',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  //给第二页面传参
  dynamic map = {
    1: '1111',
    2: '22222',
    3: '3333',
  };
// 给第二页面传送class
  Data? data = Data("aaa", "bbb", 12, [1, 2, 3, 4]);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "页面传参",
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true, //标题居中显示
          backgroundColor: Colors.white, //标题背景颜色
          toolbarHeight: 26, //标题高度
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  // 另外一个页面
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => PageSecond(map, data!))));
                    },
                    child: const Text('打开第二页面'),
                  ),
                ],
              ),
              Text("传送map   1: '1111',   2: '22222',    3: '3333',"),
              SizedBox(
                height: 20,
              ),
              Text("传送Data: Data(aaa,  bbb , 12, [1, 2, 3, 4])")
            ],
          ),
        ),
      ),
    );
  }
}
