import 'dart:io';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:test/test.dart';

import 'http_helper.dart' as http_helper;
import 'mocks/http.dart';

Future<void> performHttpTest<T>({
  required String httpMethod,
  required Future<T> Function() httpCallCallback,
  required String responseBody,
  Map<String, String>? responseCookies,
  required String expectedRequestUrlPath,
  required List<String> expectedRequestQueryParams,
  String? expectedRequestBody,
  int? expectedResultQueryResultPageSize = 24,
  String? expectedResultQueryResultCursor = 'QueryResultA',
  String? expectedResultQueryResultReverseCursor = 'QueryResultB',
  void Function(T resultEntity)? additionalValidationsCallback,
}) async {
  final httpOperation = HttpOperation(
    requestUrl: Uri.parse(expectedRequestUrlPath),
    requestHttpMethod: httpMethod,
    requestBody: expectedRequestBody ?? '',
    requestQueryParams: expectedRequestQueryParams,
    responseBody: responseBody,
    responseHttpStatus: HttpStatus.ok,
    responseCookies: responseCookies,
  );

  return performHttpTests<T>(
    httpMethod: httpMethod,
    httpCallCallback: httpCallCallback,
    httpOperationsOrdered: [httpOperation],
    expectedResultQueryResultPageSize: expectedResultQueryResultPageSize,
    expectedResultQueryResultCursor: expectedResultQueryResultCursor,
    expectedResultQueryResultReverseCursor: expectedResultQueryResultReverseCursor,
    additionalValidationsCallback: additionalValidationsCallback,
  );
}

Future<void> performHttpTests<T>({
  required String httpMethod,
  required Future<T> Function() httpCallCallback,
  int? expectedResultQueryResultPageSize = 24,
  String? expectedResultQueryResultCursor = 'QueryResultA',
  String? expectedResultQueryResultReverseCursor = 'QueryResultB',
  void Function(T resultEntity)? additionalValidationsCallback,
  required List<HttpOperation> httpOperationsOrdered,
}) async {
  // Use the stock performHttpTest method, passing in additional tests specific to the model
  return http_helper.performHttpTests<T>(
    httpCallCallback: httpCallCallback,
    additionalValidationsCallback: (resultEntity) {
      // If T isn't the void type then the returned value should be an instance of T
      if (T.toString() != 'void') {
        expect(resultEntity, isNotNull);
      }
      if (resultEntity is QueryResult2) {
        validateQueryResult2(resultEntity, expectedResultQueryResultCursor,
            expectedResultQueryResultPageSize, expectedResultQueryResultReverseCursor);
      } else if (resultEntity is QueryResult) {
        validateQueryResult(
            resultEntity, expectedResultQueryResultCursor, expectedResultQueryResultPageSize);
      }

      if (additionalValidationsCallback != null) {
        additionalValidationsCallback(resultEntity);
      }
    },
    httpOperationsOrdered: httpOperationsOrdered,
  );
}

void validateQueryResult(QueryResult o, dynamic cursor, dynamic pageSize) {
  expect(o.cursor, cursor);
  expect(o.pageSize, pageSize);
}

void validateQueryResult2(QueryResult2 o, dynamic cursor, dynamic pageSize, dynamic reverseCursor) {
  validateQueryResult(o, cursor, pageSize);
  expect(o.reverseCursor, reverseCursor);
}
