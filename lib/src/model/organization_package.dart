import '../../nucleus_one_dart_sdk.dart';
import '../api_model/organization_package.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

class OrganizationPackageCollection
    extends EntityCollection<OrganizationPackage, api_mod.OrganizationPackageCollection> {
  OrganizationPackageCollection({
    NucleusOneApp? app,
    List<OrganizationPackage>? items,
  }) : super(app: app, items: items);

  factory OrganizationPackageCollection.fromApiModel(
    api_mod.OrganizationPackageCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return OrganizationPackageCollection(
        items: apiModel.organizationPackages
            ?.map((x) => OrganizationPackage.fromApiModel(x, app: app))
            .toList());
  }

  @override
  api_mod.OrganizationPackageCollection toApiModel() {
    return api_mod.OrganizationPackageCollection()
      ..organizationPackages = items.map((x) => x.toApiModel()).toList();
  }
}

class OrganizationPackage with NucleusOneAppDependent {
  OrganizationPackage._({
    NucleusOneApp? app,
    required this.organization,
    required this.userID,
    required this.isMember,
    required this.isExpiringSoon,
    required this.expiration,
    required this.freeUsers,
    required this.isExpired,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory OrganizationPackage.fromApiModel(
    api_mod.OrganizationPackage apiModel, {
    NucleusOneApp? app,
  }) {
    return OrganizationPackage._(
      app: app,
      organization: Organization.fromApiModel(apiModel.organization!, app: app),
      userID: apiModel.userID!,
      isMember: apiModel.isMember!,
      isExpiringSoon: apiModel.isExpiringSoon!,
      expiration: apiModel.expiration!,
      freeUsers: apiModel.freeUsers!,
      isExpired: apiModel.isExpired!,
    );
  }

  Organization organization;

  String userID;

  bool isMember;

  bool isExpiringSoon;

  String expiration;

  int freeUsers;

  bool isExpired;

  api_mod.OrganizationPackage toApiModel() {
    return api_mod.OrganizationPackage()
      ..organization = organization.toApiModel()
      ..userID = userID
      ..isMember = isMember
      ..isExpiringSoon = isExpiringSoon
      ..expiration = expiration
      ..freeUsers = freeUsers
      ..isExpired = isExpired;
  }
}
