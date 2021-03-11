import 'package:meta/meta.dart';
import 'package:quiver/strings.dart' as q_strings;

import 'address_book.dart';
import 'http.dart' as http;
import 'nucleus_one.dart';

class User with NucleusOneAppDependent {
  User({
    @required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

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
    if (q_strings.isNotEmpty(filter)) {
      qp['filter'] = filter;
    }

    final responseBody = await http.executeHttpGetRequestWithTextResponse(
      http.apiPaths.addressBookItems,
      app,
      query: qp,
    );

    return AddressBook.fromJson(responseBody);
  }

  Future<void> clearAddressBook() async {
    await http.executeHttpDeleteRequest(http.apiPaths.addressBookItems, app);
  }
}
