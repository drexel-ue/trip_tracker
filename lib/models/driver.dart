import 'package:trip_tracker/models/trip.dart';

class Driver {
  Driver(this._name);

  String _name;
  List<Trip> _trips = [];
  int distanceTraveled = 0;
  int timeTaken = 0;
  int get avgSpeed => timeTaken == 0
      ? 0
      : (distanceTraveled.toDouble() /
              (timeTaken / Duration.millisecondsPerHour.toDouble()))
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
    timeTaken = tallyTimes();
  }
}
