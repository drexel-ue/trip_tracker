import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_tracker/blocs/file_bloc.dart';
import 'package:trip_tracker/views/home.dart';

void main() => runApp(
      Provider(
        builder: (BuildContext context) => FileBloc(),
        dispose: (BuildContext context, FileBloc fileBloc) =>
            fileBloc.dispose(),
        child: MaterialApp(
          title: 'Trip Tracker',
          home: MyHomePage(),
        ),
      ),
    );
