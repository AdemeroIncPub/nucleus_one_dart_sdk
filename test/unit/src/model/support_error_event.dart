import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/support_error_event.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_error_event.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/support_error_event.dart';

void main() {
  group('SupportErrorEvent tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.SupportErrorEvent), 17);
    });

    test('Serialization test', () async {
      void performTests(api_mod.SupportErrorEvent apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '0001-01-01T00:00:01Z');
        expect(apiModel.tenantID, 'B');
        expect(apiModel.tenantName, 'C');
        expect(apiModel.tenantNameLower, 'D');
        expect(apiModel.userEmailLower, 'E');
        expect(apiModel.userID, 'F');
        expect(apiModel.serviceNameLower, 'G');
        expect(apiModel.level, 'H');
        expect(apiModel.uniqueID, 'I');
        expect(apiModel.requestURI, 'J');
        expect(apiModel.header, 'K');
        expect(apiModel.message, 'L');
        expect(apiModel.clientMessage, 'M');
        expect(apiModel.httpStatus, 0);
        expect(apiModel.otherValues, ['A', 'B']);
        expect(apiModel.wordsLower, ['A', 'B', 'C']);
      }

      final apiModelOrig = api_mod.SupportErrorEvent.fromJson(jsonDecode(supportErrorEventJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = SupportErrorEvent.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
  group('SupportErrorEventCollection tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.SupportErrorEventCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.SupportErrorEventCollection> apiModel) {
        expect(apiModel.results!.supportErrorEvents!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.SupportErrorEventCollection>.fromJson(
          jsonDecode(supportErrorEventCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.SupportErrorEventCollection> apiModelCycled =
            SupportErrorEventCollectionQueryResult.fromApiModelSupportErrorEventCollection(
                    apiModelOrig)
                .toApiModel<api_mod.SupportErrorEventCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
