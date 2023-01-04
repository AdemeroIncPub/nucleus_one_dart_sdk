import 'package:nucleus_one_dart_sdk/src/common/validation.dart' as validation;
import 'package:test/test.dart';

void main() {
  group('Validation tests', () {
    test('ensureArgumentIsNotEmpty method test', () {
      try {
        validation.ensureArgumentIsNotEmpty(argumentName: 'A', argumentValue: '');
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'A');
      }

      try {
        validation.ensureArgumentIsNotEmpty(argumentName: 'A', argumentValue: '1');
      } on ArgumentError {
        fail('ArgumentError should not have been thrown for non-empty value.');
      }
    });
  });
}
