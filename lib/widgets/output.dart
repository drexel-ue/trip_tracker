import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_tracker/blocs/file_bloc.dart';

class Output extends StatelessWidget {
  const Output({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fileBloc = Provider.of<FileBloc>(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        child: StreamBuilder<List<String>>(
          stream: fileBloc.outputStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData)
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    snapshot.data[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            return Container();
          },
        ),
      ),
    );
  }
}
