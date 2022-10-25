import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:sprintf/sprintf.dart';

class ExampleAsyncAwite extends StatefulWidget {
  const ExampleAsyncAwite({super.key});

  @override
  State<ExampleAsyncAwite> createState() => _ExampleAsyncAwiteState();
}

class _ExampleAsyncAwiteState extends State<ExampleAsyncAwite> {
  @override
  void initState() {
    getinfo();
    super.initState();
  }

  // double n = 0.0;
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            'example async awite',
            style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: Colors.blue), //去除下面黄线
          ),
          FutureBuilder(
            future: getinfo(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading');
              }
              return Text(
                'Loading Complete: ${snapshot.data}',
                style: Theme.of(context).textTheme.bodyMedium,
              );
            }),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: const Text("Upload File"),
            onPressed: () {
              value = 0;
              uploadFile();
              // setState(() {});
            },
          ),

          CupertinoActivityIndicator.partiallyRevealed(
            progress: value,
            radius: 30,
          )
          // ///
          // const CupertinoActivityIndicator(
          //   animating: true,
          //   // color: Colors.red,
          // ),
          // SizedBox(height: 30),
          // Text('Default'),
          // //////
          // Divider(),
          // TextButton(
          //   onPressed: () {
          //     setState(() {
          //       n = 1;
          //     });
          //   },
          //   child: Text('显示动画'),
          // ),
          // AnimatedOpacity(
          //   opacity: n,
          //   duration: Duration(seconds: 3),
          //   child: Column(
          //     // ignore: prefer_const_literals_to_create_immutables
          //     children: [
          //       Text('Type: Owl'),
          //       Text('Age: 39'),
          //       Text('Employment: None'),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  void uploadFile() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (value == 1) {
          timer.cancel();
        } else {
          value = value + 0.2;
        }
      });
    });
  }
}

// class _ExampleAsyncAwiteState extends State<ExampleAsyncAwite> {
//   ///获取读取的信息
//   var _sysinfo = '';
//   @override
//   void initsetState() {
//     Future.delayed(
//       Duration.zero,
//       () async {
//         _sysinfo = await getinfo();
//         print("sysinfo ==> $_sysinfo");
//         setState(() {
//           _sysinfo;
//         });
//       },
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           const Text("example async"),
//           // OutlinedButton(
//           //     onPressed: () async {
//           //       await getinfo();
//           //     },
//           //     child: Text('btn')),
//           Text(_sysinfo),
//         ],
//       ),
//     );
//   }
// }

///读取系统信息
Future<String> getinfo() async {
  String sysinfo = '';
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isLinux) {
    LinuxDeviceInfo linux = await deviceInfo.linuxInfo;
    sysinfo = linux.prettyName;
    // print("Running on $sysinfo");
  } else if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // print('Running on ${androidInfo.model}');

    final wifi = NetworkInfo();
    // var wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    var wifiIP = await wifi.getWifiIP(); // 192.168.1.1
    var wifiName = await wifi.getWifiName(); // FooNetwork
    List listinfo = [];
    listinfo.addAll(
      [
        androidInfo.model.toString(),
        wifiName.toString(),
        wifiIP.toString(),
      ],
    );
    sysinfo = sprintf("%s\nWiFiNAme: %s\n Addr: %s\n", listinfo);
    // print("sysinfo ===$_sysinfo");
  }
  return sysinfo;
}
