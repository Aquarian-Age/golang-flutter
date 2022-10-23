import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  final fromLogin; //接收login页面传来的值
  const MyPage(this.fromLogin, {super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    print("${widget.fromLogin}"); //取值
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(widget.fromLogin),
    );
  }
}
