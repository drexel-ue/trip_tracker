import 'package:file_picker/file_picker.dart';
import 'package:rxdart/subjects.dart';
import 'package:trip_tracker/events/file_event.dart';

export 'package:trip_tracker/events/file_event.dart';

class FileBloc {
  String _filename;

  final _filenameSubject = BehaviorSubject<String>();
  Stream<String> get filenameStream => _filenameSubject.stream;

  final eventSubject = BehaviorSubject<FileEvent>();

  FileBloc() {
    eventSubject.listen((FileEvent event) {
      if (event is SelectFile) _onSelectFile();
    });
  }

  void _onSelectFile() async {
    final _file = await FilePicker.getFile(
      type: FileType.CUSTOM,
      fileExtension: 'txt',
    );

    _filename = _file.path.split('/').last;

    _filenameSubject.add(_filename);
  }

  dispose() {
    _filenameSubject?.drain();
    eventSubject?.drain();
  }
}
