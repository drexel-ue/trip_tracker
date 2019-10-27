import 'package:trip_tracker/models/trip.dart';

class Driver {
  Driver({this.name});

  String name;
  List<Trip> trips = [];
  int get distanceTraveled => tallyDistances();
  int get timeTaken => tallyTimes();
  int avgSpeed = 0;

  int tallyDistances() {
    double total = 0;
    trips.forEach((Trip trip) => total += trip.distance);
    return total.round();
  }
}
