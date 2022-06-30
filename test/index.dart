import 'dart:async';
import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'integration/index.dart' as integration_tests;
import 'unit/index.dart' as unit_tests;

void main() {
  _registerMocktailFallbackValues();

  unit_tests.main();
  integration_tests.main();
}

/// Registers global fallback values, for *all* tests being run.
void _registerMocktailFallbackValues() {
  setUpAll(() {
    registerFallbackValue(Uri());
    registerFallbackValue(_FakeStreamConsumer<List<int>>());
  });
}

class _FakeStreamConsumer<T> implements StreamConsumer<T> {
  @override
  Future addStream(Stream<T> stream) => throw UnimplementedError();

  @override
  Future close() => throw UnimplementedError();
}
