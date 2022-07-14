import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

User getStandardTestUser() {
  return User(
    app: getStandardN1App(),
  );
}

NucleusOneAppInternal getStandardN1App([String baseUrl = '']) {
  return NucleusOneAppInternal(
    options: NucleusOneOptions(
      baseUrl: baseUrl,
    ),
  );
}

/// Returns a matcher that tests if the value equals the API call's full URL.
Matcher apiRequestPathMatches(String relativePath) =>
    wrapMatcher(getStandardN1App().getFullUrl(relativePath));
