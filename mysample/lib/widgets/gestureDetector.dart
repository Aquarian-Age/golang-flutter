import 'package:flutter/material.dart';

// https://api.flutter-io.cn/flutter/widgets/GestureDetector-class.html
class ExampleGestureDetector extends StatelessWidget {
  const ExampleGestureDetector({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool _lightIsOn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.lightbulb_outline,
              color: _lightIsOn ? Colors.yellow.shade600 : Colors.black,
              size: 60,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                // Toggle light when tapped.
                _lightIsOn = !_lightIsOn;
              });
            },
            child: Container(
              color: Colors.yellow.shade600,
              padding: const EdgeInsets.all(8),
              // Change button text when light changes state.
              child: Text(_lightIsOn ? 'TURN LIGHT OFF' : 'TURN LIGHT ON'),
            ),
          ),
        ],
      ),
    );
  }
}
