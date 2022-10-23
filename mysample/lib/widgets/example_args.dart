import 'dart:core';

import 'package:flutter/material.dart';

import 'example_args_second_page.dart';

class ExampleArgs extends StatelessWidget {
  //
  const ExampleArgs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: const MyHomePage(),
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
    return Center(
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
          const Text("传送map   1: '1111',   2: '22222',    3: '3333',"),
          const SizedBox(
            height: 20,
          ),
          const Text("传送Data: Data(aaa,  bbb , 12, [1, 2, 3, 4])"),
          //list Widget
          // TextButton(
          //     onPressed: () {
          //       getRandomWidgetArray();
          //     },
          //     child: Text('btn')),
        ],
      ),
    );
  }
  //

}

// List<Widget> getRandomWidgetArray() {
//   List<Widget> myWidget = [];

//   for (var i = 0; i < 5; i++) {
//     //myWidget.add(Positioned(child: RichText(text: TextSpan(text: '$i')))); //无法传入
//     myWidget.add(Container(child: RichText(text: TextSpan(text: '$i+a')))); //无法传入

//     //myWidget.add(RichText(text: TextSpan(text: '$i')));
//   }
//   print(myWidget);
//   return myWidget;
// }
// flutter: [RichText(softWrap: wrapping at box width, maxLines: unlimited, text: "0"), RichText(softWrap: wrapping at box width, maxLines: unlimited, text: "1"), RichText(softWrap: wrapping at box width, maxLines: unlimited, text: "2"), RichText(softWrap: wrapping at box width, maxLines: unlimited, text: "3"), RichText(softWrap: wrapping at box width, maxLines: unlimited, text: "4")]