import '../api_model/project.dart' as api_mod;
import '../common/get_it.dart';
import '../nucleus_one.dart';

class ProjectMember with NucleusOneAppDependent {
  ProjectMember._({
    NucleusOneApp? app,
    required this.id,
    required this.createdOn,
    required this.organizationMemberID,
    required this.organizationMemberIsAdmin,
    required this.organizationID,
    required this.organizationName,
    required this.projectID,
    required this.projectName,
    required this.projectIsDisabled,
    required this.projectAccessType,
    required this.userID,
    required this.userName,
    required this.userNameLower,
    required this.userEmail,
    required this.disabled,
    required this.isReadOnly,
    required this.isAdmin,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory ProjectMember.fromApiModel(
    api_mod.ProjectMember apiModel, {
    NucleusOneApp? app,
  }) {
    return ProjectMember._(
        app: app,
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        organizationMemberID: apiModel.organizationMemberID!,
        organizationMemberIsAdmin: apiModel.organizationMemberIsAdmin!,
        organizationID: apiModel.organizationID!,
        organizationName: apiModel.organizationName!,
        projectID: apiModel.projectID!,
        projectName: apiModel.projectName!,
        projectIsDisabled: apiModel.projectIsDisabled!,
        projectAccessType: apiModel.projectAccessType!,
        userID: apiModel.userID!,
        userName: apiModel.userName!,
        userNameLower: apiModel.userNameLower!,
        userEmail: apiModel.userEmail!,
        disabled: apiModel.disabled!,
        isReadOnly: apiModel.isReadOnly!,
        isAdmin: apiModel.isAdmin!);
  }

  String id;

  String createdOn;

  String organizationMemberID;

  bool organizationMemberIsAdmin;

  String organizationID;

  String organizationName;

  String projectID;

  String projectName;

  bool projectIsDisabled;

  String projectAccessType;

  String userID;

  String userName;

  String userNameLower;

  String userEmail;

  bool disabled;

  bool isReadOnly;

  bool isAdmin;

  api_mod.ProjectMember toApiModel() {
    return api_mod.ProjectMember()
      ..id = id
      ..createdOn = createdOn
      ..organizationMemberID = organizationMemberID
      ..organizationMemberIsAdmin = organizationMemberIsAdmin
      ..organizationID = organizationID
      ..organizationName = organizationName
      ..projectID = projectID
      ..projectName = projectName
      ..projectIsDisabled = projectIsDisabled
      ..projectAccessType = projectAccessType
      ..userID = userID
      ..userName = userName
      ..userNameLower = userNameLower
      ..userEmail = userEmail
      ..disabled = disabled
      ..isReadOnly = isReadOnly
      ..isAdmin = isAdmin;
  }
}

class Project with NucleusOneAppDependent {
  Project._({
    NucleusOneApp? app,
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
    required this.purgeMarkedByUserEmail,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory Project.fromApiModel(
    api_mod.Project apiModel, {
    NucleusOneApp? app,
  }) {
    return Project._(
        app: app,
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
