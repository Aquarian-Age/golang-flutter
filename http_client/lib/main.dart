import 'dart:convert';
import 'dart:core';

import 'package:cli/second_page.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClientData {
  String? times;
  String? info;
  ClientData({required this.times, required this.info});

  factory ClientData.fromJson(Map<String, dynamic> json) {
    return ClientData(
      times: json['times'],
      info: json['info'],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'httpClient',
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
  ClientData? clientData; //声明?
  static const url = "http://localhost:6714";

// GET 点击第二页面自动显示GET内容
  getInfo() async {
    final client = http.Client();
    final request = http.Request('GET', Uri.parse("$url/info"))..followRedirects = false;
    final response = await client.send(request);

    if (response.statusCode == 200) {
      final resp = await http.get(Uri.parse('$url/info'));
      clientData = ClientData.fromJson(jsonDecode(resp.body));
      setState(() {
        clientData;
      });
    }
  }

// POST
  String infoStr = '';
  var dateStr = formatDate(DateTime.now().toLocal(), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]); //flutter: 1989-02-01 15:40:10
  void postInfo() async {
    print('post info');
    final respones = await http.post(
      Uri.parse("$url/info"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'times': dateStr, //传送时间到服务端
      }),
    );

    if (respones.statusCode == 200) {
      clientData = ClientData.fromJson(jsonDecode(respones.body));
      setState(() {
        infoStr = clientData!.info!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "http_get_post",
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
                  TextButton(onPressed: postInfo, child: const Text('post')),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  OutlinedButton(
                      onPressed: () async {
                        print('====== get info ======');
                        await getInfo();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecondPage(clientData!)),
                        );
                      },
                      child: Text('goto second page')),
                ],
              ),
              Text(infoStr),
            ],
          ),
        ),
      ),
    );
  }
}
