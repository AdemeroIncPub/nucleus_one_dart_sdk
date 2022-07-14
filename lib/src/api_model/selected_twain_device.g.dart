// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_twain_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectedTwainDevice _$SelectedTwainDeviceFromJson(Map<String, dynamic> json) =>
    SelectedTwainDevice()
      ..deviceSourceName = json['DeviceSourceName'] as String?
      ..duplexType = json['DuplexType'] as String?
      ..inputSource = json['InputSource'] as String?
      ..pixelType = json['PixelType'] as String?
      ..resolution = json['Resolution'] as String?
      ..size = json['Size'] as String?;

Map<String, dynamic> _$SelectedTwainDeviceToJson(SelectedTwainDevice instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('DeviceSourceName', instance.deviceSourceName);
  writeNotNull('DuplexType', instance.duplexType);
  writeNotNull('InputSource', instance.inputSource);
  writeNotNull('PixelType', instance.pixelType);
  writeNotNull('Resolution', instance.resolution);
  writeNotNull('Size', instance.size);
  return val;
}
