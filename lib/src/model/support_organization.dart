import '../common/get_it.dart';
import '../common/model.dart';
import '../api_model/support_organization.dart' as api_mod;
import '../nucleus_one.dart';

class SupportOrganizationCollection
    extends EntityCollection<SupportOrganization, api_mod.SupportOrganizationCollection> {
  SupportOrganizationCollection({
    NucleusOneApp? app,
    List<SupportOrganization>? items,
  }) : super(app: app, items: items);

  factory SupportOrganizationCollection.fromApiModel(
    api_mod.SupportOrganizationCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return SupportOrganizationCollection(
        items: apiModel.supportOrganizations
            ?.map((x) => SupportOrganization.fromApiModel(x, app: app))
            .toList());
  }

  @override
  api_mod.SupportOrganizationCollection toApiModel() {
    return api_mod.SupportOrganizationCollection()
      ..supportOrganizations = items.map((x) => x.toApiModel()).toList();
  }
}

class SupportOrganization extends Entity with NucleusOneAppDependent {
  SupportOrganization._({
    NucleusOneApp? app,
    required this.id,
    required this.createdOn,
    required this.name,
    required this.creatingUserName,
    required this.creatingUserEmail,
    required this.subscriptionRequired,
    required this.subscriptionFreeUsers,
    required this.subscriptionExpiration,
    required this.uniqueNonReadOnlyTenantMembers,
    required this.uniqueReadOnlyTenantMembers,
  }) {
    this.app = getEffectiveNucleusOneApp(app);
  }

  factory SupportOrganization.fromApiModel(
    api_mod.SupportOrganization apiModel, {
    NucleusOneApp? app,
  }) {
    return SupportOrganization._(
      app: app,
      id: apiModel.id!,
      createdOn: apiModel.createdOn!,
      name: apiModel.name!,
      creatingUserName: apiModel.creatingUserName!,
      creatingUserEmail: apiModel.creatingUserEmail!,
      subscriptionRequired: apiModel.subscriptionRequired!,
      subscriptionFreeUsers: apiModel.subscriptionFreeUsers!,
      subscriptionExpiration: apiModel.subscriptionExpiration!,
      uniqueNonReadOnlyTenantMembers: apiModel.uniqueNonReadOnlyTenantMembers!,
      uniqueReadOnlyTenantMembers: apiModel.uniqueReadOnlyTenantMembers!,
    );
  }

  String id;

  String createdOn;

  String name;

  String creatingUserName;

  String creatingUserEmail;

  bool subscriptionRequired;

  int subscriptionFreeUsers;

  String subscriptionExpiration;

  int uniqueNonReadOnlyTenantMembers;

  int uniqueReadOnlyTenantMembers;

  @override
  api_mod.SupportOrganization toApiModel() {
    return api_mod.SupportOrganization()
      ..id = id
      ..createdOn = createdOn
      ..name = name
      ..creatingUserName = creatingUserName
      ..creatingUserEmail = creatingUserEmail
      ..subscriptionRequired = subscriptionRequired
      ..subscriptionFreeUsers = subscriptionFreeUsers
      ..subscriptionExpiration = subscriptionExpiration
      ..uniqueNonReadOnlyTenantMembers = uniqueNonReadOnlyTenantMembers
      ..uniqueReadOnlyTenantMembers = uniqueReadOnlyTenantMembers;
  }
}
