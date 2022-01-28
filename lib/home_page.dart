import 'package:flutter/material.dart';
import 'package:motion_sensor_exemple/high_pass_filter.dart';

import 'package:motion_sensor_exemple/motion_sensor_text.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomePage extends StatelessWidget {
  final String title;
  final _highpassFilter = HighPassFilter();
  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(title),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: MotionContainer(
              name: 'Accelerometer',
              child: Column(
                children: [
                  MotionSensorText(
                      motionEvents: accelerometerEvents.asyncMap(
                          (event) => <double>[event.x, event.y, event.z])),
                  const Text('Filtered'),
                  MotionSensorText(
                      motionEvents: accelerometerEvents.asyncMap((event) =>
                          _highpassFilter
                              .filter(<double>[event.x, event.y, event.z]))),
                ],
              ),
            )),
            Expanded(
              child: MotionContainer(
                name: 'Gyroscope',
                child: MotionSensorText(
                    motionEvents: gyroscopeEvents.asyncMap(
                        (event) => <double>[event.x, event.y, event.z])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MotionContainer extends StatelessWidget {
  const MotionContainer({required this.name, required this.child, Key? key})
      : super(key: key);
  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(name), child],
        ),
      ),
    );
  }
}
