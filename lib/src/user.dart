import 'dart:convert';

import 'package:get_it/get_it.dart';

import 'api_model/address_book.dart' as api_mod;
import 'api_model/dashboard_widget.dart' as api_mod;
import 'api_model/user_profile.dart' as api_mod;
import 'common/string.dart';
import 'http.dart' as http;
import 'model/address_book.dart' as mod;
import 'model/dashboard_widget.dart' as mod;
import 'model/user_profile.dart' as mod;
import 'nucleus_one.dart';

class User with NucleusOneAppDependent {
  User({
    NucleusOneAppInternal? app,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  /// Gets all items in the user's address book.
  Future<mod.AddressBook> getAddressBook({
    bool includeTenantMembers = true,
    bool includeRoles = true,
    bool includeFields = true,
    bool includeFormTemplateFields = true,
    String? filter,
  }) async {
    final qp = <String, dynamic>{
      'includeTenantMembers': includeTenantMembers,
      'includeRoles': includeRoles,
      'includeFields': includeFields,
      'includeFormTemplateFields': includeFormTemplateFields,
    };
    if (isNotEmpty(filter)) {
      qp['filter'] = filter;
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.addressBookItems,
      app,
      query: qp,
    );

    final apiModel = api_mod.AddressBook.fromJson(jsonDecode(responseBody));
    return mod.AddressBook.fromApiModel(apiModel);
  }

  /// Clears the user's address book items.
  Future<void> clearAddressBook() async {
    await http.executeDeleteRequest(http.apiPaths.addressBookItems, app);
  }

  /// Gets all of the user's Dashboard widgets.
  Future<mod.DashboardWidgetCollection> getDashboardWidgets() async {
    final responseBody =
        await http.executeGetRequestWithTextResponse(http.apiPaths.dashboardWidgets, app);
    final apiModel = api_mod.DashboardWidgetCollection.fromJson(jsonDecode(responseBody));
    return mod.DashboardWidgetCollection.fromApiModel(apiModel);
  }

  /// Deletes one or more of the user's Dashboard widgets.
  Future<void> deleteDashboardWidgets(List<String> ids) async {
    assert(ids.isNotEmpty);

    final bodyMap = {
      'IDs': ids,
    };
    await http.executeDeleteRequest(
      http.apiPaths.dashboardWidgets,
      app,
      body: jsonEncode(bodyMap),
    );
  }

  // The following method is currently inactive in the API, but should be full functional.
  /*
  /// Updates a user's Dashboard widget.
  Future<void> updateDashboardWidget(DashboardWidget widget) async {
    assert(widget.id != null);

    final bodyMap = widget;
    await http.executePutRequest(
      http.apiPaths.dashboardWidgets + '/' + widget.id!,
      app,
      body: jsonEncode(bodyMap),
    );
  }
  */

  /// Updates the positions of one or more of the user's Dashboard widgets.  Only the widgets changing
  /// position should be provided.
  Future<void> updateDashboardWidgetRanks(mod.DashboardWidgetCollection widgets) async {
    assert(widgets.items.isNotEmpty);

    final bodyList = widgets.toApiModel().items;

    // Only keep the properties needed for this operation
    final jsonList = bodyList.map((x) {
      final jsonMap = x.toJson();
      jsonMap.removeWhere((key, value) {
        return !(key == 'ID' || key == 'GridColumn' || key == 'ColumnRank');
      });
      return jsonMap;
    }).toList();

    await http.executePutRequest(
      http.apiPaths.dashboardWidgets,
      app,
      query: {
        'onlyRank': true,
      },
      body: jsonEncode(jsonList),
    );
  }

  /// Creates one or more Dashboard widgets for the user.
  Future<void> createDashboardWidgets(mod.DashboardWidgetCollection widgets) async {
    assert(widgets.items.isNotEmpty);

    final bodyList = widgets.toApiModel().items;
    await http.executePostRequest(
      http.apiPaths.dashboardWidgets,
      app,
      body: jsonEncode(bodyList),
    );
  }

  /// Gets the user's profile.
  Future<mod.UserProfile> getProfile() async {
    final responseBody =
        await http.executeGetRequestWithTextResponse(http.apiPaths.userProfile, app);
    final apiModel = api_mod.UserProfile.fromJson(jsonDecode(responseBody));
    return mod.UserProfile.fromApiModel(apiModel);
  }

  /// Updates the user's profile.
  Future<void> updateProfile(mod.UserProfile userProfile) async {
    await http.executePutRequest(
      http.apiPaths.userProfile,
      app,
      body: jsonEncode(userProfile.toApiModel()),
    );
  }
}
