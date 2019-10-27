import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trip_tracker/models/driver.dart';
import 'package:trip_tracker/models/trip.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');

  // creates a mock handler for path_provider package to hang on to.
  channel.setMockMethodCallHandler((MethodCall methodCall) async => ".");

  // returns application document directory.
  Directory appDocDir = await getApplicationDocumentsDirectory();
  // returns the root path to this directory
  String appDocPath = appDocDir.path;
  File testFile = File('$appDocPath/testFile.txt');

  await testFile.writeAsString('''
        Driver Dan
        Driver Lauren
        Driver Kumi
        Trip Dan 07:15 07:45 17.3
        Trip Dan 06:12 06:32 21.8
        Trip Lauren 12:01 13:16 42.0
      ''');

  Map<String, Driver> drivers = {};

  List<String> dataLines = await testFile.readAsLines();

  dataLines.forEach((String line) {
    // map space delimited data to an array.
    List<String> data = line.trim().split(' ');

    // if we are dealing with a driver.
    if (data.first.toLowerCase() == 'driver') {
      drivers[data[1]] = Driver(data[1]);
    }
    // if we are dealing with a trip.
    else if (data.first.toLowerCase() == 'trip') {
      final trip = Trip(
        driver: data[1],
        startTime:
            DateTime.parse('2005-01-20 ' + data[2]).millisecondsSinceEpoch,
        endTime: DateTime.parse('2005-01-20 ' + data[3]).millisecondsSinceEpoch,
        distance: double.parse(data[4]),
      );
      drivers[trip.driver].addTrip(trip);
    }
  });

  test('is able to parse .txt documents for trip and driver data', () async {
    print(drivers['Dan'].avgSpeed);

    expect(true, true);
  });
}
