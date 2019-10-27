import 'package:trip_tracker/models/trip.dart';

class Driver {
  Driver(this._name);

  String _name;
  String get name => _name;
  List<Trip> _trips = [];
  int distanceTraveled = 0;
  int driveTime = 0;
  String get tripStatement => sumItUp();
  int get tripCount => _trips.length;
  int get avgSpeed => driveTime == 0
      ? 0
      : (distanceTraveled.toDouble() /
              (driveTime / Duration.millisecondsPerHour.toDouble()))
          .round();

  int tallyDistances() {
    double total = 0;
    _trips.forEach((Trip trip) {
      total += trip.distance;
    });
    return total.round();
  }

  int tallyTimes() {
    int total = 0;
    _trips.forEach((Trip trip) {
      total += (trip.endTime - trip.startTime);
    });
    return total;
  }

  void addTrip(Trip trip) {
    _trips.add(trip);
    distanceTraveled = tallyDistances();
    driveTime = tallyTimes();
  }

  String sumItUp() {
    if (distanceTraveled == 0) return '$_name: 0';
    return '$_name: $distanceTraveled miles @ $avgSpeed mph';
  }
}
