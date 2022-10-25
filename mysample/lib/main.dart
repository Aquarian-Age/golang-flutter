import 'package:flutter/material.dart';
import 'package:mysample/async_awite/async_awite.dart';
import 'package:mysample/login/login.dart';
import 'package:mysample/widgets/CupertinoActivityIndicator.dart';
import 'package:mysample/widgets/add_item_to_listview.dart';
import 'package:mysample/widgets/custom_painter.dart';
import 'package:mysample/widgets/form.dart';
import 'package:mysample/widgets/gestureDetector.dart';
import 'package:mysample/widgets/progress.dart';
import 'package:mysample/widgets/richtext.dart';

import 'http/http.dart';
import 'widgets/example_args.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: FlutterExample(),
    );
  }
}

// ignore: must_be_immutable
class FlutterExample extends StatelessWidget {
  FlutterExample({super.key});
  double font = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('login'),
              subtitle: const Text('前端登陆 后端Go服务处理登陆请求'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Login())),
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text('Flutter Example')),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'RichText',
              style: TextStyle(fontSize: font, color: Colors.blue),
            ),
            subtitle: const Text('TextSpan text 点击事件'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExapmleRichText()));
            },
          ),
          ListTile(
            title: Text(
              'CustomPaint',
              style: TextStyle(fontSize: font, color: Colors.red),
            ),
            subtitle: const Text('画圆 自定义Widget Positioned组件'),
            onTap: (() {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExampleCustomPainter()));
            }),
          ),
          ListTile(
            title: const Text('GestureDetector'),
            subtitle: const Text("检测手势的小部件"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExampleGestureDetector()));
            },
          ),
          ListTile(
            title: const Text('页面传参'),
            subtitle: const Text('不同页面传递参数,  Navigator跳转页面'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ExampleArgs())),
          ),
          ListTile(
            title: const Text('添加元素到ListView'),
            subtitle: const Text('ListView.builder(), TextField(), Expanded()'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExampleAddItemToListView()));
            },
          ),
          ListTile(
            title: const Text('form'),
            subtitle: const Text(' GestureDetector , TextField, showDialog, AlertDialog'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ExampleForm())),
          ),
          ListTile(
            title: const Text('CupertinoIndicatorApp'),
            subtitle: const Text('显示圆形“微调器”'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CupertinoIndicatorApp())),
          ),
          ListTile(
            title: const Text('async'),
            subtitle: const Text('async awite  FutureBuilder()  AnimatedOpacity() 动画 CupertinoActivityIndicator()旋转等待'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExampleAsyncAwite(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('http future'),
            subtitle: const Text('get post请求 async异步 FutureBuild()'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ExampleHttpPage()),
              );
            },
          ),
          ListTile(
            title: const Text('progress'),
            subtitle: const Text('进度条'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ExampleProgeress())),
          )
        ],
      ),
    );
  }
}
