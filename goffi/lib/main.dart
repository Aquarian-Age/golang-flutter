import 'dart:ffi';
import 'dart:io';

//import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';

void main() {
  // runApp(const MyApp());
  runApp(const FFiExample());
}

class FFiExample extends StatefulWidget {
  const FFiExample({super.key});

  @override
  State<FFiExample> createState() => _FFiExampleState();
}

//add
typedef GoLibAdd = Int32 Function(Int32 a, Int32 b, Int32 c);
typedef DarFuncAdd = int Function(int a, int b, int c);

//
class _FFiExampleState extends State<FFiExample> {
  String strs = '';

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      final DynamicLibrary dylib = Platform.isIOS
          ? DynamicLibrary.open('golibsimulator.dylib')
          : DynamicLibrary.process();

      ///
      var addf = dylib.lookupFunction<GoLibAdd, DarFuncAdd>("add");
      var addx = addf(11, 11, 11);
      var strs = addx.toInt();
      print("add ==> $strs");
    }

    //
    return MaterialApp(
      title: 'Flutter dark:ffi Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
            child: Column(
          children: [
            const Text(
              "ffi libgo",
              style: TextStyle(fontSize: 26),
            ),
            OutlinedButton(
                onPressed: () {
                  print("object btn on clicked $strs");

                  setState(() {
                    strs;
                  });
                },
                child: const Text("btn")),
            // Text(strs)
            Text(strs)
          ],
        )),
      ),
    );
  }
}

//typedef GoLibGets = Pointer<Utf8> Function();
//typedef DarkFuncGets = Pointer<Utf8> Function();

//
//typedef GoLibTimes = Pointer<Utf8> Function(Pointer<Utf8> times, Int32 star, Int32 door);
//typedef DarkFuncTimes = Pointer<Utf8> Function(Pointer<Utf8> times, int star, int door);

//
//typedef GoLibType = Pointer<Utf8> Function(Pointer<Utf8> str);
//typedef DarkFuncType = Pointer<Utf8> Function(Pointer<Utf8> str);