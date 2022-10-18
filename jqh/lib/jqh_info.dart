import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageJqhInfo extends StatefulWidget {
  String? args;
  PageJqhInfo(this.args, {super.key});

  @override
  State<StatefulWidget> createState() => _JqhInfoState();
}

class _JqhInfoState extends State<PageJqhInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JqhInfo'),
        titleTextStyle: const TextStyle(fontSize: 21),
        centerTitle: true, //标题居中显示
        toolbarHeight: 40, //标题高度
      ),
      body: ListView(
        children: [
          Text(
            widget.args.toString(),
            style: const TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}
