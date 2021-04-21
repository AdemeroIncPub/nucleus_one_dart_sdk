import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/document.dart' as mod;
import 'package:nucleus_one_dart_sdk/src/model/document_comments.dart' as mod;
import 'package:test/test.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import 'document_comments.dart';
import 'document_results.dart';

const documentJson =
    r'{"UniqueID":"A","DocumentID":"B","CreatedOn":"2021-01-06T17:37:32.327396Z","PurgeDate":"0001-01-31T00:00:00Z","Name":"C","PageCount":21,"FileSize":1234,"ThumbnailUrl":"D","IsSigned":false,"ClassificationID":"E","ClassificationName":"F","PreviewMetadata":[{"0":"A","1":"B","2":"C"}],"DocumentApprovalID":"G","DocumentApprovalCreatedOn":"0001-01-01T00:00:00Z","DocumentSubscriptionID":"H","DocumentSubscriptionCreatedOn":"0001-01-01T00:00:00Z","DocumentSignatureSessionRecipientID":"I","DocumentSignatureSessionID":"J","DocumentSignatureSessionRecipientEmail":"K","DocumentSignatureSessionRecipientFullName":"L","DocumentSignatureSessionRecipientRequestedOn":"0001-01-01T00:00:00Z","RoleName":"M","ProcessName":"N","ProcessElementName":"O","Score":123}';

void main() {
  group('Document tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.Document apiModel) {
        expect(apiModel.uniqueID, 'A');
        expect(apiModel.documentID, 'B');
        expect(apiModel.createdOn, '2021-01-06T17:37:32.327396Z');
        expect(apiModel.purgeDate, '0001-01-31T00:00:00Z');
        expect(apiModel.name, 'C');
        expect(apiModel.pageCount, 21);
        expect(apiModel.fileSize, 1234);
        expect(apiModel.thumbnailUrl, 'D');
        expect(apiModel.isSigned, false);
        expect(apiModel.classificationID, 'E');
        expect(apiModel.classificationName, 'F');
        expect(apiModel.previewMetadata, isNotNull);
        expect(apiModel.previewMetadata!.length, 1);
        expect(apiModel.documentApprovalID, 'G');
        expect(apiModel.documentApprovalCreatedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.documentSubscriptionID, 'H');
        expect(apiModel.documentSubscriptionCreatedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.documentSignatureSessionRecipientID, 'I');
        expect(apiModel.documentSignatureSessionID, 'J');
        expect(apiModel.documentSignatureSessionRecipientEmail, 'K');
        expect(apiModel.documentSignatureSessionRecipientFullName, 'L');
        expect(apiModel.documentSignatureSessionRecipientRequestedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.roleName, 'M');
        expect(apiModel.processName, 'N');
        expect(apiModel.processElementName, 'O');
        expect(apiModel.score, 123);
      }

      final apiModelOrig = api_mod.Document.fromJson(jsonDecode(documentJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = mod.Document.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });

    group('_getRecentInternal method consumers tests', () {
      void verifyDocumentResultsCommon(DocumentResults rd) {
        expect(rd.cursor, isNotNull);
        expect(rd.documents.length, 1);
        expect(rd.pageSize, 24);
      }

      void verifyHttpClientOperationResultsCommon(
        HttpClientOperationResult result, [
        int expectedQueryParamCount = 2,
        String sortType = 'CreatedOn',
        bool sortDescending = true,
      ]) {
        expect(result.request.method, HttpMethods.GET);
        expect(result.request.uri.path, apiRequestPathMatches(http.apiPaths.documents));
        final reqUriQuery = result.request.uri.query;
        expect(result.request.uri.queryParameters.length, expectedQueryParamCount);
        expect(reqUriQuery, matches(r'\bsortType=' + sortType + r'\b'));
        expect(reqUriQuery, matches(r'\bsortDescending=' + sortDescending.toString() + r'\b'));
      }

      Future<void> makeHttpCall(Future<DocumentResults> Function() getRecentMethodCallback) async {
        final recent = await getRecentMethodCallback();
        verifyDocumentResultsCommon(recent);
      }

      test('_getRecentInternal method tests', () async {
        // These tests make use of the getRecent method to invoke _getRecentInternal, but the focus
        // of these tests are on _getRecentInternal, not getRecent; its tests are further down

        // Test with default parameters
        var result = await createMockHttpClientScopeForGetRequest(
          callback: () => makeHttpCall(Document().getRecent),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result);

        // Test with custom sorting
        result = await createMockHttpClientScopeForGetRequest(
          callback: () =>
              makeHttpCall(() => Document().getRecent(sortType: 'A', sortDescending: false)),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result, 2, 'A', false);

        // Test with optional arguments
        result = await createMockHttpClientScopeForGetRequest(
          callback: () =>
              makeHttpCall(() => Document().getRecent(offset: 1, cursor: 'B', singleRecord: true)),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result, 5);
        expect(result.request.uri.query, matches(r'\boffset=1\b'));
        expect(result.request.uri.query, matches(r'\bcursor=B\b'));
        expect(result.request.uri.query, matches(r'\bsingleRecord=true\b'));
      });

      test('getRecent method test', () async {
        // Test with default parameters
        var result = await createMockHttpClientScopeForGetRequest(
          callback: () => makeHttpCall(Document().getRecent),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result);

        // Test with custom sorting
        result = await createMockHttpClientScopeForGetRequest(
          callback: () =>
              makeHttpCall(() => Document().getRecent(sortType: 'A', sortDescending: false)),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result, 2, 'A', false);
      });

      test('getApprovalsRecent method test', () async {
        // Test with default parameters
        var result = await createMockHttpClientScopeForGetRequest(
          callback: () => makeHttpCall(() => Document().getApprovalsRecent()),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result, 3);
        expect(result.request.uri.query, matches(r'\bdocumentApprovals=true\b'));

        // Test with custom sorting
        result = await createMockHttpClientScopeForGetRequest(
          callback: () => makeHttpCall(
              () => Document().getApprovalsRecent(sortType: 'A', sortDescending: false)),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result, 3, 'A', false);
        expect(result.request.uri.query, matches(r'\bdocumentApprovals=true\b'));

        // Test with showForAllInProject = true
        result = await createMockHttpClientScopeForGetRequest(
          callback: () => makeHttpCall(() => Document().getApprovalsRecent(
              showForAllInProject: true, processID: '123', processElementID: '234')),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result, 4);
        expect(result.request.uri.query, matches(r'\bdocumentApprovals=true\b'));
        expect(result.request.uri.query, matches(r'\bshowForAllInProject=true\b'));

        // Test with showForAllInProject = null and = false
        for (var showForAllInProject in [false, null]) {
          result = await createMockHttpClientScopeForGetRequest(
            callback: () => makeHttpCall(() => Document().getApprovalsRecent(
                showForAllInProject: showForAllInProject,
                processID: '123',
                processElementID: '234')),
            responseBody: documentResultsJson,
          );

          if (showForAllInProject == null) {
            verifyHttpClientOperationResultsCommon(result, 5);
          } else {
            verifyHttpClientOperationResultsCommon(result, 6);
            expect(result.request.uri.query, matches(r'\bshowForAllInProject=false\b'));
          }
          expect(result.request.uri.query, matches(r'\bdocumentApprovals=true\b'));
          expect(result.request.uri.query, matches(r'\bprocessID=123\b'));
          expect(result.request.uri.query, matches(r'\bprocessElementID=234\b'));
        }
      });

      test('getInboxRecent method test', () async {
        // Test with default parameters
        var result = await createMockHttpClientScopeForGetRequest(
          callback: () => makeHttpCall(() => Document().getInboxRecent()),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result, 3);
        expect(result.request.uri.query, matches(r'\binbox=true\b'));

        // Test with custom sorting
        result = await createMockHttpClientScopeForGetRequest(
          callback: () =>
              makeHttpCall(() => Document().getInboxRecent(sortType: 'A', sortDescending: false)),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result, 3, 'A', false);
        expect(result.request.uri.query, matches(r'\binbox=true\b'));
      });

      test('getDocumentSubscriptionsRecent method test', () async {
        // Test with default parameters
        var result = await createMockHttpClientScopeForGetRequest(
          callback: () => makeHttpCall(() => Document().getDocumentSubscriptionsRecent()),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result, 3);
        expect(result.request.uri.query, matches(r'\bdocumentSubscriptions=true\b'));

        // Test with custom sorting
        result = await createMockHttpClientScopeForGetRequest(
          callback: () => makeHttpCall(() =>
              Document().getDocumentSubscriptionsRecent(sortType: 'A', sortDescending: false)),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result, 3, 'A', false);
        expect(result.request.uri.query, matches(r'\bdocumentSubscriptions=true\b'));
      });

      test('getRecycleBinRecent method test', () async {
        // Test with default parameters
        var result = await createMockHttpClientScopeForGetRequest(
          callback: () => makeHttpCall(() => Document().getRecycleBinRecent()),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result, 3);
        expect(result.request.uri.query, matches(r'\brecycleBin=true\b'));

        // Test with custom sorting
        result = await createMockHttpClientScopeForGetRequest(
          callback: () => makeHttpCall(
              () => Document().getRecycleBinRecent(sortType: 'A', sortDescending: false)),
          responseBody: documentResultsJson,
        );

        verifyHttpClientOperationResultsCommon(result, 3, 'A', false);
        expect(result.request.uri.query, matches(r'\brecycleBin=true\b'));
      });
    });

    test('getComments method tests', () async {
      final expectedPath =
          http.apiPaths.documentsCommentsFormat.replaceFirst('<documentId>', '123');

      Future<void> performTest(Future<mod.DocumentComments> Function() getCommentsCallback,
          List<String> expectedQueryParams) async {
        var result = await createMockHttpClientScopeForGetRequest(
          callback: () async {
            final dc = await getCommentsCallback();
            expect(dc.cursor, isNotNull);
            expect(dc.documentEvents.length, 1);
            expect(dc.pageSize, 24);
          },
          responseBody: documentCommentsJson,
        );

        expect(result.request.method, HttpMethods.GET);
        expect(result.request.uri.path, apiRequestPathMatches(expectedPath));
        expect(result.request.uri.queryParameters.length, expectedQueryParams.length);
        var reqUriQuery = result.request.uri.query;

        for (var expectedQP in expectedQueryParams) {
          expect(reqUriQuery, matches('\\b' + expectedQP + '\\b'));
        }
      }

      // Test with default parameters
      await performTest(
        () => Document().getComments(documentId: '123'),
        ['sortDescending=true'],
      );

      // Test with custom sorting and optional arguments
      await performTest(
        () => Document().getComments(documentId: '123', sortDescending: false, cursor: 'A'),
        ['sortDescending=false', 'cursor=A'],
      );
    });
  });
}
