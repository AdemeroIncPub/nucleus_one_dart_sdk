import 'package:get_it/get_it.dart';

import '../api_model/project.dart' as api_mod;
import '../nucleus_one.dart';

class ProjectMember with NucleusOneAppDependent {
  ProjectMember._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.createdOn,
      required this.tenantID,
      required this.tenantName,
      required this.userID,
      required this.userName,
      required this.userNameLower,
      required this.userEmail,
      required this.disabled,
      required this.isReadOnly,
      required this.isAdmin,
      required this.isOrganizationAdmin,
      required this.isOrganizationOrTenantAdmin}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory ProjectMember.fromApiModel(api_mod.ProjectMember apiModel) {
    return ProjectMember._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        tenantID: apiModel.tenantID!,
        tenantName: apiModel.tenantName!,
        userID: apiModel.userID!,
        userName: apiModel.userName!,
        userNameLower: apiModel.userNameLower!,
        userEmail: apiModel.userEmail!,
        disabled: apiModel.disabled!,
        isReadOnly: apiModel.isReadOnly!,
        isAdmin: apiModel.isAdmin!,
        isOrganizationAdmin: apiModel.isOrganizationAdmin!,
        isOrganizationOrTenantAdmin: apiModel.isOrganizationOrTenantAdmin!);
  }

  String id;

  String createdOn;

  String tenantID;

  String tenantName;

  String userID;

  String userName;

  String userNameLower;

  String userEmail;

  bool disabled;

  bool isReadOnly;

  bool isAdmin;

  bool isOrganizationAdmin;

  bool isOrganizationOrTenantAdmin;

  api_mod.ProjectMember toApiModel() {
    return api_mod.ProjectMember()
      ..id = id
      ..createdOn = createdOn
      ..tenantID = tenantID
      ..tenantName = tenantName
      ..userID = userID
      ..userName = userName
      ..userNameLower = userNameLower
      ..userEmail = userEmail
      ..disabled = disabled
      ..isReadOnly = isReadOnly
      ..isAdmin = isAdmin
      ..isOrganizationAdmin = isOrganizationAdmin
      ..isOrganizationOrTenantAdmin = isOrganizationOrTenantAdmin;
  }
}

class Project with NucleusOneAppDependent {
  Project._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.createdOn,
      required this.organizationID,
      required this.organizationName,
      required this.organizationNameLower,
      required this.organizationSubscriptionRequired,
      required this.organizationSubscriptionFreeUsers,
      required this.organizationSubscriptionExpiration,
      required this.bucketName,
      required this.name,
      required this.nameLower,
      required this.creatingUserID,
      required this.creatingUserName,
      required this.creatingUserEmail,
      required this.crmAccountId,
      required this.disabled,
      required this.isMarkedForPurge,
      required this.purgeMarkedOn,
      required this.purgeMarkedByUserID,
      required this.purgeMarkedByUserName,
      required this.purgeMarkedByUserEmail}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory Project.fromApiModel(api_mod.Project apiModel) {
    return Project._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        organizationID: apiModel.organizationID!,
        organizationName: apiModel.organizationName!,
        organizationNameLower: apiModel.organizationNameLower!,
        organizationSubscriptionRequired: apiModel.organizationSubscriptionRequired!,
        organizationSubscriptionFreeUsers: apiModel.organizationSubscriptionFreeUsers!,
        organizationSubscriptionExpiration: apiModel.organizationSubscriptionExpiration!,
        bucketName: apiModel.bucketName!,
        name: apiModel.name!,
        nameLower: apiModel.nameLower!,
        creatingUserID: apiModel.creatingUserID!,
        creatingUserName: apiModel.creatingUserName!,
        creatingUserEmail: apiModel.creatingUserEmail!,
        crmAccountId: apiModel.crmAccountId!,
        disabled: apiModel.disabled!,
        isMarkedForPurge: apiModel.isMarkedForPurge!,
        purgeMarkedOn: apiModel.purgeMarkedOn!,
        purgeMarkedByUserID: apiModel.purgeMarkedByUserID!,
        purgeMarkedByUserName: apiModel.purgeMarkedByUserName!,
        purgeMarkedByUserEmail: apiModel.purgeMarkedByUserEmail!);
  }

  String id;

  String createdOn;

  String organizationID;

  String organizationName;

  String organizationNameLower;

  bool organizationSubscriptionRequired;

  int organizationSubscriptionFreeUsers;

  String organizationSubscriptionExpiration;

  String bucketName;

  String name;

  String nameLower;

  String creatingUserID;

  String creatingUserName;

  String creatingUserEmail;

  String crmAccountId;

  bool disabled;

  bool isMarkedForPurge;

  String purgeMarkedOn;

  String purgeMarkedByUserID;

  String purgeMarkedByUserName;

  String purgeMarkedByUserEmail;

  api_mod.Project toApiModel() {
    return api_mod.Project()
      ..id = id
      ..createdOn = createdOn
      ..organizationID = organizationID
      ..organizationName = organizationName
      ..organizationNameLower = organizationNameLower
      ..organizationSubscriptionRequired = organizationSubscriptionRequired
      ..organizationSubscriptionFreeUsers = organizationSubscriptionFreeUsers
      ..organizationSubscriptionExpiration = organizationSubscriptionExpiration
      ..bucketName = bucketName
      ..name = name
      ..nameLower = nameLower
      ..creatingUserID = creatingUserID
      ..creatingUserName = creatingUserName
      ..creatingUserEmail = creatingUserEmail
      ..crmAccountId = crmAccountId
      ..disabled = disabled
      ..isMarkedForPurge = isMarkedForPurge
      ..purgeMarkedOn = purgeMarkedOn
      ..purgeMarkedByUserID = purgeMarkedByUserID
      ..purgeMarkedByUserName = purgeMarkedByUserName
      ..purgeMarkedByUserEmail = purgeMarkedByUserEmail;
  }
}
