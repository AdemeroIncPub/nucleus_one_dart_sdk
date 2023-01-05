import 'package:test/test.dart';

import 'common.dart';
import 'mocks/http.dart';

Future<void> performHttpTests<T>({
  required Future<T> Function() httpCallCallback,
  void Function(T resultEntity)? additionalValidationsCallback,
  required List<HttpOperation> httpOperationsOrdered,
}) async {
  final results = await createStandardMockHttpClientScopeForAllRequests2(
    httpOperations: httpOperationsOrdered,
    callback: () async {
      final resultEntity = await httpCallCallback();

      if (additionalValidationsCallback != null) {
        additionalValidationsCallback(resultEntity);
      }
    },
    additionalMockSetup: null,
  );

  final resultCount = results.length;
  expect(resultCount, httpOperationsOrdered.length);

  for (var i = 0; i < resultCount; ++i) {
    final result = results[i];
    final httpOp = httpOperationsOrdered[i];

    expect(result.request.method, httpOp.requestHttpMethod);
    if (httpOp.isN1ApiOperation) {
      expect(result.request.uri.path, apiRequestPathMatches(httpOp.requestUrl.toString()));
    } else {
      expect(result.request.uri.path, httpOp.requestUrl.toString());
    }
    expect(result.request.uri.queryParameters.length, httpOp.requestQueryParams.length,
        reason: 'Details:\r\n  Expected (in any order): ${httpOp.requestQueryParams.join(',')}\r\n' +
            'Actual: ${result.request.uri.queryParameters.entries.map((x) => '${x.key}=${x.value}').join(',')}');
    expect(result.request.getBodyAsString(), httpOp.requestBody);

    final reqUriQuery = result.request.uri.query;
    for (var expectedQP in httpOp.requestQueryParams) {
      expect(reqUriQuery, matches('\\b${RegExp.escape(expectedQP)}\\b'));
    }
  }
}
