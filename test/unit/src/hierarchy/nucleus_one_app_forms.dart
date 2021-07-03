import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/form_template.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/form_template.dart';

void main() {
  group('NucleusOneAppForms class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('submitForm method tests', () async {
      final expectedUrlPath =
          http.apiPaths.formTemplatesPublicSubmissions.replaceFirst('<formTemplateId>', '123');
      final n1App = getStandardN1App();
      final apiModel =
          api_mod.FormSubmissionPackage.fromJson(jsonDecode(formSubmissionPackageJson));
      final package = FormSubmissionPackage.fromApiModel(apiModel);

      try {
        await performHttpTest(
          httpMethod: HttpMethods.POST,
          httpCallCallback: () =>
              NucleusOneAppForms(app: n1App).submitForm(formTemplateId: '', package: package),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'formTemplateId');
      }

      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () =>
            NucleusOneAppForms(app: n1App).submitForm(formTemplateId: '123', package: package),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
