import 'package:trip_tracker/models/trip.dart';

class Driver {
  Driver({this.name});

  String name;
  List<Trip> trips = [];
  int get distanceTraveled => tallyDistances();
  int get timeTaken => tallyTimes();
  int get avgSpeed => (tallyDistances() / tallyTimes()).round();

  int tallyDistances() {
    double total = 0;
    trips.forEach((Trip trip) => total += trip.distance);
    return total.round();
  }

  int tallyTimes() {
    int total = 0;
    trips.forEach((Trip trip) => total += (trip.endTime = trip.startTime));
    return total;
  }
}
