import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_form.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_form_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_signing_recipient_package.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/assertions.dart';
import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/document_comments.dart';
import '../api_model/document_content_package.dart';
import '../api_model/document_event.dart';
import '../api_model/document_for_client.dart';
import '../api_model/document_package.dart';
import '../api_model/document_signature_form.dart';
import '../api_model/document_signature_form_field.dart';
import '../api_model/document_signature_session.dart';
import '../api_model/document_signature_session_signing_recipient_package.dart';
import '../api_model/document_subscription_for_client.dart';

void main() {
  group('NucleusOneAppDocument class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getComments method tests', () async {
      var document = getStandardN1Project().document('123');
      final expectedUrlPath = http.apiPaths.organizationsProjectsDocumentsDocumentCommentsFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123');

      // Test with default parameters
      await performHttpTest<QueryResult2<DocumentCommentCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => document.getComments(),
        responseBody: documentCommentsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=true'],
      );

      document = getStandardN1Project().document('123');
      // Test with custom sorting and optional arguments
      await performHttpTest<QueryResult2<DocumentCommentCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => document.getComments(sortDescending: false, cursor: 'A'),
        responseBody: documentCommentsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=false', 'cursor=A'],
      );
    });

    test('postComments method tests', () async {
      var document = getStandardN1Project().document('123');
      final expectedUrlPath = http.apiPaths.organizationsProjectsDocumentsDocumentCommentsFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123');
      // Test with no comments
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => document.postComments(
          comments: [],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"Comments":[]}',
      );

      document = getStandardN1Project().document('123');
      // Test with some comments
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => document.postComments(
          comments: ['A', 'B'],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"Comments":["A","B"]}',
      );
    });

    test('getEvents method tests', () async {
      var document = getStandardN1Project().document('123');
      final expectedUrlPath = http.apiPaths.organizationProjectsDocumentsDocumentEventsFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123');
      // Test with default parameters
      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => document.getEvents(),
        responseBody: documentEventsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=true'],
      );

      document = getStandardN1Project().document('123');
      // Test with custom sorting and optional arguments
      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => document.getEvents(sortDescending: false, cursor: 'A'),
        responseBody: documentEventsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=false', 'cursor=A'],
      );
    });

    test('getDocumentContentPackage method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http.apiPaths.organizationsProjectsDocumentContentPackagesFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123');
      // Test with default parameters
      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => document.getDocumentContentPackage(),
        responseBody: documentContentPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'displayInline=false',
          'preview=false',
          'singlePage=false',
          'requireSinglePage=false',
          'pageIndex=0',
        ],
      );
    });

    test('getDocumentPackage method tests', () async {
      final document = getStandardN1Project().document('ABC');
      final expectedUrlPath = http.apiPaths.organizationsProjectsDocumentPackagesFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('ABC');
      // Test with default parameters
      await performHttpTest<DocumentPackage>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => document.getDocumentPackage(),
        responseBody: documentPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getThumbnailUrl method tests', () async {
      final document = getStandardN1Project().document('ABC');
      final expectedUrlPath = http.apiPaths.organizationsProjectsDocumentsThumbnailsFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('ABC');

      await performHttpTest<String>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => document.getThumbnailUrl(),
        responseBody: documentPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('updateDocumentName method tests', () async {
      var document = getStandardN1Project().document('123');
      var expectedUrlPath = http.apiPaths.organizationsProjectsDocumentsDocumentFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123');

      try {
        document = getStandardN1Project().document('123');
        await performHttpTest(
          httpMethod: HttpMethods.PUT,
          httpCallCallback: () => document.updateDocumentName(
            documentName: '',
          ),
          responseBody: '',
          expectedRequestUrlPath: expectedUrlPath,
          expectedRequestQueryParams: [],
        );
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'documentName');
      }

      document = getStandardN1Project().document('234');
      expectedUrlPath = http.apiPaths.organizationsProjectsDocumentsDocumentFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('234');
      await performHttpTest(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => document.updateDocumentName(
          documentName: '234',
        ),
        expectedRequestBody: '{"ID":"234","Name":"234"}',
        responseBody: documentForClientJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getOrCreateSignatureForm method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsDocumentsDocumentSignatureFormsFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123');

      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => document.getOrCreateSignatureForm(),
        responseBody: documentSignatureFormJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getSignatureForm method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('234');

      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => document.getSignatureForm(
          signatureFormId: '234',
        ),
        responseBody: documentSignatureFormJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('updateSignatureForm method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('A');

      final apiModel =
          api_mod.DocumentSignatureForm.fromJson(jsonDecode(documentSignatureFormJson));
      final signatureForm = DocumentSignatureForm.fromApiModel(apiModel, app: document.project.app);

      await performHttpTest(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => document.updateSignatureForm(
          signatureForm: signatureForm,
        ),
        responseBody: documentSignatureFormJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: documentSignatureFormJson,
      );
    });

    test('getSignatureFormFields method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('234');

      await performHttpTest<DocumentSignatureFormFieldCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => document.getSignatureFormFields(
          signatureFormId: '234',
        ),
        responseBody: documentSignatureFormFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('addSignatureFormFields method tests', () async {
      var document = getStandardN1Project().document('123');
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('234');
      final apiModel = api_mod.DocumentSignatureFormFieldCollection.fromJson(
          jsonDecode(documentSignatureFormFieldCollectionJson));
      final fields =
          DocumentSignatureFormFieldCollection.fromApiModel(apiModel, app: document.project.app);

      // Test with default parameters
      await performHttpTest<DocumentSignatureFormFieldCollection>(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => document.addSignatureFormFields(
          signatureFormId: '234',
          signatureFormFields: fields,
        ),
        responseBody: documentSignatureFormFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'clearExisting=false',
        ],
        expectedRequestBody: documentSignatureFormFieldCollectionJson,
      );

      document = getStandardN1Project().document('123');
      // Test with optional parameters
      await performHttpTest<DocumentSignatureFormFieldCollection>(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => document.addSignatureFormFields(
          signatureFormId: '234',
          signatureFormFields: fields,
          clearExisting: true,
        ),
        responseBody: documentSignatureFormFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'clearExisting=true',
        ],
        expectedRequestBody: documentSignatureFormFieldCollectionJson,
      );
    });

    test('updateSignatureFormField method tests', () async {
      var document = getStandardN1Project().document('123');
      final apiModel =
          api_mod.DocumentSignatureFormField.fromJson(jsonDecode(documentSignatureFormFieldJson));
      final field = DocumentSignatureFormField.fromApiModel(apiModel, app: document.project.app);
      final expectedUrlPath = http.apiPaths
          .organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsdocumentSignatureFormFieldFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('234')
          .replaceDocumentSignatureFormFieldIdPlaceholder(field.id);

      // Test with default parameters
      await performHttpTest<DocumentSignatureFormField>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => document.updateSignatureFormField(
          signatureFormId: '234',
          signatureFormField: field,
        ),
        responseBody: documentSignatureFormFieldJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'clearExisting=false',
        ],
        expectedRequestBody: documentSignatureFormFieldJson,
      );

      document = getStandardN1Project().document('123');
      // Test with optional parameters
      await performHttpTest<DocumentSignatureFormField>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => document.updateSignatureFormField(
          signatureFormId: '234',
          signatureFormField: field,
          clearExisting: true,
        ),
        responseBody: documentSignatureFormFieldJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'clearExisting=true',
        ],
        expectedRequestBody: documentSignatureFormFieldJson,
      );
    });

    test('deleteSignatureFormField method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http.apiPaths
          .organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsdocumentSignatureFormFieldFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('234')
          .replaceDocumentSignatureFormFieldIdPlaceholder('345');

      await performHttpTest<void>(
        httpMethod: HttpMethods.DELETE,
        httpCallCallback: () => document.deleteSignatureFormField(
          signatureFormId: '234',
          signatureFormFieldId: '345',
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '',
      );
    });

    test('deleteAllSignatureFormFields method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('234');

      await performHttpTest<void>(
        httpMethod: HttpMethods.DELETE,
        httpCallCallback: () => document.deleteAllSignatureFormFields(
          signatureFormId: '234',
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '',
      );
    });

    test('getSignatureSessionPackage method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsDocumentsSignatureSessionPackagesFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123');

      await performHttpTest<DocumentSignatureSessionPackage>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => document.getSignatureSessionPackage(),
        responseBody: documentSignatureSessionPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('updateSignatureSessionPackages method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsDocumentsSignatureSessionPackagesFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123');
      final packagesApiModel = api_mod.DocumentSignatureSessionPackageCollection.fromJson(
          jsonDecode(documentSignatureSessionPackageCollectionJson));
      final packages = DocumentSignatureSessionPackageCollection.fromApiModel(packagesApiModel,
          app: document.project.app);

      await performHttpTest<DocumentSignatureSessionPackageCollection>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => document.updateSignatureSessionPackages(
          packages: packages,
        ),
        responseBody: documentSignatureSessionPackageCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: documentSignatureSessionPackageCollectionJson,
      );
    });

    test('getSubscription method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http.apiPaths.organizationsProjectsDocumentSubscriptionsFormat
          .replaceOrganizationAndProjectPlaceholders(document.project)
          .replaceDocumentIdPlaceholder('123');
      // Test with default parameters
      await performHttpTest<DocumentSubscriptionForClient>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => document.getSubscription(),
        responseBody: documentSubscriptionForClientJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });

  group('NucleusOneAppDocuments class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('restoreFromRecycleBin method tests', () async {
      var project = getStandardN1Project();
      var documents = project.documents();
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsDocumentActionsRestoreFromRecycleBinFormat
          .replaceOrganizationAndProjectPlaceholders(project);
      // Test with no document ids
      testAssertionErrorAsync(
          () async => await performHttpTest(
                httpMethod: HttpMethods.POST,
                httpCallCallback: () => documents.restoreFromRecycleBin([]),
                responseBody: '',
                expectedRequestUrlPath: expectedUrlPath,
                expectedRequestQueryParams: [],
                expectedRequestBody: '',
              ),
          'documentIds');

      project = getStandardN1Project();
      documents = project.documents();
      // Test with document ids
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => documents.restoreFromRecycleBin(['A', 'B']),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"IDs":["A","B"]}',
      );
    });

    test('sendToRecycleBin method tests', () async {
      var project = getStandardN1Project();
      var documents = project.documents();
      final expectedUrlPath = http
          .apiPaths.organizationsProjectsDocumentActionsSendToRecycleBinFormat
          .replaceOrganizationAndProjectPlaceholders(project);
      // Test with no document ids
      testAssertionErrorAsync(
          () async => await performHttpTest(
                httpMethod: HttpMethods.POST,
                httpCallCallback: () => documents.sendToRecycleBin([]),
                responseBody: '',
                expectedRequestUrlPath: expectedUrlPath,
                expectedRequestQueryParams: [],
                expectedRequestBody: '',
              ),
          'documentIds');

      project = getStandardN1Project();
      documents = project.documents();
      // Test with some document ids
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => documents.sendToRecycleBin(['A', 'B']),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"IDs":["A","B"]}',
      );
    });

    test('getDocumentSignatureSessionSigningRecipientPackage method tests', () async {
      var project = getStandardN1Project();
      var documents = project.documents();
      final expectedUrlPath = http.apiPaths.documentSignatureSessionsSigningRecipientsFieldsFormat
          .replaceDocumentSignatureSessionIdPlaceholder('A')
          .replaceDocumentSignatureSessionRecipientIdPlaceholder('B');

      // Test with default parameters
      await performHttpTest<DocumentSignatureSessionSigningRecipientPackage>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => documents.getDocumentSignatureSessionSigningRecipientPackage(
          signatureSessionId: 'A',
          signatureSessionRecipientId: 'B',
          signatureSessionRecipientUniqueId: 'C',
        ),
        responseBody: documentSignatureSessionSigningRecipientPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'uniqueId=C',
        ],
      );

      project = getStandardN1Project();
      documents = project.documents();
      // Test with optional parameters
      await performHttpTest<DocumentSignatureSessionSigningRecipientPackage>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => documents.getDocumentSignatureSessionSigningRecipientPackage(
          signatureSessionId: 'A',
          signatureSessionRecipientId: 'B',
          signatureSessionRecipientUniqueId: 'C',
          skipFormFieldPackage: true,
          accessCode: 'D',
          pageIndex: 1,
        ),
        responseBody: documentSignatureSessionSigningRecipientPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'uniqueId=C',
          'skipFormFieldPackage=true',
          'accessCode=D',
          'pageIndex=1',
        ],
      );
    });

    test('signDocument method tests', () async {
      final project = getStandardN1Project();
      final documents = project.documents();
      final expectedUrlPath = http.apiPaths.documentSignatureSessionsSigningRecipientsFieldsFormat
          .replaceDocumentSignatureSessionIdPlaceholder('A')
          .replaceDocumentSignatureSessionRecipientIdPlaceholder('B');
      final packagesApiModel =
          api_mod.DocumentSignatureSessionRecipientFormFieldCollection.fromJson(
              jsonDecode(documentSignatureSessionRecipientFormFieldCollectionJson));
      final fields = DocumentSignatureSessionRecipientFormFieldCollection.fromApiModel(
          packagesApiModel,
          app: project.app);

      await performHttpTest<void>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => documents.signDocument(
          signatureSessionId: 'A',
          signatureSessionRecipientId: 'B',
          signatureSessionRecipientUniqueId: 'C',
          fields: fields,
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'uniqueId=C',
        ],
        expectedRequestBody: documentSignatureSessionRecipientFormFieldCollectionJson,
      );
    });
  });
}
