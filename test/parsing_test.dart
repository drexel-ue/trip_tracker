import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trip_tracker/models/driver.dart';
import 'package:trip_tracker/models/trip.dart';

void main() {
  // hash map to hold all parsed drivers.
  Map<String, Driver> drivers = {};

  // sets up the environment that will be used in all tests.
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();

    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/path_provider');

    // creates a mock handler for path_provider package to hang on to.
    // in this case, returning '.' to make the app document directory
    // point to the top of the test folder.
    channel.setMockMethodCallHandler((MethodCall methodCall) async => ".");

    // returns application document directory.
    Directory appDocDir = await getApplicationDocumentsDirectory();
    // returns the root path to this directory.
    String appDocPath = appDocDir.path;
    // variable pointing to the input file for testing.
    File inputFile = File('$appDocPath/inputFile.txt');

    // if the inputFile already exists, no need to write to it.
    if (!await inputFile.exists()) await inputFile.writeAsString('''
        Driver Dan
        Driver Lauren
        Driver Kumi
        Trip Dan 07:15 07:45 17.3
        Trip Dan 06:12 06:32 21.8
        Trip Lauren 12:01 13:16 42.0
      ''');

    // list of lines read from the inputFile.
    List<String> dataLines = await inputFile.readAsLines();

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
        drivers[data[1]] = Driver(data[1]);
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
        drivers[trip.driver].addTrip(trip);
      }
    });
  });

  test('is able to parse .txt documents for trip and driver data.', () {
    final dan = drivers['Dan'];
    final speed = dan.avgSpeed;
    final trips = dan.tripCount;
    expect(speed == 47 && trips == 2, true);
  });

  test('is able to format parsed data into desired format.', () {
    String outputString = '';

    final List<Driver> driverList = drivers.values.toList();
    driverList.sort((Driver driverA, Driver driverB) =>
        driverB.distanceTraveled - driverA.distanceTraveled);
    driverList.forEach((Driver driver) {
      outputString += driver.tripStatement + '\n';
    });

    debugPrint(outputString);

    expect(
        outputString ==
            'Lauren: 42 miles @ 34 mph\nDan: 39 miles @ 47 mph\nKumi: 0\n',
        true);
  });
}
