import 'package:motion_sensor_exemple/record_imu.dart';

class RecordTextController {
  final RecordIMU record;

  RecordTextController(this.record);

  String get text =>
      record.state == RecordingState.record ? 'Record' : 'Recording';

  void changeRecordState() => record.changeRecordState();
}
