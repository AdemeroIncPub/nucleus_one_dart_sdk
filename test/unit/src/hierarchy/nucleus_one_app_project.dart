import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/signature_form_template.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/document.dart';
import '../api_model/document_upload.dart';
import '../api_model/signature_form_template.dart';

void main() {
  group('NucleusOneAppProject class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getDocumentCount method test', () async {
      final project = getStandardN1Project();
      await performHttpTest<int>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => project.getDocumentCount(true, false),
        responseBody: '1',
        expectedRequestUrlPath: http.apiPaths.organizationsProjectsCountsDocumentsFormat
            .replaceOrganizationAndProjectPlaceholders(project),
        expectedRequestQueryParams: [
          'ignoreInbox=true',
          'ignoreRecycleBin=false',
        ],
        additionalValidationsCallback: (x) {
          expect(x, 1);
        },
      );
    });

    test('getPageCount method test', () async {
      final project = getStandardN1Project();
      await performHttpTest<int>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => project.getPageCount(),
        responseBody: '1',
        expectedRequestUrlPath: http.apiPaths.organizationsProjectsCountsPagesFormat
            .replaceOrganizationAndProjectPlaceholders(project),
        expectedRequestQueryParams: [],
        additionalValidationsCallback: (x) {
          expect(x, 1);
        },
      );
    });

    test('getRecycleBinDocumentCount method test', () async {
      final project = getStandardN1Project();
      await performHttpTest<int>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => project.getRecycleBinDocumentCount(),
        responseBody: '1',
        expectedRequestUrlPath: http.apiPaths.organizationsProjectsCountsRecycleBinDocumentsFormat
            .replaceOrganizationAndProjectPlaceholders(project),
        expectedRequestQueryParams: [],
        additionalValidationsCallback: (x) {
          expect(x, 1);
        },
      );
    });

    test('getDocuments method test', () async {
      var project = getStandardN1Project();
      // Test with default parameters
      await performHttpTest<QueryResult<DocumentCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => project.getDocuments(),
        responseBody: documentCollectionJson,
        expectedRequestUrlPath: http.apiPaths.organizationsProjectsDocumentsFormat
            .replaceOrganizationAndProjectPlaceholders(project),
        expectedRequestQueryParams: [],
      );

      project = getStandardN1Project();
      // Test with optional arguments
      await performHttpTest<QueryResult<DocumentCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => project.getDocuments(
          showAll: true,
          documentFolderId: 'A',
          documentGroupId: 'B',
          cursor: 'C',
        ),
        responseBody: documentCollectionJson,
        expectedRequestUrlPath: http.apiPaths.organizationsProjectsDocumentsFormat
            .replaceOrganizationAndProjectPlaceholders(project),
        expectedRequestQueryParams: [
          'showAll=true',
          'documentFolderId=A',
          'documentGroupId=B',
          'cursor=C',
        ],
      );
    });

    test('getSignatureFormTemplates method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.apiPaths.organizationsProjectsSignatureFormTemplatesFormat
          .replaceOrganizationAndProjectPlaceholders(project);

      await performHttpTest<SignatureFormTemplateCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => project.getSignatureFormTemplates(),
        responseBody: signatureFormTemplateCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '',
      );
    });

    test('addSignatureFormTemplates method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.apiPaths.organizationsProjectsSignatureFormTemplatesFormat
          .replaceOrganizationAndProjectPlaceholders(project);
      final packagesApiModel = api_mod.SignatureFormTemplateCollection.fromJson(
          jsonDecode(signatureFormTemplateCollectionJson));
      final templates =
          SignatureFormTemplateCollection.fromApiModel(packagesApiModel, app: project.app);

      await performHttpTest<SignatureFormTemplateCollection>(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => project.addSignatureFormTemplates(templates),
        responseBody: signatureFormTemplateCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: signatureFormTemplateCollectionJson,
      );
    });

    test('updateSignatureFormTemplate method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceSignatureFormTemplateIdPlaceholder('123');
      final packagesApiModel =
          api_mod.SignatureFormTemplate.fromJson(jsonDecode(signatureFormTemplateJson));
      final template = SignatureFormTemplate.fromApiModel(packagesApiModel, app: project.app);

      await performHttpTest<void>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () =>
            project.updateSignatureFormTemplate(templateId: '123', template: template),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: signatureFormTemplateJson,
      );
    });

    test('deleteSignatureFormTemplate method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceSignatureFormTemplateIdPlaceholder('123');

      await performHttpTest<void>(
        httpMethod: HttpMethods.DELETE,
        httpCallCallback: () => project.deleteSignatureFormTemplate(templateId: '123'),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '',
      );
    });

    test('getSignatureFormTemplateFields method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFieldsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceSignatureFormTemplateIdPlaceholder('123');

      await performHttpTest<SignatureFormTemplateFieldCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => project.getSignatureFormTemplateFields(templateId: '123'),
        responseBody: signatureFormTemplateFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '',
      );
    });

    test('addSignatureFormTemplateFields method tests', () async {
      var project = getStandardN1Project();
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFieldsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceSignatureFormTemplateIdPlaceholder('123');
      final apiModel = api_mod.SignatureFormTemplateFieldCollection.fromJson(
          jsonDecode(signatureFormTemplateFieldCollectionJson));
      final fields = SignatureFormTemplateFieldCollection.fromApiModel(apiModel, app: project.app);

      // Test with default parameters
      await performHttpTest<SignatureFormTemplateFieldCollection>(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => project.addSignatureFormTemplateFields(
          templateId: '123',
          fields: fields,
        ),
        responseBody: signatureFormTemplateFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'clearExisting=false',
        ],
        expectedRequestBody: signatureFormTemplateFieldCollectionJson,
      );

      project = getStandardN1Project();
      // Test with optional parameters
      await performHttpTest<SignatureFormTemplateFieldCollection>(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => project.addSignatureFormTemplateFields(
          templateId: '123',
          fields: fields,
          clearExisting: true,
        ),
        responseBody: signatureFormTemplateFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'clearExisting=true',
        ],
        expectedRequestBody: signatureFormTemplateFieldCollectionJson,
      );
    });

    test('getDocumentUpload method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.apiPaths.organizationsProjectsDocumentUploadsFormat
          .replaceOrganizationAndProjectPlaceholders(project);
      // Test with default parameters
      await performHttpTest<DocumentUpload>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => project.getDocumentUpload(),
        responseBody: documentUploadJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('folderHierarchies method tests', () {
      final project = getStandardN1Project();

      final folderHierarchies = project.folderHierarchies();
      expect(folderHierarchies, isA<FolderHierarchyCollection>());
      expect(folderHierarchies.project, project);
    });

    test('folderHierarchyItems method tests', () {
      final project = getStandardN1Project();

      final folderHierarchyItems = project.folderHierarchyItems();
      expect(folderHierarchyItems, isA<FolderHierarchyItemCollection>());
      expect(folderHierarchyItems.project, project);
    });

    test('formTemplates method tests', () {
      final project = getStandardN1Project();

      final forms = project.formTemplates();
      expect(forms, isA<FormTemplateCollection>());
      expect(forms.project, project);
    });

    test('forms method tests', () {
      final project = getStandardN1Project();

      final forms = project.forms();
      expect(forms, isA<NucleusOneAppForms>());
      expect(forms.project, project);
    });
  });
}
