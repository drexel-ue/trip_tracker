import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tracker/models/driver.dart';
import 'package:trip_tracker/models/trip.dart';

void main() {
  final driver = Driver('Crash Test Dummy');

  test('drivers are initialized with a name.', () {
    expect(driver.name == 'Crash Test Dummy', true);
  });

  test('drivers are initialized with no trips.', () {
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
    expect(driver.tripCount == 0, true);

    driver.addTrip(trip1);
    expect(driver.tripCount == 1, true);

    driver.addTrip(trip2);
    expect(driver.tripCount == 2, true);
  });

  test('total distance driven increments when a new trip is added.', () {
    final driver = Driver('Crash Test Dummy');

    expect(driver.tripCount == 0, true);

    driver.addTrip(trip1);
    expect(driver.distanceTraveled == 17, true);

    driver.addTrip(trip2);
    expect(driver.distanceTraveled == 39, true);
  });
}
