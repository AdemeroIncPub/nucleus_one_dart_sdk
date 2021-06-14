import 'package:get_it/get_it.dart';

import '../api_model/project_permissions.dart' as api_mod;
import '../nucleus_one.dart';

class ProjectPermissions with NucleusOneAppDependent {
  ProjectPermissions._(
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
      required this.isAdmin,
      required this.isReadOnly}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory ProjectPermissions.fromApiModel(api_mod.ProjectPermissions apiModel) {
    return ProjectPermissions._(
        organizationID: apiModel.organizationID!,
        organizationName: apiModel.organizationName!,
        tenantID: apiModel.tenantID!,
        tenantName: apiModel.tenantName!,
        tenantMemberID: apiModel.tenantMemberID!,
        userID: apiModel.userID!,
        userName: apiModel.userName!,
        userEmail: apiModel.userEmail!,
        disabled: apiModel.disabled!,
        isAdmin: apiModel.isAdmin!,
        isReadOnly: apiModel.isReadOnly!);
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

  bool isReadOnly;

  api_mod.ProjectPermissions toApiModel() {
    return api_mod.ProjectPermissions()
      ..organizationID = organizationID
      ..organizationName = organizationName
      ..tenantID = tenantID
      ..tenantName = tenantName
      ..tenantMemberID = tenantMemberID
      ..userID = userID
      ..userName = userName
      ..userEmail = userEmail
      ..disabled = disabled
      ..isAdmin = isAdmin
      ..isReadOnly = isReadOnly;
  }
}
