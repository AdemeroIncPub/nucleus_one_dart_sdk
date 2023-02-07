import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization_project.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/organization_project.dart';

void main() {
  group('OrganizationProjectCollection class tests', () {
    performStandardQueryResultModelTests<
        OrganizationProjectCollection,
        api_mod.OrganizationProjectCollection,
        QueryResult<OrganizationProjectCollection, api_mod.OrganizationProjectCollection>,
        api_mod.QueryResult<api_mod.OrganizationProjectCollection>>(
      apiModelJson: organizationProjectCollectionJson,
    );
  });
}
