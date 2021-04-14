// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_widget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardWidget _$DashboardWidgetFromJson(Map<String, dynamic> json) {
  return DashboardWidget()
    ..id = json['ID'] as String?
    ..tenantID = json['TenantID'] as String?
    ..tenantMemberID = json['TenantMemberID'] as String?
    ..type = json['Type'] as String?
    ..gridColumn = (json['GridColumn'] as num?)?.toDouble()
    ..columnRank = (json['ColumnRank'] as num?)?.toDouble()
    ..name = json['Name'] as String?
    ..detail = json['Detail'] as String?
    ..jsonData = json['JsonData'] as String?;
}

Map<String, dynamic> _$DashboardWidgetToJson(DashboardWidget instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('TenantID', instance.tenantID);
  writeNotNull('TenantMemberID', instance.tenantMemberID);
  writeNotNull('Type', instance.type);
  writeNotNull('GridColumn', instance.gridColumn);
  writeNotNull('ColumnRank', instance.columnRank);
  writeNotNull('Name', instance.name);
  writeNotNull('Detail', instance.detail);
  writeNotNull('JsonData', instance.jsonData);
  return val;
}
