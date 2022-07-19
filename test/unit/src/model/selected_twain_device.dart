import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/selected_twain_device.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/selected_twain_device.dart';

void main() {
  group('SelectedTwainDevice class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.SelectedTwainDevice apiModel) {
        expect(apiModel.deviceSourceName, 'A');
        expect(apiModel.duplexType, 'B');
        expect(apiModel.inputSource, 'C');
        expect(apiModel.pixelType, 'D');
        expect(apiModel.resolution, 'E');
        expect(apiModel.size, 'F');
      }

      final apiModelOrig =
          api_mod.SelectedTwainDevice.fromJson(jsonDecode(selectedTwainDeviceJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = SelectedTwainDevice.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
