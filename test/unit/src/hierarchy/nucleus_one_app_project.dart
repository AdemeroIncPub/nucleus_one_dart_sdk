import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/signature_form_template.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/document.dart';
import '../api_model/document_folder.dart';
import '../api_model/document_signature_form.dart';
import '../api_model/document_upload.dart';
import '../api_model/signature_form_template.dart';

void main() {
  group('NucleusOneAppProject class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Constructor test', () {
      final org = getStandardN1Org();
      final project = NucleusOneAppProject(organization: org, id: '123');
      expect(project.app, org.app);
      expect(project.id, '123');

      expect(
          () => NucleusOneAppProject(organization: org, id: ''),
          throwsA(allOf(
            isArgumentError,
            predicate(
                (ArgumentError e) => (e.name == 'id') && (e.message == 'Value cannot be blank.')),
          )));
    });

    test('getDocumentCount method test', () async {
      final project = getStandardN1Project();
      await performHttpTest<int>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.getDocumentCount(
          ignoreInbox: true,
          ignoreRecycleBin: false,
        ),
        responseBody: '1',
        expectedRequestUrlPath: http.ApiPaths.organizationsProjectsCountsDocumentsFormat
            .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
        expectedRequestQueryParams: [
          'ignoreInbox=true',
          'ignoreRecycleBin=false',
        ],
        additionalValidationsCallback: (x) {
          expect(x, 1);
        },
      );
    });

    test('getDocumentFolders method tests', () async {
      var project = getStandardN1Project();
      final expectedUrlPath = http.ApiPaths.organizationsProjectsDocumentFoldersFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);

      // Test with default parameters
      await performHttpTest<QueryResult<DocumentFolderCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.getDocumentFolders(),
        responseBody: documentFolderCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      project = getStandardN1Project();
      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<DocumentFolderCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.getDocumentFolders(
          parentId: 'B',
          cursor: 'A',
        ),
        responseBody: documentFolderCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'cursor=A',
          'parentId=B',
        ],
      );
    });

    test('getDocumentFolder method tests', () async {
      var project = getStandardN1Project();
      final documentFolderId = '123';
      final expectedUrlPath = http.ApiPaths.organizationsProjectsDocumentFoldersDocumentFolderFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentFolderIdPlaceholder(documentFolderId);

      // Test with default parameters
      await performHttpTest<DocumentFolder>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.getDocumentFolder(documentFolderId: documentFolderId),
        responseBody: documentFolderJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'documentFolderId=123',
        ],
      );
    });

    test('getPageCount method test', () async {
      final project = getStandardN1Project();
      await performHttpTest<int>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.getPageCount(),
        responseBody: '1',
        expectedRequestUrlPath: http.ApiPaths.organizationsProjectsCountsPagesFormat
            .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
        expectedRequestQueryParams: [],
        additionalValidationsCallback: (x) {
          expect(x, 1);
        },
      );
    });

    test('getRecycleBinDocumentCount method test', () async {
      final project = getStandardN1Project();
      await performHttpTest<int>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.getRecycleBinDocumentCount(),
        responseBody: '1',
        expectedRequestUrlPath: http.ApiPaths.organizationsProjectsCountsRecycleBinDocumentsFormat
            .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
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
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.getDocuments(),
        responseBody: documentCollectionJson,
        expectedRequestUrlPath: http.ApiPaths.organizationsProjectsDocumentsFormat
            .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
        expectedRequestQueryParams: [],
      );

      project = getStandardN1Project();
      // Test with optional arguments
      await performHttpTest<QueryResult<DocumentCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.getDocuments(
          showAll: true,
          documentFolderId: 'A',
          documentGroupId: 'B',
          cursor: 'C',
        ),
        responseBody: documentCollectionJson,
        expectedRequestUrlPath: http.ApiPaths.organizationsProjectsDocumentsFormat
            .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
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
      final expectedUrlPath = http.ApiPaths.organizationsProjectsSignatureFormTemplatesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);

      await performHttpTest<SignatureFormTemplateCollection>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.getSignatureFormTemplates(),
        responseBody: signatureFormTemplateCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '',
      );
    });

    test('addSignatureFormTemplates method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.ApiPaths.organizationsProjectsSignatureFormTemplatesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);
      final packagesApiModel = api_mod.SignatureFormTemplateCollection.fromJson(
          jsonDecode(signatureFormTemplateCollectionJson));
      final templates =
          SignatureFormTemplateCollection.fromApiModel(packagesApiModel, app: project.app);

      await performHttpTest<SignatureFormTemplateCollection>(
        httpMethod: HttpMethods.post,
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
          .ApiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceSignatureFormTemplateIdPlaceholder('123');
      final packagesApiModel =
          api_mod.SignatureFormTemplate.fromJson(jsonDecode(signatureFormTemplateJson));
      final template = SignatureFormTemplate.fromApiModel(packagesApiModel, app: project.app);

      await performHttpTest<void>(
        httpMethod: HttpMethods.put,
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
          .ApiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceSignatureFormTemplateIdPlaceholder('123');

      await performHttpTest<void>(
        httpMethod: HttpMethods.delete,
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
          .ApiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFieldsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceSignatureFormTemplateIdPlaceholder('123');

      await performHttpTest<SignatureFormTemplateFieldCollection>(
        httpMethod: HttpMethods.get,
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
          .ApiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFieldsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceSignatureFormTemplateIdPlaceholder('123');
      final apiModel = api_mod.SignatureFormTemplateFieldCollection.fromJson(
          jsonDecode(signatureFormTemplateFieldCollectionJson));
      final fields = SignatureFormTemplateFieldCollection.fromApiModel(apiModel, app: project.app);

      // Test with default parameters
      await performHttpTest<SignatureFormTemplateFieldCollection>(
        httpMethod: HttpMethods.post,
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
        httpMethod: HttpMethods.post,
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

    test('getSignatureForms method tests', () async {
      Future<void> performTest(
          Map<Symbol, dynamic> namedParams, List<String> expectedValues) async {
        final project = getStandardN1Project();
        final expectedUrlPath = http
            .ApiPaths.organizationsProjectsDocumentsRecentDocumentSignatureFormsFormat
            .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);
        await performHttpTest<DocumentSignatureFormCollection>(
          httpMethod: HttpMethods.get,
          httpCallCallback: () {
            return Function.apply(project.getSignatureForms, [], namedParams);
          },
          responseBody: documentSignatureFormCollectionJson,
          expectedRequestUrlPath: expectedUrlPath,
          expectedRequestQueryParams: expectedValues,
        );
      }

      // Test with default parameters
      await performTest({}, []);
      // Test with docNameStartsWith parameter
      await performTest(
        <Symbol, dynamic>{
          const Symbol('docNameStartsWith'): '123',
        },
        ['nameFilter=123'],
      );
      // Test with excludingId parameter
      await performTest(
        <Symbol, dynamic>{
          const Symbol('excludingId'): '234',
        },
        ['excludingId=234'],
      );
      // Test with both parameters
      await performTest(
        <Symbol, dynamic>{
          const Symbol('docNameStartsWith'): '123',
          const Symbol('excludingId'): '234',
        },
        [
          'nameFilter=123',
          'excludingId=234',
        ],
      );
    });

    test('getDocumentUploadReservation method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.ApiPaths.organizationsProjectsDocumentUploadsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);
      // Test with default parameters
      await performHttpTest<DocumentUpload>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.getDocumentUploadReservation(),
        responseBody: documentUploadJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('uploadDocument method tests', () async {
      final project = getStandardN1Project();
      final expectedApiUrlPath = http.ApiPaths.organizationsProjectsDocumentUploadsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);

      const fileLen = NucleusOneOptions.uploadChunkSize * 2;
      final fileData = Uint8List.fromList(List.generate(fileLen, (i) => 65));
      final fileDataFirstHalf = Uint8List.fromList(fileData.take(fileLen ~/ 2).toList());
      final fileDataFirstHalfAsString = fileDataFirstHalf.map((x) => String.fromCharCode(x)).join();
      final documentUploadLocal =
          documentUploadJsonFileSizeFormat.replaceFirst('{0}', fileLen.toString());

      final opDocumentUploads = HttpOperation(
        requestUrl: Uri.parse(expectedApiUrlPath),
        requestHttpMethod: HttpMethods.get,
        requestBody: '',
        responseBody: documentUploadLocal,
        responseHttpStatus: HttpStatus.ok,
        responseCookies: null,
      );
      final opGcsInitResponseSuccesful = HttpOperation(
        isN1ApiOperation: false,
        requestUrl: Uri.parse('A'),
        requestHttpMethod: HttpMethods.put,
        requestBody: '{}',
        responseBody: '',
        responseHttpStatus: HttpStatus.ok,
        responseCookies: null,
        responseHeaders: MockHttpHeaders()..add('location', 'A'),
      );
      final opGcsInitResponseFailure = opGcsInitResponseSuccesful.shallowCopyWith(
        responseHttpStatus: HttpStatus.notFound,
      );
      final opGcsUploadResponseSuccessful200 = HttpOperation(
        isN1ApiOperation: false,
        requestUrl: Uri.parse('A'),
        requestHttpMethod: HttpMethods.put,
        requestBody: fileDataFirstHalfAsString,
        responseBody: '',
        responseHttpStatus: HttpStatus.ok,
        responseCookies: null,
      );
      final opGcsUploadResponseSuccessful308 = opGcsUploadResponseSuccessful200.shallowCopyWith(
        responseHttpStatus: HttpStatus.permanentRedirect,
      );
      final opGcsUploadResponseFailure = opGcsUploadResponseSuccessful200.shallowCopyWith(
        responseHttpStatus: HttpStatus.notFound,
      );
      final opUploadCompletion = HttpOperation(
        requestUrl: Uri.parse(expectedApiUrlPath),
        requestHttpMethod: HttpMethods.put,
        requestQueryParams: <String>[
          'uniqueId=C',
          'captureOriginal=false',
        ],
        requestBody: '[$documentUploadLocal]',
        responseBody: '',
        responseHttpStatus: HttpStatus.ok,
        responseCookies: null,
      );

      Future<void> performUploadTest({
        required bool shouldFail,
        String? exceptionMessageStartsWith,
        required List<HttpOperation> httpOperationsOrdered,
      }) async {
        try {
          await performHttpTests<void>(
            httpMethod: HttpMethods.get,
            httpCallCallback: () => project.uploadDocument(
              userEmail: '1@2.com',
              fileName: 'D',
              contentType: '3',
              file: fileData,
            ),
            httpOperationsOrdered: httpOperationsOrdered,
          );
          if (shouldFail) {
            fail('An exception should have been thrown.');
          }
        } catch (e) {
          if (!shouldFail) {
            rethrow;
          }
          expect(e, startsWith(exceptionMessageStartsWith!));
        }
      }

      // Test GCS upload initialization failure
      await performUploadTest(
        shouldFail: true,
        exceptionMessageStartsWith: 'Error initializing upload to cloud storage.  HTTP ',
        httpOperationsOrdered: [
          opDocumentUploads,
          opGcsInitResponseFailure,
        ],
      );

      // Test GCS upload failure
      await performUploadTest(
        shouldFail: true,
        exceptionMessageStartsWith: 'Error uploading to cloud storage.  HTTP ',
        httpOperationsOrdered: [
          opDocumentUploads,
          opGcsInitResponseSuccesful,
          opGcsUploadResponseFailure,
        ],
      );

      // Test success with a 200 response from GCS
      await performUploadTest(
        shouldFail: false,
        httpOperationsOrdered: [
          opDocumentUploads,
          opGcsInitResponseSuccesful,
          opGcsUploadResponseSuccessful200,
          opGcsUploadResponseSuccessful200,
          opUploadCompletion,
        ],
      );

      // Test success with a 308 response from GCS
      await performUploadTest(
        shouldFail: false,
        httpOperationsOrdered: [
          opDocumentUploads,
          opGcsInitResponseSuccesful,
          opGcsUploadResponseSuccessful308,
          opGcsUploadResponseSuccessful308,
          opUploadCompletion,
        ],
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
