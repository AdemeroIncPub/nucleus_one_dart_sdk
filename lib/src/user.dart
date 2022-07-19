import 'dart:convert';

import 'package:get_it/get_it.dart';

import 'api_model/address_book.dart' as api_mod;
import 'api_model/user_profile.dart' as api_mod;
import 'common/string.dart';
import 'http.dart' as http;
import 'model/address_book.dart' as mod;
import 'model/user_profile.dart' as mod;
import 'nucleus_one.dart';

class User with NucleusOneAppDependent {
  User({
    NucleusOneApp? app,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
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
      http.apiPaths.userAddressBookItems,
      app,
      query: qp,
    );

    final apiModel = api_mod.AddressBook.fromJson(jsonDecode(responseBody));
    return mod.AddressBook.fromApiModel(
      apiModel,
      app: app,
    );
  }

  /// Clears the user's address book items.
  Future<void> clearAddressBook() async {
    await http.executeDeleteRequest(http.apiPaths.userAddressBookItems, app: app);
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
