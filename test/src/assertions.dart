import 'dart:async';

import 'package:test/test.dart';

/// Tests that an operation does not throw an AssertionError.
void testValidAssertion(void Function() invocationCallback) {
  _testValidAssertionInternal(invocationCallback);
}

/// Tests that an operation does not throw an AssertionError.
FutureOr<void> testValidAssertionAsync(FutureOr<void> Function() invocationCallback) async {
  return _testValidAssertionInternal(invocationCallback);
}

FutureOr<void> _testValidAssertionInternal(FutureOr<void> Function() invocationCallback) async {
  try {
    await invocationCallback();
  } on AssertionError catch (_) {
    fail('An exception should not have been thrown for this valid scenario');
  }
}

/// Tests that an operation throws an AssertionError whose message contains a particular value.
void testAssertionError(void Function() invocationCallback, String exceptionContainsText) {
  _testAssertionErrorInternal(invocationCallback, exceptionContainsText);
}

/// Tests that an operation throws an AssertionError whose message contains a particular value.
FutureOr<void> testAssertionErrorAsync(
    FutureOr<void> Function() invocationCallback, String exceptionContainsText) async {
  return _testAssertionErrorInternal(invocationCallback, exceptionContainsText);
}

FutureOr<void> _testAssertionErrorInternal(
    FutureOr<void> Function() invocationCallback, String exceptionContainsText) async {
  try {
    await invocationCallback();
    fail('An exception should have been thrown, since $exceptionContainsText was null');
  } on AssertionError catch (e) {
    exceptionContainsText = RegExp.escape(exceptionContainsText);
    expect(e.toString(), matches('\\b$exceptionContainsText\\b'));
  }
}
