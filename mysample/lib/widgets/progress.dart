import 'package:flutter/material.dart';
import 'package:progresso/progresso.dart';

class ExampleProgeress extends StatefulWidget {
  const ExampleProgeress({super.key});

  @override
  State<ExampleProgeress> createState() => _ExampleProgeressState();
}

class _ExampleProgeressState extends State<ExampleProgeress> {
  Stream<double> tick() {
    return Stream<double>.periodic(const Duration(milliseconds: 100), (x) {
      return x / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text(widget.title),
          ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Basic Progress"),
            SizedBox(height: 10),
            Progresso(progress: 0.5),
            SizedBox(height: 20),
            Text("Points along line"),
            SizedBox(height: 10),
            Progresso(progress: 0.5, points: [0.1, 0.2, 0.4]),
            SizedBox(height: 20),
            Text("non-zero start position"),
            SizedBox(height: 10),
            Progresso(start: 0.3, progress: 0.5),
            SizedBox(height: 20),
            Text("Custom colors"),
            SizedBox(height: 10),
            Progresso(progress: 0.5, progressColor: Colors.red, backgroundColor: Colors.lightBlue),
            SizedBox(height: 20),
            Text("Line widths"),
            SizedBox(height: 10),
            Progresso(progress: 0.5, progressStrokeWidth: 20, backgroundStrokeWidth: 20),
            SizedBox(height: 20),
            Text("point size"),
            SizedBox(height: 10),
            Progresso(progress: 0.5, pointInnerRadius: 0, pointRadius: 10, points: [0.1, 0.2, 0.4]),
            SizedBox(height: 20),
            Text("Line caps"),
            SizedBox(height: 10),
            Progresso(progress: 0.5, progressStrokeCap: StrokeCap.round, backgroundStrokeCap: StrokeCap.round),
            SizedBox(height: 20),
            Text("Point color"),
            SizedBox(height: 10),
            Progresso(progress: 0.5, points: [0.1, 0.2, 0.4], pointColor: Colors.red, pointInnerColor: Colors.black),
            SizedBox(height: 20),
            Text("stream progress"),
            SizedBox(height: 10),
            // StreamBuilder(
            //     stream: tick(),
            //     builder: (_, AsyncSnapshot<double> snapshot) {
            //       if (snapshot.hasData) {
            //         return Progresso(progress: snapshot.data);
            //       } else {
            //         return Progresso();
            //       }
            //     }),
            SizedBox(height: 20),
          ],
        ),
      )),
    );
  }
}
