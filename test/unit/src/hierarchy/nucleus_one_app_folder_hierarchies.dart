import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/folder_hierarchies.dart';

void main() {
  group('NucleusOneAppFolderHierarchies class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('get method tests', () async {
      final expectedUrlPath = http.apiPaths.folderHierarchies;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<FolderHierarchyCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFolderHierarchies(app: n1App).get(),
        responseBody: folderHierarchyCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedQueryResultPageSize: 0,
      );

      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<FolderHierarchyCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFolderHierarchies(app: n1App).get(
          cursor: 'A',
          getAll: true,
        ),
        responseBody: folderHierarchyCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'cursor=A',
          'getAll=true',
        ],
        expectedQueryResultPageSize: 0,
      );
    });

    test('getById method tests', () async {
      final expectedUrlPath =
          http.apiPaths.folderHierarchiesFormat.replaceFirst('<folderHierarchyId>', '123');
      final n1App = getStandardN1App();

      await performHttpTest<FolderHierarchy>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFolderHierarchies(app: n1App).getById('123'),
        responseBody: folderHierarchyJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getItemsById method tests', () async {
      final expectedUrlPath =
          http.apiPaths.folderHierarchiesItemsFormat.replaceFirst('<folderHierarchyId>', '123');
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<FolderHierarchyItemCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFolderHierarchies(app: n1App).getItemsById('123'),
        responseBody: folderHierarchyItemCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      // Test with cursor and optional arguments
      await performHttpTest<FolderHierarchyItemCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFolderHierarchies(app: n1App).getItemsById(
          '123',
          cursor: 'A',
          getAll: true,
        ),
        responseBody: folderHierarchyItemCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'cursor=A',
          'getAll=true',
        ],
      );
    });

    test('getItemById method tests', () async {
      final expectedUrlPath = http.apiPaths.folderHierarchiesItemsItemFormat
          .replaceFirst('<folderHierarchyId>', '123')
          .replaceFirst('<folderHierarchyItemId>', '456');
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<FolderHierarchyItem>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            NucleusOneAppFolderHierarchies(app: n1App).getItemById('123', '456'),
        responseBody: folderHierarchyItemJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      // Test with cursor and optional arguments
      await performHttpTest<FolderHierarchyItem>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFolderHierarchies(app: n1App).getItemById(
          '123',
          '456',
          cursor: 'A',
          getAll: true,
        ),
        responseBody: folderHierarchyItemJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'cursor=A',
          'getAll=true',
        ],
      );
    });
  });
}
