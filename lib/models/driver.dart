import 'package:trip_tracker/models/trip.dart';

class Driver {
  // constructor function.
  Driver(this._name);

  // name of driver. privatized to preserve original name.
  // this pattern could be followed for many more variables,
  // but for simplicity, it was only done here to demonstrate
  // the concept.
  String _name;
  // getter for _name so it can still be viewed from outside the class.
  String get name => _name;
  // privatized list to hold all of this driver's trips.
  List<Trip> _trips = [];
  // total distance traveled across all trips.
  int distanceTraveled = 0;
  // total time spent driving across all trips.
  int driveTime = 0;
  // returns a string in format '_name: distanceTraveled miles @ avgSpeed mph'.
  String get tripStatement => sumItUp();
  // total number of trips taken by driver.
  int get tripCount => _trips.length;
  // returns the average speed across all trips,
  // or zero if no trips have been taken.
  int get avgSpeed => driveTime == 0
      ? 0
      : (distanceTraveled.toDouble() /
              (driveTime / Duration.millisecondsPerHour.toDouble()))
          .round();

  // sums up the distances of all trips and returns that sum.
  int tallyDistances() {
    double total = 0;
    _trips.forEach((Trip trip) {
      total += trip.distance;
    });
    return total.round();
  }

  // sums up the drive times of all trips and returns that sum.
  int tallyTimes() {
    int total = 0;
    _trips.forEach((Trip trip) {
      total += (trip.endTime - trip.startTime);
    });
    return total;
  }

  // adds the given trip to _trips and reevaluates distanceTraveled
  //  and driveTime using tallyDistance and tallyTime respectively.
  void addTrip(Trip trip) {
    final tripStart = trip.startTime / Duration.millisecondsPerHour.toDouble();
    final tripEnd = trip.endTime / Duration.millisecondsPerHour.toDouble();
    final avgSpeed = trip.distance / (tripEnd - tripStart);

    if (5 < avgSpeed && avgSpeed < 100) {
      _trips.add(trip);
      distanceTraveled = tallyDistances();
      driveTime = tallyTimes();
    }
  }

  // generates string returned by tripStatement.
  String sumItUp() {
    if (distanceTraveled == 0) return '$_name: 0';
    return '$_name: $distanceTraveled miles @ $avgSpeed mph';
  }
}
