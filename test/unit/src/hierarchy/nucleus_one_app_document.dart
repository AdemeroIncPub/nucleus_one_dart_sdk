import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_comment.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_form.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_form_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_signing_recipient_package.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
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
      final expectedUrlPath = http.ApiPaths.organizationsProjectsDocumentsDocumentCommentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123');

      // Test with default parameters
      await performHttpTest<
          QueryResult2<DocumentCommentCollection, api_mod.DocumentCommentCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => document.getComments(),
        responseBody: documentCommentCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=true'],
      );

      document = getStandardN1Project().document('123');
      // Test with custom sorting and optional arguments
      await performHttpTest<
          QueryResult2<DocumentCommentCollection, api_mod.DocumentCommentCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => document.getComments(sortDescending: false, cursor: 'A'),
        responseBody: documentCommentCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=false', 'cursor=A'],
      );
    });

    test('postComments method tests', () async {
      var document = getStandardN1Project().document('123');
      final expectedUrlPath = http.ApiPaths.organizationsProjectsDocumentsDocumentCommentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123');
      // Test with no comments
      await performHttpTest(
        httpMethod: HttpMethods.post,
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
        httpMethod: HttpMethods.post,
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
      final expectedUrlPath = http.ApiPaths.organizationProjectsDocumentsDocumentEventsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123');
      // Test with default parameters
      await performHttpTest(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => document.getEvents(),
        responseBody: documentEventCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=true'],
      );

      document = getStandardN1Project().document('123');
      // Test with custom sorting and optional arguments
      await performHttpTest(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => document.getEvents(sortDescending: false, cursor: 'A'),
        responseBody: documentEventCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=false', 'cursor=A'],
      );
    });

    test('getDocumentContentPackage method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http.ApiPaths.organizationsProjectsDocumentContentPackagesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123');

      // Test with default parameters
      await performHttpTest(
        httpMethod: HttpMethods.get,
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

      // Test with pageIndex parameter
      await performHttpTest(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => document.getDocumentContentPackage(pageIndex: 1),
        responseBody: documentContentPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'displayInline=false',
          'preview=false',
          'singlePage=false',
          'requireSinglePage=false',
          'pageIndex=1',
        ],
      );
    });

    test('getDocumentPackage method tests', () async {
      final document = getStandardN1Project().document('ABC');
      final expectedUrlPath = http.ApiPaths.organizationsProjectsDocumentPackagesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('ABC');

      // Test with default parameters
      await performHttpTest<DocumentPackage>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => document.getDocumentPackage(),
        responseBody: documentPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('updateDocumentPackage method tests', () async {
      final document = getStandardN1Project().document('ABC');
      final docPkg = DocumentPackage.fromApiModel(
          api_mod.DocumentPackage.fromJson(jsonDecode(documentPackageJson)),
          app: document.project.app);

      final expectedUrlPath = http.ApiPaths.organizationsProjectsDocumentPackagesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('ABC');

      // Test with default parameters
      await performHttpTest<DocumentPackage>(
        httpMethod: HttpMethods.put,
        httpCallCallback: () => document.updateDocumentPackage(docPkg),
        responseBody: documentPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: documentPackageJson,
      );
    });

    test('getThumbnailUrl method tests', () async {
      final document = getStandardN1Project().document('ABC');
      final expectedUrlPath = http.ApiPaths.organizationsProjectsDocumentsThumbnailsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('ABC');

      await performHttpTest<String>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => document.getThumbnailUrl(),
        responseBody: documentPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('updateDocumentName method tests', () async {
      var document = getStandardN1Project().document('123');
      var expectedUrlPath = http.ApiPaths.organizationsProjectsDocumentsDocumentFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123');

      try {
        document = getStandardN1Project().document('123');
        await performHttpTest(
          httpMethod: HttpMethods.put,
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
      expectedUrlPath = http.ApiPaths.organizationsProjectsDocumentsDocumentFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('234');
      await performHttpTest(
        httpMethod: HttpMethods.put,
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
          .ApiPaths.organizationsProjectsDocumentsDocumentSignatureFormsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123');

      await performHttpTest(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => document.getOrCreateSignatureForm(),
        responseBody: documentSignatureFormJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getSignatureForm method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http
          .ApiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('234');

      await performHttpTest(
        httpMethod: HttpMethods.get,
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
          .ApiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('A');

      final apiModel =
          api_mod.DocumentSignatureForm.fromJson(jsonDecode(documentSignatureFormJson));
      final signatureForm = DocumentSignatureForm.fromApiModel(apiModel, app: document.project.app);

      await performHttpTest(
        httpMethod: HttpMethods.put,
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
          .ApiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('234');

      await performHttpTest<DocumentSignatureFormFieldCollection>(
        httpMethod: HttpMethods.get,
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
          .ApiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('234');
      final apiModel = api_mod.DocumentSignatureFormFieldCollection.fromJson(
          jsonDecodeListOfMap(documentSignatureFormFieldCollectionJson));
      final fields =
          DocumentSignatureFormFieldCollection.fromApiModel(apiModel, app: document.project.app);

      // Test with default parameters
      await performHttpTest<DocumentSignatureFormFieldCollection>(
        httpMethod: HttpMethods.post,
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
        httpMethod: HttpMethods.post,
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
      final expectedUrlPath = http.ApiPaths
          .organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsdocumentSignatureFormFieldFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('234')
          .replaceDocumentSignatureFormFieldIdPlaceholder(field.id);

      // Test with default parameters
      await performHttpTest<DocumentSignatureFormField>(
        httpMethod: HttpMethods.put,
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
        httpMethod: HttpMethods.put,
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
      final expectedUrlPath = http.ApiPaths
          .organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsdocumentSignatureFormFieldFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('234')
          .replaceDocumentSignatureFormFieldIdPlaceholder('345');

      await performHttpTest<void>(
        httpMethod: HttpMethods.delete,
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
          .ApiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123')
          .replaceDocumentSignatureFormIdPlaceholder('234');

      await performHttpTest<void>(
        httpMethod: HttpMethods.delete,
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
          .ApiPaths.organizationsProjectsDocumentsSignatureSessionPackagesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123');

      await performHttpTest<DocumentSignatureSessionPackage>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => document.getSignatureSessionPackage(),
        responseBody: documentSignatureSessionPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('updateSignatureSessionPackages method tests', () async {
      final document = getStandardN1Project().document('123');
      final expectedUrlPath = http
          .ApiPaths.organizationsProjectsDocumentsSignatureSessionPackagesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123');
      final packagesApiModel = api_mod.DocumentSignatureSessionPackageCollection.fromJson(
          jsonDecodeListOfMap(documentSignatureSessionPackageCollectionJson));
      final packages = DocumentSignatureSessionPackageCollection.fromApiModel(packagesApiModel,
          app: document.project.app);

      await performHttpTest<DocumentSignatureSessionPackageCollection>(
        httpMethod: HttpMethods.put,
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
      final expectedUrlPath = http.ApiPaths.organizationsProjectsDocumentSubscriptionsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(document.project)
          .replaceDocumentIdPlaceholder('123');
      // Test with default parameters
      await performHttpTest<DocumentSubscriptionForClient>(
        httpMethod: HttpMethods.get,
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
          .ApiPaths.organizationsProjectsDocumentActionsRestoreFromRecycleBinFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);
      // Test with no document ids
      testAssertionErrorAsync(
          () async => await performHttpTest(
                httpMethod: HttpMethods.post,
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
        httpMethod: HttpMethods.post,
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
          .ApiPaths.organizationsProjectsDocumentActionsSendToRecycleBinFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);
      // Test with no document ids
      testAssertionErrorAsync(
          () async => await performHttpTest(
                httpMethod: HttpMethods.post,
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
        httpMethod: HttpMethods.post,
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
      final expectedUrlPath = http.ApiPaths.documentSignatureSessionsSigningRecipientsFieldsFormat
          .replaceDocumentSignatureSessionIdPlaceholder('A')
          .replaceDocumentSignatureSessionRecipientIdPlaceholder('B');

      // Test with default parameters
      await performHttpTest<DocumentSignatureSessionSigningRecipientPackage>(
        httpMethod: HttpMethods.get,
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
        httpMethod: HttpMethods.get,
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
      final expectedUrlPath = http.ApiPaths.documentSignatureSessionsSigningRecipientsFieldsFormat
          .replaceDocumentSignatureSessionIdPlaceholder('A')
          .replaceDocumentSignatureSessionRecipientIdPlaceholder('B');
      final packagesApiModel =
          api_mod.DocumentSignatureSessionRecipientFormFieldCollection.fromJson(
              jsonDecodeListOfMap(documentSignatureSessionRecipientFormFieldCollectionJson));
      final fields = DocumentSignatureSessionRecipientFormFieldCollection.fromApiModel(
          packagesApiModel,
          app: project.app);

      await performHttpTest<void>(
        httpMethod: HttpMethods.put,
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
