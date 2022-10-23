// 显示圆形“微调器”
import 'dart:async';

import 'package:flutter/cupertino.dart';
// ignore: unnecessary_import
import 'package:flutter/material.dart';

class CupertinoIndicatorApp extends StatelessWidget {
  const CupertinoIndicatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: CupertinoIndicatorExample(),
    );
  }
}

// ignore: must_be_immutable
class CupertinoIndicatorExample extends StatelessWidget {
  CupertinoIndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoActivityIndicator Sample'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Cupertino activity indicator with default properties.
                CupertinoActivityIndicator(),
                SizedBox(height: 10),
                Text('Default'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                // Cupertino activity indicator with custom radius and color.
                CupertinoActivityIndicator(radius: 20.0, color: CupertinoColors.activeBlue),
                SizedBox(height: 10),
                Text(
                  'radius: 20.0\ncolor: CupertinoColors.activeBlue',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                // Cupertino activity indicator with custom radius and disabled animation.
                CupertinoActivityIndicator(radius: 20.0, animating: false),
                SizedBox(height: 10),
                Text(
                  'radius: 20.0\nanimating: false',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Container(
              child: TextButton(
                  child: Text('btn page'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CupertinoIndicatorExample(),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

////////////////
class ExampleCupertinoActivityIndicator extends StatefulWidget {
  const ExampleCupertinoActivityIndicator({super.key});

  @override
  State<ExampleCupertinoActivityIndicator> createState() => _ExampleCupertinoActivityIndicatorState();
}

class _ExampleCupertinoActivityIndicatorState extends State<ExampleCupertinoActivityIndicator> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(40),
        alignment: Alignment.topCenter,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            child: const Text("Upload File"),
            onPressed: () {
              value = 0;
              uploadFile();
              setState(() {});
            },
          ),
          CupertinoActivityIndicator.partiallyRevealed(
            progress: value,
            radius: 30,
          )
        ]),
      ),
    );
  }

  ///
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
