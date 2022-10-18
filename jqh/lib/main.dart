import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_my_picker_null_safety/common/date.dart';
import 'package:flutter_my_picker_null_safety/flutter_my_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jqh/xjbfs.dart';
import 'package:sprintf/sprintf.dart';
import 'package:window_manager/window_manager.dart';

import 'about_apge.dart';
import 'jqh_client.dart';
import 'jqh_data.dart';
import 'jqh_info.dart';
import 'painter.dart';
import 'show_text.dart';
import 'show_text2.dart';
import 'show_text3.dart';
import 'show_text4.dart';

void setWindowsSize() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(600, 850),
      minimumSize: Size(600, 850),
      center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}

void main() async {
  setWindowsSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(Object context) {
    return MaterialApp(
      title: "JQH",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "JQH",
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true, //标题居中显示

          toolbarHeight: 40, //标题高度
        ),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  JqhData? jqhData;
  Map<int, String> mapbs = {}; //八神
  Map<int, String> mapjx = {}; //九星
  Map<int, String> maptg = {}; //天盘干
  Map<int, String> mapbm = {}; //八门
  Map<int, String> mapdg = {}; //地盘干
  String strA = '';
  String strB = '';
  String strC = '';
  String strM = ''; //中宫地盘干 暗干
  String strX = ''; //中宫月将天门 天马

  /// 下拉寄宫数组 List<int>
  int stargn = 0;
  int doorgn = 0;
  _showPickerNumber(context) {
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
  String times = '';
  _datePicker(context) {
    MyPicker.showDateTimePicker(
      context: context,
      title: const Text("date"),
      onConfirm: (time) {
        setState(() {
          times = MyDate.format('yyyy-MM-dd HH:mm:ss', time);
        });
      },
    );
  }

  /// POST
  postJqh() async {
    final CustomClass cc = CustomClass(times: times, stargn: stargn, doorgn: doorgn);

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
      // [阳历时间，干支，旬空，节气，起局，值符，值使，旬首，五不遇/天显,三门 .地四户,地私门, 阴历]
      // [2022-10-16 12:15, 干支: 壬寅 庚戌 壬寅 丙午, 旬空: 辰巳 寅卯 辰巳 寅卯, 寒露:2022-10-08 15, 起局: 阴遁中元9局, 值符: 天禽 落2宫, 值使: 死门 落3宫, 旬首: 甲辰遁(壬), , 三门: 太冲:巳从魁:亥小吉:酉, 地四户: 除在:未 定在:戌 危在:丑 开在:辰, 私门: 六合:寅 太阴:未 太常:酉, 九月廿一]
      List<String> listInfo = List<String>.from(jqhMap['info'] as List);
      // print("listInfo Type: " + listInfo.runtimeType.toString());

      // 简单的格式化输出
      var listA = [
        listInfo[0],
        listInfo[1],
        listInfo[2],
        listInfo[3],
        listInfo[12],
      ];
      var listB = [
        listInfo[4],
        listInfo[5],
        listInfo[6],
        listInfo[7],
        listInfo[8],
      ];
      var listC = [
        listInfo[9],
        listInfo[10],
        listInfo[11],
      ];
      strA = sprintf("%s\n%s\n%s\n%s", listA);
      strB = sprintf("%s\n%s\n%s\n%s\n%s", listB);
      strC = sprintf("%s\n%s\n%s", listC);

      //九宫信息
      // String kanBaShen = jqhMap['kan_ba_shen'];
      // print("kanBanShen:" + kanBaShen);

      //jqhData = doJqhMap(jqhMap);
      //print(jqhData!.kanBaShen.runtimeType.toString());
      //八神map
      mapbs = {
        1: jqhData!.kanBaShen.toString(),
        8: jqhData!.genBaShen.toString(),
        3: jqhData!.zhenBaShen.toString(),
        4: jqhData!.xunBaShen.toString(),
        9: jqhData!.liBaShen.toString(),
        2: jqhData!.kunBaShen.toString(),
        7: jqhData!.duiBaShen.toString(),
        6: jqhData!.qianBaShen.toString(),
      };
      mapjx = {
        1: jqhData!.kanStar.toString(),
        8: jqhData!.genStar.toString(),
        3: jqhData!.zhenStar.toString(),
        4: jqhData!.xunStar.toString(),
        9: jqhData!.liStar.toString(),
        2: jqhData!.kunStar.toString(),
        7: jqhData!.duiStar.toString(),
        6: jqhData!.qianStar.toString(),
      };
      maptg = {
        1: jqhData!.kanTianQi.toString(),
        8: jqhData!.genTianQi.toString(),
        3: jqhData!.zhenTianQi.toString(),
        4: jqhData!.xunTianQi.toString(),
        9: jqhData!.liTianQi.toString(),
        2: jqhData!.kunTianQi.toString(),
        7: jqhData!.duiTianQi.toString(),
        6: jqhData!.qianTianQi.toString(),
      };
      mapbm = {
        1: jqhData!.kanDoor.toString(),
        8: jqhData!.genDoor.toString(),
        3: jqhData!.zhenDoor.toString(),
        4: jqhData!.xunDoor.toString(),
        9: jqhData!.liDoor.toString(),
        2: jqhData!.kunDoor.toString(),
        7: jqhData!.duiDoor.toString(),
        6: jqhData!.qianDoor.toString(),
      };
      mapdg = {
        1: jqhData!.kanDiQi.toString(),
        8: jqhData!.genDiQi.toString(),
        3: jqhData!.zhenDiQi.toString(),
        4: jqhData!.xunDiQi.toString(),
        9: jqhData!.liDiQi.toString(),
        2: jqhData!.kunDiQi.toString(),
        7: jqhData!.duiDiQi.toString(),
        6: jqhData!.qianDiQi.toString(),
      };
      var listM = [
        jqhData!.zhongDiQi.toString(),
        jqhData!.zhongAgz.toString(),
      ];
      strM = sprintf("%s\n%s", listM);
      var listX = [
        jqhData!.zhongBaShen.toString(),
        jqhData!.zhongStar.toString(),
        jqhData!.zhongTianQi.toString(),
      ];
      strX = sprintf("%s %s %s\n", listX);
      setState(() {
        // jqhData;
        mapbs;
        mapjx;
        maptg;
        mapbm;
        mapdg;
        strA;
        strB;
        strC;
        strM;
        strX;
      });
    }
  }

// GET
  getJqh() async {
    const url = "http://localhost:6714";
    final client = http.Client();
    final request = http.Request('GET', Uri.parse("$url/jqh"))..followRedirects = true;
    final response = await client.send(request);

    if (response.statusCode == 200) {
      final resp = await http.get(Uri.parse('$url/jqh'));

      jqhData = JqhData.fromJson(jsonDecode(resp.body));
      // info的json数组 转换为List<String>类型
      Map<String, dynamic> jqhMap = jsonDecode(resp.body);

      // 基础信息
      List<String> listInfo = List<String>.from(jqhMap['info'] as List);

      var listA = [
        listInfo[0],
        listInfo[1],
        listInfo[2],
        listInfo[3],
        listInfo[12],
      ];
      var listB = [
        listInfo[4],
        listInfo[5],
        listInfo[6],
        listInfo[7],
        listInfo[8],
      ];
      var listC = [
        listInfo[9],
        listInfo[10],
        listInfo[11],
      ];
      var listM = [
        jqhData!.zhongDiQi.toString(),
        jqhData!.zhongAgz.toString(),
      ];
      var listX = [
        jqhData!.zhongBaShen.toString(),
        jqhData!.zhongStar.toString(),
        jqhData!.zhongTianQi.toString(),
      ];
      strA = sprintf("%s\n%s\n%s\n%s", listA);
      strB = sprintf("%s\n%s\n%s\n%s\n%s", listB);
      strC = sprintf("%s\n%s\n%s", listC);
      strM = sprintf("%s\n%s", listM);
      strX = sprintf("%s %s %s\n", listX);
      //八神map
      mapbs = {
        1: jqhData!.kanBaShen.toString(),
        8: jqhData!.genBaShen.toString(),
        3: jqhData!.zhenBaShen.toString(),
        4: jqhData!.xunBaShen.toString(),
        9: jqhData!.liBaShen.toString(),
        2: jqhData!.kunBaShen.toString(),
        7: jqhData!.duiBaShen.toString(),
        6: jqhData!.qianBaShen.toString(),
      };
      mapjx = {
        1: jqhData!.kanStar.toString(),
        8: jqhData!.genStar.toString(),
        3: jqhData!.zhenStar.toString(),
        4: jqhData!.xunStar.toString(),
        9: jqhData!.liStar.toString(),
        2: jqhData!.kunStar.toString(),
        7: jqhData!.duiStar.toString(),
        6: jqhData!.qianStar.toString(),
      };
      maptg = {
        1: jqhData!.kanTianQi.toString(),
        8: jqhData!.genTianQi.toString(),
        3: jqhData!.zhenTianQi.toString(),
        4: jqhData!.xunTianQi.toString(),
        9: jqhData!.liTianQi.toString(),
        2: jqhData!.kunTianQi.toString(),
        7: jqhData!.duiTianQi.toString(),
        6: jqhData!.qianTianQi.toString(),
      };
      mapbm = {
        1: jqhData!.kanDoor.toString(),
        8: jqhData!.genDoor.toString(),
        3: jqhData!.zhenDoor.toString(),
        4: jqhData!.xunDoor.toString(),
        9: jqhData!.liDoor.toString(),
        2: jqhData!.kunDoor.toString(),
        7: jqhData!.duiDoor.toString(),
        6: jqhData!.qianDoor.toString(),
      };
      mapdg = {
        1: jqhData!.kanDiQi.toString(),
        8: jqhData!.genDiQi.toString(),
        3: jqhData!.zhenDiQi.toString(),
        4: jqhData!.xunDiQi.toString(),
        9: jqhData!.liDiQi.toString(),
        2: jqhData!.kunDiQi.toString(),
        7: jqhData!.duiDiQi.toString(),
        6: jqhData!.qianDiQi.toString(),
      };
      setState(() {
        mapbs;
        mapjx;
        maptg;
        mapbm;
        mapdg;
        strA;
        strB;
        strC;
        strM;
        strX;
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

  String args = ''; //info_gn
  ///
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print("屏幕宽/高: $size"); //宽度 高度
    //
    var wh = min(size.width, size.height); //约定最小值
    var b = Platform.isWindows || Platform.isLinux;
    double font;
    b ? font = 18.0 : font = 13.0;
    //
    return ListView(
      // shrinkWrap: true,
      padding: EdgeInsets.zero, //取消容器间的间距
      children: [
        Row(
          children: [
            //时间选择
            TextButton.icon(
              label: const Text(''),
              icon: const Icon(Icons.date_range_outlined),
              onPressed: () {
                _datePicker(context);
              },
              // child: Text(
              //   'date',
              //   style: TextStyle(
              //     fontSize: font,
              //     color: const Color.fromARGB(255, 208, 208, 85),
              //   ),
              // ),
            ),
            TextButton.icon(
              label: const Text(''),
              icon: const Icon(Icons.done_outline_rounded),
              onPressed: () {
                postJqh();
              },
              // child: Text(
              //   'jqh',
              //   style: TextStyle(fontSize: font, color: Colors.red),
              // ),
            ),
            TextButton.icon(
              label: const Text(''),
              icon: const Icon(Icons.door_back_door_outlined),
              onPressed: () {
                _showPickerNumber(context);
              },
              // child: Text(
              //   "gx",
              //   style: TextStyle(fontSize: font, color: Colors.blue),
              // ),
            ),
            TextButton.icon(
              label: const Text(''),
              icon: const Icon(Icons.man),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
              // child: Text(
              //   'about',
              //   style: TextStyle(fontSize: font, color: Colors.blue),
              // ),
            ),
            //xjbfs
            TextButton.icon(
              label: const Text(''),
              icon: const Icon(Icons.book_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PageXjbfs(),
                  ),
                );
              },
              // child: Text(
              //   'xjbfs',
              //   style: TextStyle(fontSize: font, color: Colors.green),
              // ),
            ),
          ],
        ),
        //infos
        Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                strA,
                style: TextStyle(fontSize: font, color: const Color.fromARGB(235, 243, 65, 228)),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                strB,
                style: TextStyle(fontSize: font, color: const Color.fromARGB(235, 243, 65, 228)),
              ),
            )
          ],
        ),
        // info_gn
        FittedBox(
          child: Row(
            children: [
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      args = jqhData!.g1s.toString();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                    );
                  },
                  child: Text(
                    '坎',
                    style: TextStyle(fontSize: font),
                  )),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      args = jqhData!.g8s.toString();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                    );
                  },
                  child: Text(
                    '艮',
                    style: TextStyle(fontSize: font),
                  )),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      args = jqhData!.g3s.toString();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                    );
                  },
                  child: Text(
                    '震',
                    style: TextStyle(fontSize: font),
                  )),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      args = jqhData!.g4s.toString();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                    );
                  },
                  child: Text(
                    '巽',
                    style: TextStyle(fontSize: font),
                  )),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      args = jqhData!.g9s.toString();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                    );
                  },
                  child: Text(
                    '离',
                    style: TextStyle(fontSize: font),
                  )),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      args = jqhData!.g2s.toString();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                    );
                  },
                  child: Text(
                    '坤',
                    style: TextStyle(fontSize: font),
                  )),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      args = jqhData!.g7s.toString();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                    );
                  },
                  child: Text(
                    '兑',
                    style: TextStyle(fontSize: font),
                  )),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      args = jqhData!.g6s.toString();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                    );
                  },
                  child: Text(
                    '乾',
                    style: TextStyle(fontSize: font),
                  )),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    args = jqhData!.g5s.toString();
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageJqhInfo(args)),
                  );
                },
                child: Text(
                  '中',
                  style: TextStyle(fontSize: font),
                ),
              ),
            ],
          ),
        ),
        //---圆---
        Stack(
          children: [
            //外侧圆
            SizedBox(
              width: wh,
              height: wh,
              child: CustomPaint(
                painter: MyPainter(),
                foregroundPainter: ShowText(mapbm, mapdg, size.width, size.height),
              ),
            ),
            //次外侧圆
            SizedBox(
              width: wh,
              height: wh,
              child: CustomPaint(
                painter: ShowText2(mapjx, maptg, size.width * 0.7, size.height * 0.7),
              ),
            ),
            //次次外侧圆(text3)
            SizedBox(
              width: wh,
              height: wh,
              child: CustomPaint(
                painter: ShowText3(mapbs, size.width * 0.4, size.height * 0.4),
              ),
            ),

            ///最内层圆心
            ///中宫
            SizedBox(
              width: wh,
              height: wh,
              child: CustomPaint(
                painter: ShowText4(
                  strm: strM,
                  width: size.width,
                  height: size.height,
                ),
              ),
            ),
          ],
        ),
        //三门四户 月将 天门 天马
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "$strC\n$strX",
            style: TextStyle(fontSize: font, color: const Color.fromARGB(235, 243, 65, 228)),
          ),
        ),
      ],
    );
  }
}

const List list = [
  "寒露",
  "霜降",
  "立冬",
  "小雪",
  "大雪",
  "冬至",
  "小寒",
  "大寒",
  "立春",
  "雨水",
  "惊蛰",
  "春分",
  "清明",
  "谷雨",
  "立夏",
  "小满",
  "芒种",
  "夏至",
  "小暑",
  "大暑",
  "立秋",
  "处暑",
  "白露",
  "秋分",
];
