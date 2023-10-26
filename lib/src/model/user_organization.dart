import 'package:meta/meta.dart';

import '../api_model/user_organization.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

class UserOrganization extends Entity with NucleusOneAppDependent {
  @visibleForTesting
  UserOrganization({
    NucleusOneApp? app,
    required this.userEmail,
    required this.organizationID,
    required this.organizationName,
    required this.assignmentTypes,
    required this.hasAssignment,
    required this.isOrganizationMember,
  }) {
    this.app = getEffectiveNucleusOneApp(app);
  }

  factory UserOrganization.fromApiModel(
    api_mod.UserOrganization apiModel, {
    NucleusOneApp? app,
  }) {
    return UserOrganization(
      app: app,
      userEmail: apiModel.userEmail!,
      organizationID: apiModel.organizationID!,
      organizationName: apiModel.organizationName!,
      assignmentTypes: apiModel.assignmentTypes!.toList(),
      hasAssignment: apiModel.hasAssignment!,
      isOrganizationMember: apiModel.isOrganizationMember!,
    );
  }

  String userEmail;

  String organizationID;

  String organizationName;

  List<String> assignmentTypes;

  bool hasAssignment;

  bool isOrganizationMember;

  @override
  api_mod.UserOrganization toApiModel() {
    return api_mod.UserOrganization()
      ..userEmail = userEmail
      ..organizationID = organizationID
      ..organizationName = organizationName
      ..assignmentTypes = assignmentTypes.toList()
      ..hasAssignment = hasAssignment
      ..isOrganizationMember = isOrganizationMember;
  }
}

class UserOrganizationCollection
    extends EntityCollection<UserOrganization, api_mod.UserOrganizationCollection> {
  UserOrganizationCollection({
    NucleusOneApp? app,
    List<UserOrganization>? items,
  }) : super(app: app, items: items);

  factory UserOrganizationCollection.fromApiModel(
    api_mod.UserOrganizationCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return UserOrganizationCollection(
        items: apiModel.items.map((x) => UserOrganization.fromApiModel(x)).toList());
  }

  @override
  api_mod.UserOrganizationCollection toApiModel() {
    return api_mod.UserOrganizationCollection()..items = items.map((x) => x.toApiModel()).toList();
  }
}
