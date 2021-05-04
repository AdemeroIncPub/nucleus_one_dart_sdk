import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';

import '../api_model/dashboard_widget.dart' as api_model;
import '../nucleus_one.dart';

class DashboardWidgetCollection extends EntityCollection<DashboardWidget> {
  DashboardWidgetCollection({
    NucleusOneAppInternal? app,
    List<DashboardWidget>? items,
  }) : super(app: app, items: items);

  factory DashboardWidgetCollection.fromApiModel(api_model.DashboardWidgetCollection apiModel) {
    return DashboardWidgetCollection(
        items: apiModel.items.map((x) => DashboardWidget.fromApiModel(x)).toList());
  }

  api_model.DashboardWidgetCollection toApiModel() {
    return api_model.DashboardWidgetCollection()..items = items.map((x) => x.toApiModel()).toList();
  }
}

class DashboardWidget with NucleusOneAppDependent {
  DashboardWidget._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.tenantID,
      required this.tenantMemberID,
      required this.type,
      required this.gridColumn,
      required this.columnRank,
      required this.name,
      required this.detail,
      required this.jsonData}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DashboardWidget.fromApiModel(api_model.DashboardWidget apiModel) {
    return DashboardWidget._(
        id: apiModel.id!,
        tenantID: apiModel.tenantID!,
        tenantMemberID: apiModel.tenantMemberID!,
        type: apiModel.type!,
        gridColumn: apiModel.gridColumn!,
        columnRank: apiModel.columnRank!,
        name: apiModel.name!,
        detail: apiModel.detail!,
        jsonData: apiModel.jsonData!);
  }

  String id;

  String tenantID;

  String tenantMemberID;

  String type;

  double gridColumn;

  double columnRank;

  String name;

  String detail;

  String jsonData;

  api_model.DashboardWidget toApiModel() {
    return api_model.DashboardWidget()
      ..id = id
      ..tenantID = tenantID
      ..tenantMemberID = tenantMemberID
      ..type = type
      ..gridColumn = gridColumn
      ..columnRank = columnRank
      ..name = name
      ..detail = detail
      ..jsonData = jsonData;
  }
}
