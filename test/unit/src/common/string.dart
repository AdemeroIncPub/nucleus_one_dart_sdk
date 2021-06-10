import 'package:nucleus_one_dart_sdk/src/common/string.dart' as string;
import 'package:test/test.dart';

void main() {
  group('String tests', () {
    test('isNotEmpty method test', () {
      expect(string.isNotEmpty(null), isFalse);
      expect(string.isNotEmpty(''), isFalse);
      expect(string.isNotEmpty(' '), isTrue);
      expect(string.isNotEmpty('1'), isTrue);
    });
    
    test('isNullOrEmpty method test', () {
      expect(string.isNullOrEmpty(' '), isFalse);
      expect(string.isNullOrEmpty(null), isTrue);
      expect(string.isNullOrEmpty(''), isTrue);
    });
  });
}
