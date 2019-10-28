import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:trip_tracker/blocs/file_bloc.dart';
import 'package:trip_tracker/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    // returns application document directory.
    Directory phoneDocDir = await getExternalStorageDirectory();
    // returns the root path to this directory.
    String phoneDocPath = phoneDocDir.path;
    // variable pointing to the input file for testing.
    File inputFile = File('$phoneDocPath/inputFile.txt');

    // if the inputFile already exists, no need to write to it.
    if (!await inputFile.exists()) await inputFile.writeAsString('''
        Driver Dan
        Driver Lauren
        Driver Kumi
        Trip Dan 07:15 07:45 17.3
        Trip Dan 06:12 06:32 21.8
        Trip Lauren 12:01 13:16 42.0
      ''');
  }

  runApp(
    Provider(
      builder: (BuildContext context) => FileBloc(),
      dispose: (BuildContext context, FileBloc fileBloc) => fileBloc.dispose(),
      child: MaterialApp(
        title: 'Trip Tracker',
        home: MyHomePage(),
      ),
    ),
  );
}
