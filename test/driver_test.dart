import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tracker/models/driver.dart';
import 'package:trip_tracker/models/trip.dart';

void main() {
  test('drivers are initialized with a name.', () {
    final driver = Driver('Crash Test Dummy');

    expect(driver.name == 'Crash Test Dummy', true);
  });

  test('drivers are initialized with no trips.', () {
    final driver = Driver('Crash Test Dummy');

    expect(driver.tripCount == 0, true);
  });

  final trip1 = Trip(
    driver: 'Crash Test Dummy',
    startTime: DateTime(2017, 9, 7, 7, 15).millisecondsSinceEpoch,
    endTime: DateTime(2017, 9, 7, 7, 45).millisecondsSinceEpoch,
    distance: 17.3,
  );

  final trip2 = Trip(
    driver: 'Crash Test Dummy',
    startTime: DateTime(2017, 9, 7, 6, 12).millisecondsSinceEpoch,
    endTime: DateTime(2017, 9, 7, 6, 32).millisecondsSinceEpoch,
    distance: 21.8,
  );

  test('drivers are able to add trips.', () {
    final driver = Driver('Crash Test Dummy');

    expect(driver.tripCount == 0, true);

    driver.addTrip(trip1);
    expect(driver.tripCount == 1, true);

    driver.addTrip(trip2);
    expect(driver.tripCount == 2, true);
  });

  test('total distance driven increments when a new trip is added.', () {
    final driver = Driver('Crash Test Dummy');

    expect(driver.distanceTraveled == 0, true);

    driver.addTrip(trip1);
    expect(driver.distanceTraveled == 17, true);

    driver.addTrip(trip2);
    expect(driver.distanceTraveled == 39, true);
  });

  test('total time driven increments when a new trip is added.', () {
    final driver = Driver('Crash Test Dummy');

    expect(driver.driveTime == 0, true);

    driver.addTrip(trip1);
    expect(driver.driveTime / Duration.millisecondsPerMinute == 30, true);

    driver.addTrip(trip2);
    expect(driver.driveTime / Duration.millisecondsPerMinute == 50, true);
  });

  test('able to correctly state distance driven and average speed.', () {
    final driver = Driver('Crash Test Dummy');

    expect(driver.tripStatement == 'Crash Test Dummy: 0', true);
    driver.addTrip(trip1);
    driver.addTrip(trip2);
    expect(driver.tripStatement == 'Crash Test Dummy: 39 miles @ 47 mph', true);
  });
}
