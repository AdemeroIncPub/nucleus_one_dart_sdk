import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'dashboard_widget.g.dart';

class DashboardWidgets {
  final items = <DashboardWidget>[];

  static DashboardWidgets fromJson(String jsonString) {
    // This JSON structure has an array at its root, which is not currently implicitly supported by json_serializable.
    // https://github.com/google/json_serializable.dart/issues/648

    final jsonDecodedList = jsonDecode(jsonString) as List;
    final ret = DashboardWidgets();
    ret.items.addAll(jsonDecodedList.map((m) => DashboardWidget.fromJson(m)));
    return ret;
  }
}

// Serializable members must be explicitly marked with [JsonKey]
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class DashboardWidget {
  @JsonKey(name: 'ID')
  String id;
  @JsonKey(name: 'TenantID')
  String tenantID;
  @JsonKey(name: 'TenantMemberID')
  String tenantMemberID;
  @JsonKey(name: 'Type')
  String type;
  @JsonKey(name: 'GridColumn')
  int gridColumn;
  @JsonKey(name: 'ColumnRank')
  int columnRank;
  @JsonKey(name: 'Name')
  String name;
  @JsonKey(name: 'Detail')
  String detail;
  @JsonKey(name: 'JsonData')
  String jsonData;

  DashboardWidget();

  factory DashboardWidget.forRankUpdate(String id, int gridColumn, int columnRank) {
    return DashboardWidget()
      ..id = id
      ..gridColumn = gridColumn
      ..columnRank = columnRank;
  }

  /// A necessary factory constructor for creating a new DashboardWidget instance
  /// from a map. Pass the map to the generated `_$DashboardWidgetFromJson()` constructor.
  /// The constructor is named after the source class, in this case, DashboardWidget.
  factory DashboardWidget.fromJson(Map<String, dynamic> json) => _$DashboardWidgetFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CameraPreferencesToJson`.
  Map<String, dynamic> toJson() => _$DashboardWidgetToJson(this);
}