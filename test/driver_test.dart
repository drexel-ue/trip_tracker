import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tracker/models/driver.dart';

void main() {
  final driver = Driver('Crash Test Dummy');

  test('drivers are initialized with a name.', () {
    expect(driver.name == 'Crash Test Dummy', true);
  });

  test('drivers are initialized with no trips.', () {
    expect(driver.tripCount == 0, true);
  });
}
