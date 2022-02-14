import 'package:flutter/material.dart';

import 'package:motion_sensor_exemple/motion_sensor_text.dart';

import 'package:provider/provider.dart';
import 'components/motion_container.dart';
import 'components/record_button.dart';
import 'record_imu.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RecordIMU record = context.read();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(title),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
                flex: 3,
                child: MotionContainer(
                  name: 'Accelerometer',
                  child: Column(
                    children: [
                      MotionSensorText(motionEvents: record.accelerometerSteam),
                      const Text('Filtered'),
                      MotionSensorText(
                        motionEvents: record.withoutGravityAccelerometerStream,
                      ),
                    ],
                  ),
                )),
            Flexible(
              flex: 3,
              child: MotionContainer(
                name: 'Gyroscope',
                child: MotionSensorText(
                  motionEvents: record.gyroscopeSteam,
                ),
              ),
            ),
            const Flexible(flex: 1, child: RecordButton())
          ],
        ),
      ),
    );
  }
}
