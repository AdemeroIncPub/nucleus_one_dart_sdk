import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_task.dart';
import 'package:test/test.dart';

User getStandardTestUser() {
  return User(
    app: getStandardN1App(),
  );
}

NucleusOneApp getStandardN1App({
  String baseUrl = '',
  String apiKey = '',
}) {
  return NucleusOneApp(
    options: NucleusOneOptions(
      apiBaseUrl: baseUrl,
      apiKey: apiKey,
    ),
  );
}

NucleusOneAppOrganization getStandardN1Org([String id = 'orgId']) {
  return NucleusOneAppOrganization(
    app: getStandardN1App(),
    id: id,
  );
}

NucleusOneAppProject getStandardN1Project([String id = 'projId']) {
  return NucleusOneAppProject(
    organization: getStandardN1Org(),
    id: id,
  );
}

NucleusOneAppTask getStandardN1Task([String id = 'taskId']) {
  return NucleusOneAppTask(
    project: getStandardN1Project(),
    id: id,
  );
}

/// Returns a matcher that tests if the value equals the API call's full URL.
Matcher apiRequestPathMatches(String relativePath) =>
    wrapMatcher(getStandardN1App().getFullUrl(relativePath));
