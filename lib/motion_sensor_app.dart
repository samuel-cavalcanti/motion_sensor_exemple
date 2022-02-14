import 'package:flutter/material.dart';
import 'package:motion_sensor_exemple/controllers/recording_text_controller.dart';
import 'package:motion_sensor_exemple/record_imu.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class MotionSensorApp extends StatelessWidget {
  const MotionSensorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motion Sensor Exemple',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(providers: [
        Provider(create: (_) => RecordIMU()),
        Provider(create: (context) => RecordTextController(context.read()))
      ], child: HomePage(title: 'Motion Sensor Exemple')),
    );
  }
}
