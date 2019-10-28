import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_tracker/blocs/file_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fileBloc = Provider.of<FileBloc>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(72, 90, 119, 1),
      appBar: AppBar(
        title: const Text('Trip Tracker'),
        backgroundColor: const Color.fromRGBO(72, 90, 119, 1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              const Text(
                'Select Input File',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: StreamBuilder<String>(
                  initialData: 'ex: selected_file.txt',
                  stream: fileBloc.filenameStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) =>
                          Text(
                    snapshot.data,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Colors.white,
                    ),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  fileBloc.eventSubject.add(SelectFile());
                },
                color: Colors.white,
                child: Text(
                  'SELECT FILE',
                  style: TextStyle(
                    color: const Color.fromRGBO(72, 90, 119, 1),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
