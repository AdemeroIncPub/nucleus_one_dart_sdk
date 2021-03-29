import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'integration/index.dart' as integration_tests;
import 'unit/index.dart' as unit_tests;

void main() {
  registerMocktailFallbackValues();

  unit_tests.main();
  integration_tests.main();
}

/// Registers global fallback values, for *all* tests being run.
void registerMocktailFallbackValues() {
  setUpAll(() {
    registerFallbackValue<Uri>(Uri());
  });
}
