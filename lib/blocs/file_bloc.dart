import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:rxdart/subjects.dart';
import 'package:trip_tracker/events/file_event.dart';

export 'package:trip_tracker/events/file_event.dart';

class FileBloc {
  File selectedFile;

  final _fileSubject = BehaviorSubject<File>();
  Stream<File> get fileStream => _fileSubject.stream;

  final eventSubject = BehaviorSubject<FileEvent>();

  FileBloc() {
    eventSubject.listen((FileEvent event) {});
  }

  void _onSelectFile() async {
    final _file = await FilePicker.getFile(
      type: FileType.CUSTOM,
      fileExtension: '.txt',
    );

    selectedFile = _file;

    _fileSubject.add(_file);
  }

  dispose() {
    _fileSubject?.drain();
    eventSubject?.drain();
  }
}
