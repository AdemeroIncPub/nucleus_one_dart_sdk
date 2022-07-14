import 'package:get_it/get_it.dart';

import '../api_model/user_organization.dart' as api_mod;
import '../common/model.dart';
import '../nucleus_one.dart';

class UserOrganization with NucleusOneAppDependent {
  UserOrganization._(
      {NucleusOneAppInternal? app,
      required this.userEmail,
      required this.organizationID,
      required this.organizationName,
      required this.assignmentTypes,
      required this.hasAssignment,
      required this.isOrganizationMember}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory UserOrganization.fromApiModel(api_mod.UserOrganization apiModel) {
    return UserOrganization._(
        userEmail: apiModel.userEmail!,
        organizationID: apiModel.organizationID!,
        organizationName: apiModel.organizationName!,
        assignmentTypes: apiModel.assignmentTypes!.toList(),
        hasAssignment: apiModel.hasAssignment!,
        isOrganizationMember: apiModel.isOrganizationMember!);
  }

  String userEmail;

  String organizationID;

  String organizationName;

  List<String> assignmentTypes;

  bool hasAssignment;

  bool isOrganizationMember;

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

/*
class UserOrganizationCollection with NucleusOneAppDependent {
  UserOrganizationCollection._({NucleusOneAppInternal? app, required this.items}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory UserOrganizationCollection.fromApiModel(api_mod.UserOrganizationCollection apiModel) {
    return UserOrganizationCollection._(
        items: apiModel.items.map((x) => UserOrganization.fromApiModel(x)).toList());
  }

  List<UserOrganization> items;

  api_mod.UserOrganizationCollection toApiModel() {
    return api_mod.UserOrganizationCollection()..items = items.map((x) => x.toApiModel()).toList();
  }
}
*/

class UserOrganizationCollection
    extends EntityCollection<UserOrganization, api_mod.UserOrganizationCollection> {
  UserOrganizationCollection({
    NucleusOneAppInternal? app,
    List<UserOrganization>? items,
  }) : super(app: app, items: items);

  factory UserOrganizationCollection.fromApiModel(api_mod.UserOrganizationCollection apiModel) {
    return UserOrganizationCollection(
        items: apiModel.items.map((x) => UserOrganization.fromApiModel(x)).toList());
  }

  @override
  api_mod.UserOrganizationCollection toApiModel() {
    return api_mod.UserOrganizationCollection()..items = items.map((x) => x.toApiModel()).toList();
  }
}
