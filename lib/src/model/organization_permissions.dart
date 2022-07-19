import 'package:get_it/get_it.dart';

import '../api_model/organization_permissions.dart' as api_mod;
import '../nucleus_one.dart';

class OrganizationPermissions with NucleusOneAppDependent {
  OrganizationPermissions._({
    NucleusOneApp? app,
    required this.organizationID,
    required this.organizationName,
    required this.userID,
    required this.userName,
    required this.userEmail,
    required this.isAdmin,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
  }

  factory OrganizationPermissions.fromApiModel(
    api_mod.OrganizationPermissions apiModel, {
    NucleusOneApp? app,
  }) {
    return OrganizationPermissions._(
      app: app,
      organizationID: apiModel.organizationID!,
      organizationName: apiModel.organizationName!,
      userID: apiModel.userID!,
      userName: apiModel.userName!,
      userEmail: apiModel.userEmail!,
      isAdmin: apiModel.isAdmin!,
    );
  }

  String organizationID;

  String organizationName;

  String userID;

  String userName;

  String userEmail;

  bool isAdmin;

  api_mod.OrganizationPermissions toApiModel() {
    return api_mod.OrganizationPermissions()
      ..organizationID = organizationID
      ..organizationName = organizationName
      ..userID = userID
      ..userName = userName
      ..userEmail = userEmail
      ..isAdmin = isAdmin;
  }
}
