import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:nucleus_one_dart_sdk/src/dashboard_widget.dart';

import 'address_book.dart';
import 'common/string.dart';
import 'http.dart' as http;
import 'nucleus_one.dart';

class User with NucleusOneAppDependent {
  User({
    @required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Gets all items in the user's address book.
  Future<AddressBook> getAddressBook({
    bool includeTenantMembers = true,
    bool includeRoles = true,
    bool includeFields = true,
    bool includeFormTemplateFields = true,
    String filter,
  }) async {
    final qp = <String, dynamic>{
      'includeTenantMembers': includeTenantMembers ?? true,
      'includeRoles': includeRoles ?? true,
      'includeFields': includeFields ?? true,
      'includeFormTemplateFields': includeFormTemplateFields ?? true,
    };
    if (isNotEmpty(filter)) {
      qp['filter'] = filter;
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.addressBookItems,
      app,
      query: qp,
    );

    return AddressBook.fromJson(responseBody);
  }

  /// Clears the user's address book items.
  Future<void> clearAddressBook() async {
    await http.executeDeleteRequest(http.apiPaths.addressBookItems, app);
  }

  /// Gets the user's Dashboard widgets.
  Future<DashboardWidgets> getDashboardWidgets() async {
    final responseBody =
        await http.executeGetRequestWithTextResponse(http.apiPaths.dashboardWidgets, app);
    return DashboardWidgets.fromJson(responseBody);
  }

  /// Deletes the user's Dashboard widget.
  Future<void> deleteDashboardWidgets(List<String> ids) async {
    assert(ids != null);

    final bodyMap = {
      'IDs': ids,
    };
    await http.executeDeleteRequest(
      http.apiPaths.dashboardWidgets,
      app,
      body: jsonEncode(bodyMap),
    );
  }

  /// Creates or updates a Dashboard widget for the user.
  Future<void> createOrUpdateDashboardWidget(
      String id, DashboardWidgetToUpdate dashboardWidgetToUpdate) async {
    assert(dashboardWidgetToUpdate != null);

    final bodyMap = dashboardWidgetToUpdate;
    await http.executePutRequest(
      http.apiPaths.dashboardWidgets + '/' + id,
      app,
      body: jsonEncode(bodyMap),
    );
  }

  /// Updates the user's Dashboard widgets.
  Future<void> updateDashboardWidgetRanks(List<DashboardWidgetToUpdate> widgetsToUpdate) async {
    assert(widgetsToUpdate != null);
    assert(widgetsToUpdate.isNotEmpty);

    final bodyList = widgetsToUpdate;
    await http.executePutRequest(
      http.apiPaths.dashboardWidgets,
      app,
      query: {
        'onlyRank': true,
      },
      body: jsonEncode(bodyList),
    );
  }
}

abstract class ApiRequestBodyObject {
  @protected
  final map = <String, dynamic>{};

  Map<String, dynamic> toJson() => map;
}

class DashboardWidgetToUpdate extends ApiRequestBodyObject {
  String get id => map['ID'];
  set id(String value) => map['ID'] = value;

  String get type => map['Type'];
  set type(String value) => map['Type'] = value;

  String get name => map['Name'];
  set name(String value) => map['Name'] = value;

  int get gridColumn => map['GridColumn'] as int;
  set gridColumn(int value) => map['GridColumn'] = value;

  int get columnRank => map['ColumnRank'] as int;
  set columnRank(int value) => map['ColumnRank'] = value;

  String get jsonData => map['JsonData'];
  set jsonData(String value) => map['JsonData'] = value;

  DashboardWidgetToUpdate(String id) {
    this.id = id;
  }

  factory DashboardWidgetToUpdate.forRankUpdate(String id, int gridColumn, int columnRank) {
    return DashboardWidgetToUpdate(id)
      ..gridColumn = gridColumn
      ..columnRank = columnRank;
  }
}
