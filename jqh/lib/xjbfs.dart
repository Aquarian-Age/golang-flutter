import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_my_picker_null_safety/common/date.dart';
import 'package:flutter_my_picker_null_safety/flutter_my_picker.dart';
import 'package:http/http.dart' as http;

// https://docs.flutter.dev/cookbook/networking/send-data
// 客户端输入 以POST json格式 传送给服务端
// Future<InfoData> createData(String data) async {
//   const url = "http://localhost:6714";
//   final respones = await http.post(
//     Uri.parse(url),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'times': data,
//     }),
//   );
//   //服务器返回来的数据
//   if (respones.statusCode == 200) {
//     return InfoData.fromJson(jsonDecode(respones.body));
//   } else {
//     throw Exception('Failed to create infoData');
//   }
// }

class XjbfsData {
  String times;
  String info;
  XjbfsData({required this.times, required this.info});

  factory XjbfsData.fromJson(Map<String, dynamic> json) {
    return XjbfsData(
      times: json['times'],
      info: json['info'],
    );
  }
}

class PageXjbfs extends StatefulWidget {
  const PageXjbfs({super.key});

  @override
  State<PageXjbfs> createState() => _PageXjbfsState();
}

class _PageXjbfsState extends State<PageXjbfs> {
  //时间选择器组件
  String dateStr = '';
  void _datePicker(context) {
    MyPicker.showDateTimePicker(
      context: context,
      magnification: 1.2,
      offAxisFraction: 0.2,
      title: const Text("date"),
      onConfirm: (time) {
        setState(() {
          dateStr = MyDate.format('yyyy-MM-dd HH:mm:ss', time);
        });
      },
    );
  }

//传送时间到服务端
  late XjbfsData infoData;
  String infoStr = '';
  getInfo() async {
    const url = "http://localhost:6714";
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
      Map<String, dynamic> clid = jsonDecode(respones.body);
      //  print("clid Type: " + clid.runtimeType.toString());//_InternalLinkedHashMap<String, dynamic>
      //infoData = InfoData.fromJson(jsonDecode(respones.body));//需要客户端和服务端传送相同的数量和名称
      infoStr = clid['info'];
      List listRiJi = clid['riji'];
      List listRiXiong = clid['rixiong'];
      String strRiji = listRiJi.join(",");
      String strRiXiong = listRiXiong.join(',');
      infoStr += "日吉: $strRiji\n";
      infoStr += "日凶: $strRiXiong\n";
      setState(() {
        //infoStr = clid['info'];
        infoStr;
      });
    }
  }

  // 节气
  getJieQi() async {
    const url = "http://localhost:6714";
    final respones = await http.post(
      Uri.parse("$url/info"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'times': dateStr, //传送时间到服务端
      }),
    );
    List lisJq;
    if (respones.statusCode == 200) {
      Map<String, dynamic> clid = jsonDecode(respones.body);
      lisJq = clid['jieqi'];
      infoStr = lisJq.join("\n");
      setState(() {
        infoStr;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("XJBFS"),
        titleTextStyle: const TextStyle(fontSize: 21),
        centerTitle: true, //标题居中显示
        toolbarHeight: 40, //标题高度
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Row(
            children: [
              TextButton.icon(
                label: const Text('时间'),
                icon: const Icon(Icons.date_range_outlined),
                onPressed: () {
                  _datePicker(context);
                },
              ),
              TextButton.icon(
                label: const Text('显示'),
                icon: const Icon(Icons.panorama_fish_eye_sharp),
                onPressed: getInfo,
              ),
              const SizedBox(
                width: 3,
              ),
              //------ jq24 ------
              TextButton.icon(
                label: const Text('节气'),
                icon: const Icon(Icons.solar_power),
                onPressed: () {
                  getJieQi();
                },
              ),
            ],
          ),
          Text(
            infoStr,
            style: const TextStyle(fontSize: 16, color: Colors.deepPurpleAccent),
          ),
        ],
      ),
    );
  }
}
