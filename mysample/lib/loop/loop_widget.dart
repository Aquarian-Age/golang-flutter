import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<StatefulWidget> createState() => _ExampleState();
}

class _ExampleState extends State<ExamplePage> {
  List formList = [
    {"title": '车牌号'},
    {"title": '所有人'},
    {"title": '号牌颜色'},
  ];
  Widget buildGrid() {
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    for (var item in formList) {
      tiles.add(Row(children: <Widget>[Text(item['title'])]));
    }
    content = Column(children: tiles);
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('循环渲染组件案例'),
        ),
        body: Center(child: buildGrid()));
  }
}
