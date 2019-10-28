import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:rxdart/subjects.dart';
import 'package:trip_tracker/events/file_event.dart';
import 'package:trip_tracker/models/driver.dart';
import 'package:trip_tracker/models/trip.dart';

export 'package:trip_tracker/events/file_event.dart';

class FileBloc {
  //  name of the currently selected file.
  String _filename;
  // hash map to hold all parsed drivers.
  Map<String, Driver> _drivers = {};

  final _filenameSubject = BehaviorSubject<String>();
  Stream<String> get filenameStream => _filenameSubject.stream;

  final eventSubject = BehaviorSubject<FileEvent>();

  FileBloc() {
    eventSubject.listen((FileEvent event) {
      if (event is SelectFile) _onSelectFile();
    });
  }

  void _onSelectFile() async {
    final _file = await FilePicker.getFile(
      type: FileType.CUSTOM,
      fileExtension: 'txt',
    );

    _filename = _file.path.split('/').last;

    _filenameSubject.add(_filename);
  }

  void _distributeParsedData(File file) async {
    // list of lines read from the inputFile.
    List<String> dataLines = await file.readAsLines();

    // let's handle each line.
    dataLines.forEach((String line) {
      // map space delimited data to an array.
      final List<String> data = line.trim().split(' ');

      // if we are dealing with a driver.
      if (data.first.toLowerCase() == 'driver')
        // key the driver object to the driver's name in the driver hash map.
        // this is assuming the name is always formatted the same and there
        // are only ever first names. extra precautions would not be hard to
        // implement. but, this is a simple demonstration.
        _drivers[data[1]] = Driver(data[1]);
      // if we are dealing with a trip.
      else if (data.first.toLowerCase() == 'trip') {
        final trip = Trip(
          driver: data[1],
          startTime:
              // as all drives are completed on the same day, the calendar
              // date does not matter. a default calendar date is provided
              // for the following parsing method to latch on to.
              DateTime.parse('2005-01-20 ' + data[2]).millisecondsSinceEpoch,
          endTime:
              DateTime.parse('2005-01-20 ' + data[3]).millisecondsSinceEpoch,
          distance: double.parse(data[4]),
        );

        // add the trip to the appropriate driver's list of trips.
        _drivers[trip.driver].addTrip(trip);
      }
    });

    List<String> _outputList = [];

    final List<Driver> driverList = _drivers.values.toList();
    driverList.sort((Driver driverA, Driver driverB) =>
        driverB.distanceTraveled - driverA.distanceTraveled);
    driverList.forEach((Driver driver) {
      _outputList.add(driver.tripStatement);
    });
  }

  dispose() {
    _filenameSubject?.drain();
    eventSubject?.drain();
  }
}
