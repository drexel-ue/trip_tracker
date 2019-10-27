import 'package:flutter/material.dart';

class Trip {
  Trip({this.driver, this.startTime, this.endTime, this.distance});

  String driver;
  TimeOfDay startTime;
  TimeOfDay endTime;
  double distance;
}
