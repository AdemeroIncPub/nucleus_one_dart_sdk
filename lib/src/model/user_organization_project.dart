import 'package:get_it/get_it.dart';

import '../api_model/user_organization_project.dart' as api_mod;
import '../common/model.dart';
import '../nucleus_one.dart';

class UserOrganizationProject with NucleusOneAppDependent {
  UserOrganizationProject._({
    NucleusOneApp? app,
    required this.userEmail,
    required this.organizationID,
    required this.organizationName,
    required this.projectID,
    required this.projectName,
    required this.projectAccessType,
    required this.projectIsDisabled,
    required this.assignmentTypes,
    required this.hasAssignment,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
  }

  factory UserOrganizationProject.fromApiModel(
    api_mod.UserOrganizationProject apiModel, {
    NucleusOneApp? app,
  }) {
    return UserOrganizationProject._(
      app: app,
      userEmail: apiModel.userEmail!,
      organizationID: apiModel.organizationID!,
      organizationName: apiModel.organizationName!,
      projectID: apiModel.projectID!,
      projectName: apiModel.projectName!,
      projectAccessType: apiModel.projectAccessType!,
      projectIsDisabled: apiModel.projectIsDisabled!,
      assignmentTypes: apiModel.assignmentTypes!.toList(),
      hasAssignment: apiModel.hasAssignment!,
    );
  }

  String userEmail;

  String organizationID;

  String organizationName;

  String projectID;

  String projectName;

  String projectAccessType;

  bool projectIsDisabled;

  List<String> assignmentTypes;

  bool hasAssignment;

  api_mod.UserOrganizationProject toApiModel() {
    return api_mod.UserOrganizationProject()
      ..userEmail = userEmail
      ..organizationID = organizationID
      ..organizationName = organizationName
      ..projectID = projectID
      ..projectName = projectName
      ..projectAccessType = projectAccessType
      ..projectIsDisabled = projectIsDisabled
      ..assignmentTypes = assignmentTypes.toList()
      ..hasAssignment = hasAssignment;
  }
}

class UserOrganizationProjectCollection
    extends EntityCollection<UserOrganizationProject, api_mod.UserOrganizationProjectCollection> {
  UserOrganizationProjectCollection({
    NucleusOneApp? app,
    List<UserOrganizationProject>? items,
  }) : super(app: app, items: items);

  factory UserOrganizationProjectCollection.fromApiModel(
    api_mod.UserOrganizationProjectCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return UserOrganizationProjectCollection(
        app: app,
        items: apiModel.userOrganizationProjects
            ?.map((x) => UserOrganizationProject.fromApiModel(x, app: app))
            .toList());
  }

  @override
  api_mod.UserOrganizationProjectCollection toApiModel() {
    return api_mod.UserOrganizationProjectCollection()
      ..userOrganizationProjects = items.map((x) => x.toApiModel()).toList();
  }
}
