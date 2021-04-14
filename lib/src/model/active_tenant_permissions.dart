import '../api_model/active_tenant_permissions.dart' as api_model;

class ActiveTenantPermissions {
  ActiveTenantPermissions._(
      {required this.organizationID,
      required this.organizationName,
      required this.tenantID,
      required this.tenantName,
      required this.tenantMemberID,
      required this.userID,
      required this.userName,
      required this.userEmail,
      required this.disabled,
      required this.isAdmin});

  factory ActiveTenantPermissions.fromApiModel(api_model.ActiveTenantPermissions apiModel) {
    return ActiveTenantPermissions._(
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
}
