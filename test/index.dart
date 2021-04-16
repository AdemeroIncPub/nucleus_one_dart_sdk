import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'integration/index.dart' as integration_tests;
import 'unit/index.dart' as unit_tests;

void main() {
  _deleteExistingCoverageOutput();

  _registerMocktailFallbackValues();

  unit_tests.main();
  integration_tests.main();
}

/// Delete the existing "coverage" directory prior to running any tests.  This alleviates the issue
/// of incorrect coverage results when only running partial tests.
void _deleteExistingCoverageOutput() {
  try {
    if (Directory.current.path.endsWith('nucleus_one_dart_sdk')) {
      Directory(Directory.current.path + '/coverage').deleteSync(recursive: true);
    }
  } catch (e) {
    print(
        'WARNING: Error deleting existing "coverage" folder.  Coverage results may be inaccurate.\r\n$e');
  }
}

/// Registers global fallback values, for *all* tests being run.
void _registerMocktailFallbackValues() {
  setUpAll(() {
    registerFallbackValue<Uri>(Uri());
  });
}
