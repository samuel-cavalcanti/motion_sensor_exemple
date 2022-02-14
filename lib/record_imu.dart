import 'dart:async';
import 'dart:io';
import 'package:async/async.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'high_pass_filter.dart';

enum RecordingState {
  record,
  recording,
}

class RecordIMU {
  final _highpassFilter = HighPassFilter();
  late final Stream<List<double>> accelerometerSteam;
  late final Stream<List<double>> withoutGravityAccelerometerStream;
  late final Stream<List<double>> gyroscopeSteam;
  late final StreamSubscription<List<List<double>>> _recordSub;
  late double _startTime;
  final List<List<double>> _imuData = [];
  RecordingState _recordState = RecordingState.record;

  RecordingState get state => _recordState;

  RecordIMU() {
    _startTime = DateTime.now().microsecondsSinceEpoch.toDouble();

    accelerometerSteam = accelerometerEvents
        .asyncMap((event) => <double>[event.x, event.y, event.z]);

    withoutGravityAccelerometerStream =
        accelerometerSteam.asyncMap((event) => _highpassFilter.filter(event));

    gyroscopeSteam = gyroscopeEvents
        .asyncMap((event) => <double>[event.x, event.y, event.z]);

    _recordSub = StreamZip([withoutGravityAccelerometerStream, gyroscopeSteam])
        .listen((event) {
      final currentTime =
          DateTime.now().microsecondsSinceEpoch.toDouble() - _startTime;
      _record(event[0], event[1], currentTime);
    });

    _recordSub.pause();
    _imuData.clear();

    // print('record as setted $_recordSub');
  }

  void _record(List<double> accelerometerEvent, List<double> gyroscopeEvent,
      double currentTimeInMillisecond) {
    // print(
    //     'events: $accelerometerEvent $gyroscopeEvent $currentTimeInMillisecond ');
    final all = [
      ...accelerometerEvent,
      ...gyroscopeEvent,
      currentTimeInMillisecond
    ];
    _imuData.add(all);
  }

  void changeRecordState() {
    // print('change record state');
    switch (_recordState) {
      case RecordingState.record:
        _recordState = RecordingState.recording;
        _startTime = DateTime.now().microsecondsSinceEpoch.toDouble();
        _recordSub.resume();
        return;
      case RecordingState.recording:
        _recordState = RecordingState.record;
        _recordSub.pause();
        _save();
        return;
    }
  }

  void _save() async {
    // print('trying to save');
    if (_imuData.isEmpty) {
      return;
    }

    String content = '';

    for (final sample in _imuData) {
      content += '${sample[0]}';
      for (var index = 1; index < sample.length; index++) {
        content += ',${sample[index]}';
      }
      content += '\n';
    }

    // print('content: $content');

    _imuData.clear();

    final dir = await getExternalStorageDirectory();

    // print('dir: $dir');

    if (dir == null) return;

    final file = File('${dir.path}/data.csv');

    file.writeAsStringSync(content);
  }
}
