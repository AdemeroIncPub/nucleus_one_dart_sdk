import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_form.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_form_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_signing_recipient_package.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_documents.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/assertions.dart';
import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/document_comments.dart';
import '../api_model/document_content_package.dart';
import '../api_model/document_event.dart';
import '../api_model/document_package.dart';
import '../api_model/document_results.dart';
import '../api_model/document_signature_form.dart';
import '../api_model/document_signature_form_field.dart';
import '../api_model/document_signature_session.dart';
import '../api_model/document_signature_session_signing_recipient_package.dart';

void main() {
  group('NucleusOneAppDocuments class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    group('getCount method tests', () {
      test('getDocumentCount method test', () async {
        final n1App = getStandardN1App();
        await performHttpTest<int>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getDocumentCount(true, false),
          responseBody: '1',
          expectedRequestUrlPath: http.apiPaths.documentCounts,
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
        final n1App = getStandardN1App();
        await performHttpTest<int>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getPageCount(),
          responseBody: '1',
          expectedRequestUrlPath: http.apiPaths.pageCounts,
          expectedRequestQueryParams: [],
          additionalValidationsCallback: (x) {
            expect(x, 1);
          },
        );
      });

      test('getRecycleBinDocumentCount method test', () async {
        final n1App = getStandardN1App();
        await performHttpTest<int>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getRecycleBinDocumentCount(),
          responseBody: '1',
          expectedRequestUrlPath: http.apiPaths.recycleBinDocumentCounts,
          expectedRequestQueryParams: [],
          additionalValidationsCallback: (x) {
            expect(x, 1);
          },
        );
      });

      test('getRecycleBinInboxDocumentCount method test', () async {
        final n1App = getStandardN1App();
        await performHttpTest<int>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () =>
              NucleusOneAppDocuments(app: n1App).getRecycleBinInboxDocumentCount(),
          responseBody: '1',
          expectedRequestUrlPath: http.apiPaths.recycleBinInboxCounts,
          expectedRequestQueryParams: [],
          additionalValidationsCallback: (x) {
            expect(x, 1);
          },
        );
      });

      test('getInboxDocumentCount method test', () async {
        final n1App = getStandardN1App();
        await performHttpTest<int>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getInboxDocumentCount(true),
          responseBody: '1',
          expectedRequestUrlPath: http.apiPaths.inboxCounts,
          expectedRequestQueryParams: [
            'ignoreRecycleBin=true',
          ],
          additionalValidationsCallback: (x) {
            expect(x, 1);
          },
        );
      });
    });

    group('_getRecentInternal method consumers tests', () {
      test('getRecent method test', () async {
        final n1App = getStandardN1App();
        // Test with default parameters
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getRecent(),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'sortType=CreatedOn',
            'sortDescending=true',
          ],
        );

        // Test with custom sorting
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () =>
              NucleusOneAppDocuments(app: n1App).getRecent(sortType: 'A', sortDescending: false),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'sortType=A',
            'sortDescending=false',
          ],
        );

        // Test with optional arguments
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppDocuments(app: n1App)
              .getRecent(offset: 1, cursor: 'B', singleRecord: true),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'sortType=CreatedOn',
            'sortDescending=true',
            'offset=1',
            'cursor=B',
            'singleRecord=true',
          ],
        );
      });

      test('getInboxRecent method test', () async {
        final n1App = getStandardN1App();
        // Test with default parameters
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getInboxRecent(),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'inbox=true',
            'sortType=CreatedOn',
            'sortDescending=true',
          ],
        );

        // Test with custom sorting
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppDocuments(app: n1App)
              .getInboxRecent(sortType: 'A', sortDescending: false),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'inbox=true',
            'sortType=A',
            'sortDescending=false',
          ],
        );
      });

      test('getDocumentSubscriptionsRecent method test', () async {
        final n1App = getStandardN1App();
        // Test with default parameters
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () =>
              NucleusOneAppDocuments(app: n1App).getDocumentSubscriptionsRecent(),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'documentSubscriptions=true',
            'sortType=CreatedOn',
            'sortDescending=true',
          ],
        );

        // Test with custom sorting
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppDocuments(app: n1App)
              .getDocumentSubscriptionsRecent(sortType: 'A', sortDescending: false),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'documentSubscriptions=true',
            'sortType=A',
            'sortDescending=false',
          ],
        );
      });

      test('getRecycleBinRecent method test', () async {
        final n1App = getStandardN1App();
        // Test with default parameters
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getRecycleBinRecent(),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'recycleBin=true',
            'sortType=CreatedOn',
            'sortDescending=true',
          ],
        );

        // Test with custom sorting
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppDocuments(app: n1App)
              .getRecycleBinRecent(sortType: 'A', sortDescending: false),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'recycleBin=true',
            'sortType=A',
            'sortDescending=false',
          ],
        );
      });
    });

    test('getComments method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentsCommentsFormat.replaceFirst('<documentId>', '123');
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<QueryResult2<DocumentCommentCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getComments(documentId: '123'),
        responseBody: documentCommentsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=true'],
      );

      // Test with custom sorting and optional arguments
      await performHttpTest<QueryResult2<DocumentCommentCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App)
            .getComments(documentId: '123', sortDescending: false, cursor: 'A'),
        responseBody: documentCommentsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=false', 'cursor=A'],
      );
    });

    test('postComments method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentsCommentsFormat.replaceFirst('<documentId>', '123');
      final n1App = getStandardN1App();
      // Test with no comments
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).postComments(
          documentId: '123',
          comments: [],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"Comments":[]}',
      );

      // Test with some comments
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).postComments(
          documentId: '123',
          comments: ['A', 'B'],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"Comments":["A","B"]}',
      );
    });

    test('getEvents method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentsEventsFormat.replaceFirst('<documentId>', '123');
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getEvents(documentId: '123'),
        responseBody: documentEventsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=true'],
      );

      // Test with custom sorting and optional arguments
      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App)
            .getEvents(documentId: '123', sortDescending: false, cursor: 'A'),
        responseBody: documentEventsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=false', 'cursor=A'],
      );
    });

    test('restoreFromRecycleBin method tests', () async {
      final expectedUrlPath = http.apiPaths.documentActionsRestoreFromRecycleBin;
      final n1App = getStandardN1App();
      // Test with no document ids
      testAssertionErrorAsync(
          () async => await performHttpTest(
                httpMethod: HttpMethods.POST,
                httpCallCallback: () =>
                    NucleusOneAppDocuments(app: n1App).restoreFromRecycleBin([]),
                responseBody: '',
                expectedRequestUrlPath: expectedUrlPath,
                expectedRequestQueryParams: [],
                expectedRequestBody: '',
              ),
          'documentIds');

      // Test with document ids
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () =>
            NucleusOneAppDocuments(app: n1App).restoreFromRecycleBin(['A', 'B']),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"IDs":["A","B"]}',
      );
    });

    test('sendToRecycleBin method tests', () async {
      final expectedUrlPath = http.apiPaths.documentActionsSendToRecycleBin;
      final n1App = getStandardN1App();
      // Test with no document ids
      testAssertionErrorAsync(
          () async => await performHttpTest(
                httpMethod: HttpMethods.POST,
                httpCallCallback: () => NucleusOneAppDocuments(app: n1App).sendToRecycleBin([]),
                responseBody: '',
                expectedRequestUrlPath: expectedUrlPath,
                expectedRequestQueryParams: [],
                expectedRequestBody: '',
              ),
          'documentIds');

      // Test with some document ids
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).sendToRecycleBin(['A', 'B']),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"IDs":["A","B"]}',
      );
    });

    test('getDocumentContentPackage method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentContentPackagesFormat.replaceFirst('<documentId>', '123');
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getDocumentContentPackage('123'),
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

    test('getDocumentPackageByDocumentId method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentPackageFormat.replaceFirst('<documentId>', 'ABC');
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<DocumentPackage>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            NucleusOneAppDocuments(app: n1App).getDocumentPackageByDocumentId('ABC'),
        responseBody: documentPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getOrCreateSignatureForm method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentsSignatureFormsFormat.replaceFirst('<documentId>', '123');
      final n1App = getStandardN1App();

      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getOrCreateSignatureForm('123'),
        responseBody: documentSignatureFormJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getSignatureForm method tests', () async {
      final expectedUrlPath = http.apiPaths.documentsSignatureFormsByIdFormat
          .replaceFirst('<documentId>', '123')
          .replaceFirst('<documentSignatureFormId>', '234');
      final n1App = getStandardN1App();

      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getSignatureForm(
          documentId: '123',
          signatureFormId: '234',
        ),
        responseBody: documentSignatureFormJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('updateSignatureForm method tests', () async {
      final expectedUrlPath = http.apiPaths.documentsSignatureFormsByIdFormat
          .replaceFirst('<documentId>', '123')
          .replaceFirst('<documentSignatureFormId>', 'A');
      final n1App = getStandardN1App();

      final apiModel =
          api_mod.DocumentSignatureForm.fromJson(jsonDecode(documentSignatureFormJson));
      final signatureForm = DocumentSignatureForm.fromApiModel(apiModel);

      await performHttpTest(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).updateSignatureForm(
          documentId: '123',
          signatureForm: signatureForm,
        ),
        responseBody: documentSignatureFormJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: documentSignatureFormJson,
      );
    });

    test('getSignatureFormFields method tests', () async {
      final expectedUrlPath = http.apiPaths.documentsSignatureFormsByIdFieldsFormat
          .replaceFirst('<documentId>', '123')
          .replaceFirst('<documentSignatureFormId>', '234');
      final n1App = getStandardN1App();

      await performHttpTest<DocumentSignatureFormFieldCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getSignatureFormFields(
          documentId: '123',
          signatureFormId: '234',
        ),
        responseBody: documentSignatureFormFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('addSignatureFormFields method tests', () async {
      final expectedUrlPath = http.apiPaths.documentsSignatureFormsByIdFieldsFormat
          .replaceFirst('<documentId>', '123')
          .replaceFirst('<documentSignatureFormId>', '234');
      final n1App = getStandardN1App();
      final apiModel = api_mod.DocumentSignatureFormFieldCollection.fromJson(
          jsonDecode(documentSignatureFormFieldCollectionJson));
      final fields = DocumentSignatureFormFieldCollection.fromApiModel(apiModel);

      // Test with default parameters
      await performHttpTest<DocumentSignatureFormFieldCollection>(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).addSignatureFormFields(
          documentId: '123',
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

      // Test with optional parameters
      await performHttpTest<DocumentSignatureFormFieldCollection>(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).addSignatureFormFields(
          documentId: '123',
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
      final n1App = getStandardN1App();
      final apiModel =
          api_mod.DocumentSignatureFormField.fromJson(jsonDecode(documentSignatureFormFieldJson));
      final field = DocumentSignatureFormField.fromApiModel(apiModel);
      final expectedUrlPath = http.apiPaths.documentsSignatureFormsByIdFieldsByFieldIdFormat
          .replaceFirst('<documentId>', '123')
          .replaceFirst('<documentSignatureFormId>', '234')
          .replaceFirst('<documentSignatureFormFieldId>', field.id);

      // Test with default parameters
      await performHttpTest<DocumentSignatureFormField>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).updateSignatureFormField(
          documentId: '123',
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

      // Test with optional parameters
      await performHttpTest<DocumentSignatureFormField>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).updateSignatureFormField(
          documentId: '123',
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
      final n1App = getStandardN1App();
      final expectedUrlPath = http.apiPaths.documentsSignatureFormsByIdFieldsByFieldIdFormat
          .replaceFirst('<documentId>', '123')
          .replaceFirst('<documentSignatureFormId>', '234')
          .replaceFirst('<documentSignatureFormFieldId>', '345');

      await performHttpTest<void>(
        httpMethod: HttpMethods.DELETE,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).deleteSignatureFormField(
          documentId: '123',
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
      final n1App = getStandardN1App();
      final expectedUrlPath = http.apiPaths.documentsSignatureFormsByIdFieldsFormat
          .replaceFirst('<documentId>', '123')
          .replaceFirst('<documentSignatureFormId>', '234');

      await performHttpTest<void>(
        httpMethod: HttpMethods.DELETE,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).deleteAllSignatureFormFields(
          documentId: '123',
          signatureFormId: '234',
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '',
      );
    });

    test('getSignatureSessionPackage method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentsSignatureSessionPackagesFormat.replaceFirst('<documentId>', '123');
      final n1App = getStandardN1App();

      await performHttpTest<DocumentSignatureSessionPackage>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getSignatureSessionPackage(
          documentId: '123',
        ),
        responseBody: documentSignatureSessionPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('updateSignatureSessionPackages method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentsSignatureSessionPackagesFormat.replaceFirst('<documentId>', '123');
      final n1App = getStandardN1App();
      final packagesApiModel = api_mod.DocumentSignatureSessionPackageCollection.fromJson(
          jsonDecode(documentSignatureSessionPackageCollectionJson));
      final packages = DocumentSignatureSessionPackageCollection.fromApiModel(packagesApiModel);

      await performHttpTest<DocumentSignatureSessionPackageCollection>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).updateSignatureSessionPackages(
          documentId: '123',
          packages: packages,
        ),
        responseBody: documentSignatureSessionPackageCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: documentSignatureSessionPackageCollectionJson,
      );
    });

    test('getRecentSignatureForms method tests', () async {
      final expectedUrlPath = http.apiPaths.documentSignatureFormsRecent;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<DocumentSignatureFormCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getRecentSignatureForms(),
        responseBody: documentSignatureFormCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      // Test with optional parameters
      await performHttpTest<DocumentSignatureFormCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getRecentSignatureForms(
          docNameStartsWith: 'A',
          excludingId: 'B',
        ),
        responseBody: documentSignatureFormCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'nameFilter=A',
          'excludingId=B',
        ],
      );
    });

    test('getDocumentSignatureSessionSigningRecipientPackage method tests', () async {
      final expectedUrlPath = http.apiPaths.documentSignatureSessionsSigningRecipientsFieldsFormat
          .replaceFirst('<documentSignatureSessionId>', 'A')
          .replaceFirst('<documentSignatureSessionRecipientId>', 'B');
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<DocumentSignatureSessionSigningRecipientPackage>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            NucleusOneAppDocuments(app: n1App).getDocumentSignatureSessionSigningRecipientPackage(
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

      // Test with optional parameters
      await performHttpTest<DocumentSignatureSessionSigningRecipientPackage>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            NucleusOneAppDocuments(app: n1App).getDocumentSignatureSessionSigningRecipientPackage(
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
      final expectedUrlPath = http.apiPaths.documentSignatureSessionsSigningRecipientsFieldsFormat
          .replaceFirst('<documentSignatureSessionId>', 'A')
          .replaceFirst('<documentSignatureSessionRecipientId>', 'B');
      final n1App = getStandardN1App();
      final packagesApiModel =
          api_mod.DocumentSignatureSessionRecipientFormFieldCollection.fromJson(
              jsonDecode(documentSignatureSessionRecipientFormFieldCollectionJson));
      final fields =
          DocumentSignatureSessionRecipientFormFieldCollection.fromApiModel(packagesApiModel);

      await performHttpTest<void>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).signDocument(
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
