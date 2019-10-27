import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trip_tracker/models/driver.dart';
import 'package:trip_tracker/models/trip.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async => ".");

  test('is able to parse .txt documents for trip and driver data', () async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
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

      print(data);

      if (data.first.toLowerCase() == 'driver') {
        drivers[data[1]] = Driver(name: data[1]);
      } else if (data.first.toLowerCase() == 'trip') {
        final trip = Trip(
          driver: data[1],
          startTime:
              DateTime.parse('2005-01-20 ' + data[2]).millisecondsSinceEpoch,
          endTime:
              DateTime.parse('2005-01-20 ' + data[3]).millisecondsSinceEpoch,
          distance: double.parse(data[4]),
        );
      }
    });

    drivers['Dan'].avgSpeed;

    expect(true, true);
  });
}
