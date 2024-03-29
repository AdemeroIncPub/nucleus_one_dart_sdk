import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';

part 'selected_twain_device.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class SelectedTwainDevice extends Entity {
  SelectedTwainDevice();

  /// A necessary factory constructor for creating a new SelectedTwainDevice instance
  /// from a map. Pass the map to the generated [_$SelectedTwainDeviceFromJson()] constructor.
  /// The constructor is named after the source class, in this case, SelectedTwainDevice.
  factory SelectedTwainDevice.fromJson(Map<String, dynamic> json) =>
      _$SelectedTwainDeviceFromJson(json);

  @JsonKey(name: 'DeviceSourceName')
  String? deviceSourceName;

  @JsonKey(name: 'DuplexType')
  String? duplexType;

  @JsonKey(name: 'InputSource')
  String? inputSource;

  @JsonKey(name: 'PixelType')
  String? pixelType;

  @JsonKey(name: 'Resolution')
  String? resolution;

  @JsonKey(name: 'Size')
  String? size;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$SelectedTwainDeviceToJson].
  @override
  Map<String, dynamic> toJson() => _$SelectedTwainDeviceToJson(this);
  // coverage:ignore-end
}
