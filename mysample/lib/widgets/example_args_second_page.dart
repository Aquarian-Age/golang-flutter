import 'package:flutter/material.dart';

class Data {
  String? aaa;
  String? bbb;
  int? iii;
  List? lll;

  Data(this.aaa, this.bbb, this.iii, this.lll);
}

// ignore: must_be_immutable
class PageSecond extends StatefulWidget {
  dynamic map; // 定义(实例化) 第一页面传来的值
  Data data;
  PageSecond(this.map, this.data, {super.key});

  @override
  State<StatefulWidget> createState() => _PateJQHState();
}

class _PateJQHState extends State<PageSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JQH'), titleTextStyle: const TextStyle(fontSize: 21),
        centerTitle: true, //标题居中显示
        backgroundColor: Colors.blue, //标题背景颜色
        toolbarHeight: 40, //标题高度
      ),
      body: Column(
        children: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context); //触发返回
            },
            icon: const Icon(
              Icons.keyboard_backspace,
              color: Colors.green,
              size: 40.0,
            ),
            label: const Text('back'),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: Column(
            children: [
              Text("首页传送来的数据: ${widget.map[1]}"), //主页面传送来的值 ,
              const SizedBox(
                height: 20,
              ),
              Text("首页传送来的Data类: ${widget.data.iii.toString()}"),
              Text("首页传送来的Data类: ${widget.data.lll.toString()}"),
              Text("首页传送来的Data类: ${widget.data.aaa.toString()}"),
            ],
          )),
          Text("data+${widget.map[1]}"), //主页面传送来的值
        ],
      ),
    );
  }
}
