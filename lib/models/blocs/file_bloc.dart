import 'package:rxdart/subjects.dart';
import 'package:trip_tracker/models/events/file_event.dart';

export 'package:trip_tracker/models/events/file_event.dart';

class FileBloc {
  final eventSubject = BehaviorSubject<FileEvent>();

  FileBloc() {
    eventSubject.listen((FileEvent event) {});
  }

  dispose() {
    eventSubject?.drain();
  }
}
