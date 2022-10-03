import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_my_picker_null_safety/common/date.dart';
import 'package:flutter_my_picker_null_safety/flutter_my_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/page_jqh_info.dart';
import 'package:sprintf/sprintf.dart';

import 'jqh_data.dart';

// 向服务端传送的数据
class CustomClass {
  final String times;
  final int stargn;
  final int doorgn;
  CustomClass({required this.times, required this.stargn, required this.doorgn});
  CustomClass.fromJson(Map<String, dynamic> json)
      : times = json['times'],
        stargn = json['stargn'],
        doorgn = json['doorgn'];

  static Map<String, dynamic> toJson(CustomClass data) => {'times': data.times, 'stargn': data.stargn, 'doorgn': data.doorgn};
}

//
class PageJQHfw extends StatefulWidget {
  const PageJQHfw({super.key});
  @override
  State<StatefulWidget> createState() => _PateJqhState();
}

class _PateJqhState extends State<PageJQHfw> {
  // 下拉寄宫数组 List<int>
  int stargn = 0;
  int doorgn = 0;
  void _showPickerNumber(context) {
    Picker(
        adapter: NumberPickerAdapter(
          data: [
            const NumberPickerColumn(items: [2, 8]),
            const NumberPickerColumn(items: [2, 8]),
          ],
        ),
        delimiter: [
          PickerDelimiter(
              child: Container(
            width: 20.0,
            alignment: Alignment.center,
            // child: Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: const Text("selectNumber"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          setState(() {
            var list = picker.getSelectedValues();
            stargn = list[0];
            doorgn = list[1];
          });
        }).showDialog(context);
  }

  //时间选择器组件
  String dateStr = '';
  void _datePicker(context) {
    MyPicker.showDateTimePicker(
      context: context,
      title: const Text("date"),
      onConfirm: (time) {
        setState(() {
          dateStr = MyDate.format('yyyy-MM-dd HH:mm:ss', time);
        });
      },
    );
  }

  JqhData? jqhData; //接受服务端返回的数据
  String infoStr = '';

  // POST
  postJqh() async {
    final CustomClass cc = CustomClass(times: dateStr, stargn: stargn, doorgn: doorgn);
    const url = "http://localhost:6714";
    final respones = await http.post(
      Uri.parse("$url/jqh"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      //传送时数据到服务端
      //body: jsonEncode(<String, String>{'times': dateStr}),
      body: jsonEncode(
        {'cliJqh': cc},
        toEncodable: (Object? value) => value is CustomClass ? CustomClass.toJson(value) : throw UnsupportedError('Cannot convert to JSON $value'),
      ),
    );

    if (respones.statusCode == 200) {
      jqhData = JqhData.fromJson(jsonDecode(respones.body));

      // info的json数组 转换为List<String>类型
      Map<String, dynamic> jqhMap = jsonDecode(respones.body);

      // 基础信息
      List<String> listInfo = List<String>.from(jqhMap['info'] as List);
      // print("listInfo Type: " + listInfo.runtimeType.toString());

// 简单的格式化输出
      var infoA = [
        "${listInfo[0]}            ${listInfo[4]}",
        "${listInfo[1]}    ${listInfo[5]}",
        "${listInfo[2]}    ${listInfo[6]}",
        "${listInfo[3]}          ${listInfo[7]}",
        listInfo[8],
        listInfo[9],
        listInfo[10],
        listInfo[11],
        listInfo[12],
      ];
      //九宫
      setState(() {
        infoStr = sprintf("%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n", infoA);
        jqhData;
      });
    }
  }

// GET
  getJqh() async {
    const url = "http://localhost:6714";
    final client = http.Client();
    final request = http.Request('GET', Uri.parse("$url/jqh"))..followRedirects = false;
    final response = await client.send(request);

    if (response.statusCode == 200) {
      final resp = await http.get(Uri.parse('$url/jqh'));

      jqhData = JqhData.fromJson(jsonDecode(resp.body));
      // info的json数组 转换为List<String>类型
      Map<String, dynamic> jqhMap = jsonDecode(resp.body);

      // 基础信息
      List<String> listInfo = List<String>.from(jqhMap['info'] as List);

      // 简单的格式化输出
      var infoA = [
        "${listInfo[0]}            ${listInfo[4]}",
        "${listInfo[1]}    ${listInfo[5]}",
        "${listInfo[2]}    ${listInfo[6]}",
        "${listInfo[3]}          ${listInfo[7]}",
        listInfo[8],
        listInfo[9],
        listInfo[10],
        listInfo[11],
        listInfo[12],
      ];
      setState(() {
        jqhData;
        infoStr = sprintf("%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n", infoA);
      });
    }
    client.close();
  }

  @override
  void initState() {
    super.initState();
    getJqh();
    jqhData ??= doNull() as JqhData?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('JQH'),
      //   titleTextStyle: const TextStyle(fontSize: 21),
      //   centerTitle: true, //标题居中显示
      //   // backgroundColor: Colors.blue, //标题背景颜色
      //   toolbarHeight: 40, //标题高度
      // ),
      body: ListView(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _datePicker(context);
                },
                child: const Text('select Data'),
              ),
              const SizedBox(
                width: 3,
              ),
              ElevatedButton(onPressed: postJqh, child: const Text('show')),
              const SizedBox(
                width: 3,
              ),
              ElevatedButton(
                onPressed: () {
                  _showPickerNumber(context);
                },
                child: const Text("寄宫"),
              ),
              // <- 返回主页
              TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.keyboard_backspace,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  label: const Text('')),
            ],
          ),
          Text(
            infoStr,
            style: const TextStyle(fontSize: 14),
          ),
          //-----------------
          FittedBox(
            child: Column(
              children: [
                const SizedBox(height: 6),
                _rowA(jqhData!),
                _rowB(jqhData!),
                _rowC(jqhData!),
              ],
            ),
          ),
          // ------ Btn ------
          FittedBox(
            child: Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      var args;
                      setState(() {
                        args = jqhData!.g1s.toString();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                      );
                    },
                    child: const Text(
                      '坎',
                      style: TextStyle(fontSize: 17),
                    )),
                OutlinedButton(
                    onPressed: () {
                      var args;
                      setState(() {
                        args = jqhData!.g8s.toString();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                      );
                    },
                    child: const Text(
                      '艮',
                      style: TextStyle(fontSize: 17),
                    )),
                OutlinedButton(
                    onPressed: () {
                      var args;
                      setState(() {
                        args = jqhData!.g3s.toString();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                      );
                    },
                    child: const Text(
                      '震',
                      style: TextStyle(fontSize: 17),
                    )),
                OutlinedButton(
                    onPressed: () {
                      var args;
                      setState(() {
                        args = jqhData!.g4s.toString();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                      );
                    },
                    child: const Text(
                      '巽',
                      style: TextStyle(fontSize: 17),
                    )),
                OutlinedButton(
                    onPressed: () {
                      var args;
                      setState(() {
                        args = jqhData!.g9s.toString();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                      );
                    },
                    child: const Text(
                      '离',
                      style: TextStyle(fontSize: 17),
                    )),
                OutlinedButton(
                    onPressed: () {
                      var args;
                      setState(() {
                        args = jqhData!.g2s.toString();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                      );
                    },
                    child: const Text(
                      '坤',
                      style: TextStyle(fontSize: 17),
                    )),
                OutlinedButton(
                    onPressed: () {
                      var args;
                      setState(() {
                        args = jqhData!.g7s.toString();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                      );
                    },
                    child: const Text(
                      '兑',
                      style: TextStyle(fontSize: 17),
                    )),
                OutlinedButton(
                    onPressed: () {
                      var args;
                      setState(() {
                        args = jqhData!.g6s.toString();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                      );
                    },
                    child: const Text(
                      '乾',
                      style: TextStyle(fontSize: 17),
                    )),
                OutlinedButton(
                  onPressed: () {
                    var args;
                    setState(() {
                      args = jqhData!.g5s.toString();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                    );
                  },
                  child: const Text(
                    '中',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //-----------九宫布局 4 9 2 -----------
  Widget _rowA(JqhData jqh) {
    return Row(
      children: [
        //------巽宫-----
        Container(
          width: 140,
          height: 120,
          alignment: Alignment.centerLeft,
          // margin: const EdgeInsets.all(3), //外间距
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3), //圆角
            color: Colors.white,
            //边框
            border: Border.all(
              width: 1,
              color: Colors.red,
            ),
          ),
          child: Column(
            children: [
              Text(
                jqh.xunBaShen.toString(),
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                "${jqh.xunStar} ${jqh.xunTianQi}",
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                "${jqh.xunDoor} ${jqh.xunDiQi}",
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                "${jqh.xunAgz}",
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),

        // ------ 离宫 -----
        Container(
          width: 140,
          height: 120,
          alignment: Alignment.centerLeft,
          // margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3), //圆角
            color: Colors.white,
            //边框
            border: Border.all(
              width: 1,
              color: Colors.red,
            ),
          ),
          child: Column(
            children: [
              Text(
                jqh.liBaShen.toString(),
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                "${jqh.liStar} ${jqh.liTianQi}",
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                "${jqh.liDoor} ${jqh.liDiQi}",
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                "${jqh.liAgz}",
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),

        //  ---- 坤宫 -----
        Container(
          width: 140,
          height: 120,
          alignment: Alignment.centerLeft,
          // margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3), //圆角
            color: Colors.white,
            //边框
            border: Border.all(
              width: 1,
              color: Colors.red,
            ),
          ),
          child: Column(
            children: [
              Text(
                jqh.kunBaShen.toString(),
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                "${jqh.kunStar} ${jqh.kunTianQi}",
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                "${jqh.kunDoor} ${jqh.kunDiQi}",
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                "${jqh.kunAgz}",
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//------------ 九宫布局 3 5 7 -----------
Widget _rowB(jqh) {
  return Row(
    children: [
      // -------- 震宫 -------
      Container(
        width: 140,
        height: 120,
        alignment: Alignment.centerLeft,
        // margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3), //圆角
          color: Colors.white,
          //边框
          border: Border.all(
            width: 1,
            color: Colors.red,
          ),
        ),
        child: Column(
          children: [
            Text(
              jqh.zhenBaShen.toString(),
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.zhenStar} ${jqh.zhenTianQi}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.zhenDoor} ${jqh.zhenDiQi}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.zhenAgz}",
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),

      // --------中5 -----------
      Container(
        width: 140,
        height: 120,
        alignment: Alignment.centerLeft,
        // margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3), //圆角
          color: Colors.white,
          //边框
          border: Border.all(
            width: 1,
            color: Colors.red,
          ),
        ),
        child: Column(
          children: [
            Text(
              jqh.zhongBaShen.toString(),
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.zhongStar} ${jqh.zhongTianQi}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.zhongDoor} ${jqh.zhongDiQi}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.zhongAgz}",
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),

      // ------ 兑宫 ---------
      Container(
        width: 140,
        height: 120,
        alignment: Alignment.centerLeft,
        // margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3), //圆角
          color: Colors.white,
          //边框
          border: Border.all(
            width: 1,
            color: Colors.red,
          ),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jqh.duiBaShen.toString(),
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.duiStar} ${jqh.duiTianQi}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.duiDoor} ${jqh.duiDiQi}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.duiAgz}",
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    ],
  );
}

//------------ 九宫布局 8 1 6 -----------
Widget _rowC(jqh) {
  return Row(
    children: [
      // ----- 艮宫 -----
      Container(
        width: 140,
        height: 120,
        alignment: Alignment.centerLeft,
        // margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3), //圆角
          color: Colors.white,
          //边框
          border: Border.all(
            width: 1,
            color: Colors.red,
          ),
        ),
        child: Column(
          children: [
            Text(
              jqh.genBaShen.toString(),
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.genStar} ${jqh.genTianQi}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.genDoor} ${jqh.genDiQi}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.genAgz}",
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),

      // ----- 坎宫 -----
      Container(
        width: 140,
        height: 120,
        alignment: Alignment.centerLeft,
        // margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3), //圆角
          color: Colors.white,
          //边框
          border: Border.all(
            width: 1,
            color: Colors.red,
          ),
        ),
        child: Column(
          children: [
            Text(
              jqh.kanBaShen.toString(),
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.kanStar} ${jqh.kanTianQi}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.kanDoor} ${jqh.kanDiQi}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.kanAgz}",
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),

      // ----- 乾宫 ------
      Container(
        width: 140,
        height: 120,
        alignment: Alignment.centerLeft,
        // margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3), //圆角
          color: Colors.white,
          //边框
          border: Border.all(
            width: 1,
            color: Colors.red,
          ),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jqh.qianBaShen.toString(),
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.qianStar} ${jqh.qianTianQi}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.qianDoor} ${jqh.qianDiQi}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "${jqh.qianAgz}",
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    ],
  );
}
