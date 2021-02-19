import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    // NucleusOne n1;

    setUp(() {
      GetIt.I.registerSingleton<NucleusOneApp>(NucleusOneAppUninitialized());
    });

    tearDown(() {
      // Unregister the singleton, so that this can be reinitialized later
      GetIt.I.unregister<NucleusOneApp>(instance: NucleusOne.app());
    });

    test('Uninitialized NucleusOne app', () {
      final n1App = NucleusOne.app();
      expect(n1App, isA<NucleusOneAppUninitialized>());
    });

    test('Initialized NucleusOne app', () {
      final n1App = NucleusOne.initializeApp(
        options: NucleusOneOptions(baseUrl: 'https://steve.com/'),
      );
      expect(n1App, isNotNull);
    });
  });
}
