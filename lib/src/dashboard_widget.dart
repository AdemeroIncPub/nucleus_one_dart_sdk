import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serialization/serializers.dart';

part 'dashboard_widget.g.dart';

class DashboardWidgets {
  final items = <DashboardWidget>[];

  static DashboardWidgets fromJson(String jsonString) {
    // This JSON structure has an array at its root, which is not currently implicitly supported by built_value.
    // https://github.com/google/built_value.dart/issues/565

    final jsonDecoded = jsonDecode(jsonString);
    final itemsTemp = deserializeListOf<DashboardWidget>(jsonDecoded);

    final ret = DashboardWidgets();
    ret.items.addAll(itemsTemp);
    return ret;
  }
}

abstract class DashboardWidget implements Built<DashboardWidget, DashboardWidgetBuilder> {
  DashboardWidget._();

  factory DashboardWidget([Function(DashboardWidgetBuilder b) updates]) = _$DashboardWidget;

  @BuiltValueField(wireName: 'ID')
  String get id;
  @BuiltValueField(wireName: 'TenantID')
  String get tenantID;
  @BuiltValueField(wireName: 'TenantMemberID')
  String get tenantMemberID;
  @BuiltValueField(wireName: 'Type')
  String get type;
  @BuiltValueField(wireName: 'GridColumn')
  int get gridColumn;
  @BuiltValueField(wireName: 'ColumnRank')
  int get columnRank;
  @BuiltValueField(wireName: 'Name')
  String get name;
  @BuiltValueField(wireName: 'Detail')
  String get detail;
  @BuiltValueField(wireName: 'JsonData')
  String get jsonData;
  String toJson() {
    return json.encode(standardSerializers.serializeWith(DashboardWidget.serializer, this));
  }

  static DashboardWidget fromJson(String jsonString) {
    return standardSerializers.deserializeWith(DashboardWidget.serializer, json.decode(jsonString));
  }

  static Serializer<DashboardWidget> get serializer => _$dashboardWidgetSerializer;
}
