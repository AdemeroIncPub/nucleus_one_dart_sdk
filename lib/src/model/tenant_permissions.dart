import 'package:get_it/get_it.dart';

import '../api_model/tenant_permissions.dart' as api_mod;
import '../nucleus_one.dart';

class TenantPermissions with NucleusOneAppDependent {
  TenantPermissions._(
      {NucleusOneAppInternal? app,
      required this.organizationID,
      required this.organizationName,
      required this.tenantID,
      required this.tenantName,
      required this.tenantMemberID,
      required this.userID,
      required this.userName,
      required this.userEmail,
      required this.disabled,
      required this.isAdmin}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory TenantPermissions.fromApiModel(api_mod.TenantPermissions apiModel) {
    return TenantPermissions._(
        organizationID: apiModel.organizationID!,
        organizationName: apiModel.organizationName!,
        tenantID: apiModel.tenantID!,
        tenantName: apiModel.tenantName!,
        tenantMemberID: apiModel.tenantMemberID!,
        userID: apiModel.userID!,
        userName: apiModel.userName!,
        userEmail: apiModel.userEmail!,
        disabled: apiModel.disabled!,
        isAdmin: apiModel.isAdmin!);
  }

  String organizationID;

  String organizationName;

  String tenantID;

  String tenantName;

  String tenantMemberID;

  String userID;

  String userName;

  String userEmail;

  bool disabled;

  bool isAdmin;

  api_mod.TenantPermissions toApiModel() {
    return api_mod.TenantPermissions()
      ..organizationID = organizationID
      ..organizationName = organizationName
      ..tenantID = tenantID
      ..tenantName = tenantName
      ..tenantMemberID = tenantMemberID
      ..userID = userID
      ..userName = userName
      ..userEmail = userEmail
      ..disabled = disabled
      ..isAdmin = isAdmin;
  }
}
