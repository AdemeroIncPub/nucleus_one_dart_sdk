import 'dart:convert';

import 'package:meta/meta.dart';

import 'address_book.dart';
import 'common/string.dart';
import 'dashboard_widget.dart';
import 'http.dart' as http;
import 'http.dart';
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

  /// Gets all of the user's Dashboard widgets.
  Future<DashboardWidgets> getDashboardWidgets() async {
    final responseBody =
        await http.executeGetRequestWithTextResponse(http.apiPaths.dashboardWidgets, app);
    return DashboardWidgets.fromJson(responseBody);
  }

  /// Deletes one or more of the user's Dashboard widgets.
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

  // /// Updates a Dashboard widget for the user.
  // Future<void> updateDashboardWidget(String id, DashboardWidget widget) async {
  //   assert(widget != null);

  //   final bodyMap = widget;
  //   await http.executePutRequest(
  //     http.apiPaths.dashboardWidgets + '/' + id,
  //     app,
  //     body: jsonEncode(bodyMap),
  //   );
  // }

  /// Updates the positions of one or more of the user's Dashboard widgets.  Only the widgets changing
  /// position should be provided.
  Future<void> updateDashboardWidgetRanks(List<DashboardWidget> widgets) async {
    assert(widgets != null);
    assert(widgets.isNotEmpty);

    final bodyList = widgets;
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
