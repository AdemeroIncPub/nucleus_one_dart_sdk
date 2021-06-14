import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
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

void main() {
  group('NucleusOneAppDocuments class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });
    
    test('getCount method tests', () async {
      final n1App = getStandardN1App();
      await performHttpTest<int>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getCount(true, false),
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
  });
}
