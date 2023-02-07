import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/selected_twain_device.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/selected_twain_device.dart';

void main() {
  group('SelectedTwainDevice class tests', () {
    performStandardModelTests<SelectedTwainDevice, api_mod.SelectedTwainDevice>(
      apiModelJson: selectedTwainDeviceJson,
      expectedPublicFieldCount: 6,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.deviceSourceName: 'A',
        apiModel.duplexType: 'B',
        apiModel.inputSource: 'C',
        apiModel.pixelType: 'D',
        apiModel.resolution: 'E',
        apiModel.size: 'F',
      },
    );
  });
}
