import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  test('is able to parse .txt documents for trip and driver data', () async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File testFile = File('$appDocDir/testFile.txt');

    if (!await testFile.exists()) {
      await testFile.writeAsString('''
        Driver Dan\n
        Driver Lauren\n
        Driver Kumi\n
        Trip Dan 07:15 07:45 17.3\n
        Trip Dan 06:12 06:32 21.8\n
        Trip Lauren 12:01 13:16 42.0\n
      ''');
    }
  });
}
