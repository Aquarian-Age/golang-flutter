import 'dart:convert';
import 'dart:core';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'second_page.dart';

class ClientData {
  String? times;
  String? info;
  Map? xmap;
  ClientData({required this.times, required this.info, required this.xmap});

  factory ClientData.fromJson(Map<String, dynamic> json) {
    return ClientData(
      times: json['times'],
      info: json['info'],
      xmap: json['xmap'],
    );
  }
}

Future<ClientData> getServerData(String url) async {
  late ClientData clientData;
  // GET 点击第二页面自动显示GET内容
  final client = http.Client();
  final request = http.Request('GET', Uri.parse("$url/info"))..followRedirects = false;
  final response = await client.send(request);

  if (response.statusCode == 200) {
    final resp = await http.get(Uri.parse('$url/info'));
    clientData = ClientData.fromJson(jsonDecode(resp.body));
  }
  return clientData;
}

Future<ClientData> postServerData(String url, String dateStr) async {
  late ClientData clientData;
  final resp = await http.post(
    Uri.parse("$url/info"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'times': dateStr, //传送时间到服务端
    }),
  );
  if (resp.statusCode == 200) {
    clientData = ClientData.fromJson(jsonDecode(resp.body));
  }

  return clientData;
}

class ExampleHttpPage extends StatefulWidget {
  const ExampleHttpPage({super.key});

  @override
  State<ExampleHttpPage> createState() => _ExampleHttpPageState();
}

class _ExampleHttpPageState extends State<ExampleHttpPage> {
  static const url = "http://localhost:6900";
  var dateStr = formatDate(DateTime.now().toLocal(), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]); //flutter: 1989-02-01 15:40:10
  String infoStr = '';
  Map<dynamic, dynamic> xmap = {};
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "http",
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
                  const SizedBox(width: 6),
                  FutureBuilder(
                    future: postServerData(url, dateStr),
                    builder: (context, snapshot) {
                      return OutlinedButton(
                        onPressed: () {
                          if (!snapshot.hasData) {
                            const Text("loading");
                          }
                          // print("data  ${snapshot.data!.info}");
                          setState(() {
                            infoStr = snapshot.data!.info!;
                          });
                        },
                        child: const Text('info'),
                      );
                    },
                  ),
                  const SizedBox(width: 6),
                  FutureBuilder(
                    future: getServerData(url),
                    builder: (context, snapshot) {
                      return OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SecondPage(snapshot.data)),
                          );
                        },
                        child: const Text('page2'),
                      );
                    },
                  ),
                ],
              ),
              const Text("xmap"),
              FutureBuilder(
                future: getServerData(url),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text("loading");
                  }
                  xmap = snapshot.data!.xmap!;
                  // print("${xmap['1']}");
                  return Text("${snapshot.data!.xmap}");
                  // return Column(
                  //   children: [
                  //     Text(xmap['1']!),
                  //     Text(xmap['2']!),
                  //     Text(xmap['3']!),
                  //     Text(xmap['4']!),
                  //   ],
                  // );
                }),
              ),
              Text(
                infoStr,
                style: const TextStyle(color: Colors.red, fontSize: 19, decoration: TextDecoration.none),
              ),
              Text("xmap[1]: ==> ${xmap['1']}"),
              Text("xmap[2]: ==> ${xmap['2']}"),
              Text("xmap[3]: ==> ${xmap['3']}"),
              Text("xmap[4]: ==> ${xmap['4']}"),
            ],
          ),
        ),
      ),
    );
  }
}
