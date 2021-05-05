import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'mocks/http.dart';

Future<void> performHttpTest<T>({
  required String httpMethod,
  required Future<T> Function() httpCallCallback,
  required String responseBody,
  required String expectedUrlPath,
  required List<String> expectedQueryParams,
  String? expectedBody,
  void Function(T modelEntity)? additionalValidationsCallback,
}) async {
  final result = await createMockHttpClientScopeForGetRequest(
    callback: () async {
      final modelEntity = await httpCallCallback();

      // If T isn't the void type then the returned value should be an instance of T
      if (T.toString() != 'void') {
        expect(modelEntity, isNotNull);
      }
      if (modelEntity is QueryResult2) {
        validateQueryResult2(modelEntity, 'A', 24, 'B');
      } else if (modelEntity is QueryResult) {
        validateQueryResult(modelEntity, 'A', 24);
      }
      if (additionalValidationsCallback != null) {
        additionalValidationsCallback(modelEntity);
      }
    },
    responseBody: responseBody,
  );

  expect(result.request.method, httpMethod);
  expect(result.request.uri.path, apiRequestPathMatches(expectedUrlPath));
  expect(result.request.uri.queryParameters.length, expectedQueryParams.length,
      reason: 'Details:\r\n  Expected (in any order): ' +
          expectedQueryParams.join(',') +
          '\r\n  Actual: ' +
          result.request.uri.queryParameters.entries.map((x) => x.key + '=' + x.value).join(','));
  if (expectedBody != null) {
    expect(result.request.getBodyAsString(), expectedBody);
  }

  final reqUriQuery = result.request.uri.query;
  for (var expectedQP in expectedQueryParams) {
    expect(reqUriQuery, matches('\\b' + expectedQP + '\\b'));
  }
}

void validateIApiModelPagingCursor(IApiModelPagingCursor o, dynamic cursor, dynamic pageSize) {
  expect(o.cursor, cursor);
  expect(o.pageSize, pageSize);
}

void validateIApiModelPagingCursor2(
    IApiModelPagingCursor2 o, dynamic cursor, dynamic pageSize, dynamic reverseCursor) {
  validateIApiModelPagingCursor(o, cursor, pageSize);
  expect(o.reverseCursor, reverseCursor);
}

void validateQueryResult(QueryResult o, dynamic cursor, dynamic pageSize) {
  expect(o.cursor, cursor);
  expect(o.pageSize, pageSize);
}

void validateQueryResult2(QueryResult2 o, dynamic cursor, dynamic pageSize, dynamic reverseCursor) {
  validateQueryResult(o, cursor, pageSize);
  expect(o.reverseCursor, reverseCursor);
}
