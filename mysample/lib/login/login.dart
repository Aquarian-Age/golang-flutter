import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysample/login/page.dart';

// 客户端登陆
Future<bool> checkLogin(String url, String input) async {
  const localhost = "http://localhost:8989";
  if (url == "") {
    url = "$localhost/login";
  } else {
    url = "$url/login";
  }
  // url == "" ? localhost : url;
  final respones = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'login': input,
    }),
  );

  //服务器返回来的数据
  if (respones.statusCode == 200) {
    Map<String, dynamic> auth = jsonDecode(respones.body);
    var b = auth['auth'];
    return b;
  }
  return false;
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String url = 'http://localhost:8989';
  String passwd = '';
  void login() async {
    bool b = await checkLogin(url, passwd);
    b == true
        // ignore: use_build_context_synchronously
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyPage(url),
            ),
          )
        : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: ListView(
        children: [
          TextFormField(
            style: const TextStyle(color: Colors.red, fontSize: 16),
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'http://localhost:6714/login'),
            autofocus: true,
            onChanged: (value) async => url = value.toString(),
          ),
          TextFormField(
            style: const TextStyle(color: Colors.red, fontSize: 16),
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'passwd'),
            autofocus: true,
            onChanged: (value) async => passwd = value.toString(),
          ),
          Row(
            children: [
              Expanded(
                  child: OutlinedButton(
                onPressed: () async {
                  login();
                },
                child: const Text('login'),
              ))
            ],
          )
        ],
      ),
    );
  }
}
