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
}
