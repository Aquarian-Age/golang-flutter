import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/page_info.dart';
import 'package:my_app/page_jqh.dart';
import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(const MyApp());
}

const double windowWidth = 620;
const double windowHeight = 800;
void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized(); //调用 [runApp] 之前初始化绑定
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      //启动居中?  设置包含此 Flutter 实例的窗口的框架
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(size);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "my_app",
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true, //标题居中显示
          //backgroundColor: Colors.white, //标题背景颜色
          toolbarHeight: 40, //标题高度
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 60,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PageInfo()));
                  },
                  child: const Text(
                    'INFO',
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 60,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => const PageJQHfw())));
                  },
                  child: const Text(
                    'JQH',
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
