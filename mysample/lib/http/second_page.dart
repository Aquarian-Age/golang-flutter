import 'package:flutter/material.dart';

import 'http.dart';

// ignore: must_be_immutable
class SecondPage extends StatefulWidget {
  ClientData? clientData; // 设置
  SecondPage(this.clientData, {super.key}); //设置
  @override
  State<StatefulWidget> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String? times; //声明
  String? info; //声明

  @override
  //初始化
  initState() {
    super.initState();
    info = widget.clientData!.info; //取出第一页面传递来的的值
    times = widget.clientData!.times;
  }

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppBar(
            title: const Text("Second Page"),
            titleTextStyle: const TextStyle(fontSize: 21),
            centerTitle: true, //标题居中显示
            toolbarHeight: 40, //标题高度
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            info.toString(), //服务端返回的数据
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
          SizedBox(
            height: 30,
          ),
          Text(times.toString()), //服务端返回的时间
        ],
      ),
    );
  }
}
