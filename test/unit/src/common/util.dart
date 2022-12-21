import 'package:nucleus_one_dart_sdk/src/common/util.dart' as util;
import 'package:test/test.dart';

void main() async {
  group('StreamHandling class tests', () {
    test('readToEnd method test', () async {
      final expected = '1234567890';
      final streamPartsAsInts = _convertStringToAsciiIntList(expected);

      final s = await Stream.value(streamPartsAsInts).readToEnd();
      expect(s, expected);
    });
  });
}

List<int> _convertStringToAsciiIntList(String streamParts) =>
    streamParts.split('').map((x) => x.codeUnitAt(0)).toList();
