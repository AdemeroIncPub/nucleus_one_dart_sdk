import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:test/test.dart';

import 'http_helper.dart' as http_helper;

Future<void> performHttpTest<T>({
  required String httpMethod,
  required Future<T> Function() httpCallCallback,
  required String responseBody,
  Map<String, String>? responseCookies,
  required String expectedUrlPath,
  required List<String> expectedQueryParams,
  String? expectedBody,
  void Function(T resultEntity)? additionalValidationsCallback,
}) async {
  // Use the stock performHttpTest method, passing in additional tests specific to the model
  return http_helper.performHttpTest<T>(
    httpMethod: httpMethod,
    httpCallCallback: httpCallCallback,
    responseBody: responseBody,
    responseCookies: responseCookies,
    expectedUrlPath: expectedUrlPath,
    expectedQueryParams: expectedQueryParams,
    expectedBody: expectedBody,
    additionalValidationsCallback: (resultEntity) {
      // If T isn't the void type then the returned value should be an instance of T
      if (T.toString() != 'void') {
        expect(resultEntity, isNotNull);
      }
      if (resultEntity is QueryResult2) {
        validateQueryResult2(resultEntity, 'QueryResultA', 24, 'QueryResultB');
      } else if (resultEntity is QueryResult) {
        validateQueryResult(resultEntity, 'QueryResultA', 24);
      }

      if (additionalValidationsCallback != null) {
        additionalValidationsCallback(resultEntity);
      }
    },
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
