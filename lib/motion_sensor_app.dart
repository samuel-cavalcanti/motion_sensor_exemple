import 'package:flutter/material.dart';

import 'home_page.dart';

class MotionSensorApp extends StatelessWidget {
  const MotionSensorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motion Sensor Exemple',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Motion Sensor Exemple'),
    );
  }
}
