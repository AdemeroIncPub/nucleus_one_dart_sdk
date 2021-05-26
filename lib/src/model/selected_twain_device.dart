import 'package:get_it/get_it.dart';

import '../api_model/selected_twain_device.dart' as api_mod;
import '../nucleus_one.dart';

class SelectedTwainDevice with NucleusOneAppDependent {
  SelectedTwainDevice._(
      {NucleusOneAppInternal? app,
      required this.deviceSourceName,
      required this.duplexType,
      required this.inputSource,
      required this.pixelType,
      required this.resolution,
      required this.size}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory SelectedTwainDevice.fromApiModel(api_mod.SelectedTwainDevice apiModel) {
    return SelectedTwainDevice._(
        deviceSourceName: apiModel.deviceSourceName!,
        duplexType: apiModel.duplexType!,
        inputSource: apiModel.inputSource!,
        pixelType: apiModel.pixelType!,
        resolution: apiModel.resolution!,
        size: apiModel.size!);
  }

  String deviceSourceName;

  String duplexType;

  String inputSource;

  String pixelType;

  String resolution;

  String size;

  api_mod.SelectedTwainDevice toApiModel() {
    return api_mod.SelectedTwainDevice()
      ..deviceSourceName = deviceSourceName
      ..duplexType = duplexType
      ..inputSource = inputSource
      ..pixelType = pixelType
      ..resolution = resolution
      ..size = size;
  }
}
