import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Tracker',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: const Text(
                  'ex: selected_file.txt',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.white,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
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
