import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/support_user.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_user.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/support_user.dart';

void main() {
  group('SupportUser tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.SupportUser), 7);
    });

    test('Serialization test', () async {
      void performTests(api_mod.SupportUser apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '0001-01-01T00:00:01Z');
        expect(apiModel.lastSignIn, '0001-01-01T00:00:01Z');
        expect(apiModel.lastActivity, '0001-01-01T00:00:01Z');
        expect(apiModel.email, 'B');
        expect(apiModel.provider, 'C');
        expect(apiModel.name, 'D');
      }

      final apiModelOrig = api_mod.SupportUser.fromJson(jsonDecode(supportUserJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = SupportUser.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('SupportUserCollection tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.SupportUserCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.SupportUserCollection> apiModel) {
        expect(apiModel.results!.supportUsers!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.SupportUserCollection>.fromJson(
          jsonDecode(supportUserCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.SupportUserCollection> apiModelCycled =
            SupportUserCollectionQueryResult.fromApiModelSupportUserCollection(apiModelOrig)
                .toApiModel<api_mod.SupportUserCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
