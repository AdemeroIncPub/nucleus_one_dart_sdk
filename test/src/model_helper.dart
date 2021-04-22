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
  var result = await createMockHttpClientScopeForGetRequest(
    callback: () async {
      final modelEntity = await httpCallCallback();
      if (modelEntity is IModelPagingCursor2) {
        validateIModelPagingCursor2(modelEntity, 'A', 24, 'B');
      } else if (modelEntity is IModelPagingCursor) {
        validateIModelPagingCursor(modelEntity, 'A', 24);
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

void validateIModelPagingCursor(IModelPagingCursor o, dynamic cursor, dynamic pageSize) {
  expect(o.cursor, cursor);
  expect(o.pageSize, pageSize);
}

void validateIModelPagingCursor2(
    IModelPagingCursor2 o, dynamic cursor, dynamic pageSize, dynamic reverseCursor) {
  validateIModelPagingCursor(o, cursor, pageSize);
  expect(o.reverseCursor, reverseCursor);
}
