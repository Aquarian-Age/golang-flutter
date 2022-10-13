import 'dart:io';

import 'package:custom_widget/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

const double windowWidth = 800;
const double windowHeight = 800;
void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

void main() {
  setupWindow();
  runApp(
    ClockPage(),
  );
}
