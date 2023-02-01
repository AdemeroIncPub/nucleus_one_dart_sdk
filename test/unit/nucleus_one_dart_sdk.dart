import 'dart:io';
import 'dart:mirrors';

// import 'package:file/file.dart' as file;
// import 'package:file/local.dart' as file;

import 'package:test/test.dart';

void main() {
  group('NucleusOne Dart SDK tests', () {
    test('Class export tests', () {
      final regex = RegExp('(export \')([^\']+)(\')( (?:show|hide) [^;]+)?(;)');

      final mirrorSystem = currentMirrorSystem();
      final modelFilePaths = <String>[];

      const modelClassFileStart = 'package:nucleus_one_dart_sdk/src/model/';
      for (var l in mirrorSystem.libraries.entries) {
        final packageFilePath = l.key.toString();

        // Exclude support_* files.  These are not currently intended for export.
        if (packageFilePath.startsWith(modelClassFileStart) &&
            !packageFilePath.startsWith('${modelClassFileStart}support_')) {
          modelFilePaths.add(packageFilePath.substring(modelClassFileStart.length - 10));
        }
      }

      final fileText = File('lib/nucleus_one_dart_sdk.dart').readAsStringSync();

      for (var line in regex.allMatches(fileText)) {
        final filePath = line.group(2)!;
        modelFilePaths.remove(filePath);
      }

      if (modelFilePaths.isNotEmpty) {
        final errMsg = 'The following files are not exported:\n  ${modelFilePaths.join('\n  ')}';
        fail(errMsg);
      }
    });
  });
}
