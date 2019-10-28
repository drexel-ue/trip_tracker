class Trip {
  // contstructor function.
  Trip({this.driver, this.startTime, this.endTime, this.distance});

  // name of driver that took the trip.
  String driver;
  // start time of trip in milliseconds since epoch.
  int startTime;
  // end time of trip in milliseconds since epoch.
  int endTime;
  // recorded distance of trip.
  double distance;
}
