import 'package:get_it/get_it.dart';

import '../api_model/organization_project.dart' as api_mod;
import '../common/model.dart';
import '../nucleus_one.dart';

class OrganizationProjectCollection
    extends EntityCollection<OrganizationProject, api_mod.OrganizationProjectCollection> {
  OrganizationProjectCollection({
    NucleusOneApp? app,
    List<OrganizationProject>? items,
  }) : super(app: app, items: items);

  factory OrganizationProjectCollection.fromApiModel(
    api_mod.OrganizationProjectCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return OrganizationProjectCollection(
        app: app,
        items: apiModel.projects!.map((x) => OrganizationProject.fromApiModel(x)).toList());
  }

  @override
  api_mod.OrganizationProjectCollection toApiModel() {
    return api_mod.OrganizationProjectCollection()
      ..projects = items.map((x) => x.toApiModel()).toList();
  }
}

class OrganizationProject with NucleusOneAppDependent {
  OrganizationProject._({
    NucleusOneApp? app,
    required this.id,
    required this.organizationID,
    required this.accessType,
    required this.createdOn,
    required this.createdByUserID,
    required this.createdByUserEmail,
    required this.createdByUserName,
    required this.name,
    required this.nameLower,
    required this.disabled,
    required this.isMarkedForPurge,
    required this.purgeMarkedOn,
    required this.purgeMarkedByUserID,
    required this.purgeMarkedByUserName,
    required this.purgeMarkedByUserEmail,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
  }

  factory OrganizationProject.fromApiModel(api_mod.OrganizationProject apiModel) {
    return OrganizationProject._(
        id: apiModel.id!,
        organizationID: apiModel.organizationID!,
        accessType: apiModel.accessType!,
        createdOn: apiModel.createdOn!,
        createdByUserID: apiModel.createdByUserID!,
        createdByUserEmail: apiModel.createdByUserEmail!,
        createdByUserName: apiModel.createdByUserName!,
        name: apiModel.name!,
        nameLower: apiModel.nameLower!,
        disabled: apiModel.disabled!,
        isMarkedForPurge: apiModel.isMarkedForPurge!,
        purgeMarkedOn: apiModel.purgeMarkedOn!,
        purgeMarkedByUserID: apiModel.purgeMarkedByUserID!,
        purgeMarkedByUserName: apiModel.purgeMarkedByUserName!,
        purgeMarkedByUserEmail: apiModel.purgeMarkedByUserEmail!);
  }

  String id;

  String organizationID;

  String accessType;

  String createdOn;

  String createdByUserID;

  String createdByUserEmail;

  String createdByUserName;

  String name;

  String nameLower;

  bool disabled;

  bool isMarkedForPurge;

  String purgeMarkedOn;

  String purgeMarkedByUserID;

  String purgeMarkedByUserName;

  String purgeMarkedByUserEmail;

  api_mod.OrganizationProject toApiModel() {
    return api_mod.OrganizationProject()
      ..id = id
      ..organizationID = organizationID
      ..accessType = accessType
      ..createdOn = createdOn
      ..createdByUserID = createdByUserID
      ..createdByUserEmail = createdByUserEmail
      ..createdByUserName = createdByUserName
      ..name = name
      ..nameLower = nameLower
      ..disabled = disabled
      ..isMarkedForPurge = isMarkedForPurge
      ..purgeMarkedOn = purgeMarkedOn
      ..purgeMarkedByUserID = purgeMarkedByUserID
      ..purgeMarkedByUserName = purgeMarkedByUserName
      ..purgeMarkedByUserEmail = purgeMarkedByUserEmail;
  }
}
