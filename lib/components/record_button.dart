import 'package:flutter/material.dart';
import 'package:motion_sensor_exemple/controllers/recording_text_controller.dart';

import 'package:provider/provider.dart';

class RecordButton extends StatefulWidget {
  const RecordButton({Key? key}) : super(key: key);

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  @override
  Widget build(BuildContext context) {
    final RecordTextController controller = context.read();
    
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
      child: Text(controller.text),
      onPressed: () => setState(() {
        controller.changeRecordState();
      }),
    );
  }
}
