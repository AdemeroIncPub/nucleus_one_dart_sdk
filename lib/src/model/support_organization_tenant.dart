import 'package:get_it/get_it.dart';
import '../common/model.dart';
import '../api_model/support_organization_tenant.dart' as api_mod;
import '../nucleus_one.dart';

class SupportOrganizationTenantCollection extends EntityCollection<SupportOrganizationTenant,
    api_mod.SupportOrganizationTenantCollection> {
  SupportOrganizationTenantCollection({
    NucleusOneAppInternal? app,
    List<SupportOrganizationTenant>? items,
  }) : super(app: app, items: items);

  factory SupportOrganizationTenantCollection.fromApiModel(
      api_mod.SupportOrganizationTenantCollection apiModel) {
    return SupportOrganizationTenantCollection(
        items: apiModel.supportOrganizationTenants
            ?.map((x) => SupportOrganizationTenant.fromApiModel(x))
            .toList());
  }

  @override
  api_mod.SupportOrganizationTenantCollection toApiModel() {
    return api_mod.SupportOrganizationTenantCollection()
      ..supportOrganizationTenants = items.map((x) => x.toApiModel()).toList();
  }
}

class SupportOrganizationTenant with NucleusOneAppDependent {
  SupportOrganizationTenant._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.createdOn,
      required this.name,
      required this.creatingUserName,
      required this.creatingUserEmail,
      required this.crmAccountId,
      required this.organizationID,
      required this.organizationName,
      required this.organizationSubscriptionRequired,
      required this.organizationSubscriptionExpiration,
      required this.searchIndexID,
      required this.bucketName,
      required this.disabled,
      required this.isMarkedForPurge,
      required this.purgeDate,
      required this.documentCount}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory SupportOrganizationTenant.fromApiModel(api_mod.SupportOrganizationTenant apiModel) {
    return SupportOrganizationTenant._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        name: apiModel.name!,
        creatingUserName: apiModel.creatingUserName!,
        creatingUserEmail: apiModel.creatingUserEmail!,
        crmAccountId: apiModel.crmAccountId!,
        organizationID: apiModel.organizationID!,
        organizationName: apiModel.organizationName!,
        organizationSubscriptionRequired: apiModel.organizationSubscriptionRequired!,
        organizationSubscriptionExpiration: apiModel.organizationSubscriptionExpiration!,
        searchIndexID: apiModel.searchIndexID!,
        bucketName: apiModel.bucketName!,
        disabled: apiModel.disabled!,
        isMarkedForPurge: apiModel.isMarkedForPurge!,
        purgeDate: apiModel.purgeDate!,
        documentCount: apiModel.documentCount!);
  }

  String id;

  String createdOn;

  String name;

  String creatingUserName;

  String creatingUserEmail;

  String crmAccountId;

  String organizationID;

  String organizationName;

  bool organizationSubscriptionRequired;

  String organizationSubscriptionExpiration;

  String searchIndexID;

  String bucketName;

  bool disabled;

  bool isMarkedForPurge;

  String purgeDate;

  int documentCount;

  api_mod.SupportOrganizationTenant toApiModel() {
    return api_mod.SupportOrganizationTenant()
      ..id = id
      ..createdOn = createdOn
      ..name = name
      ..creatingUserName = creatingUserName
      ..creatingUserEmail = creatingUserEmail
      ..crmAccountId = crmAccountId
      ..organizationID = organizationID
      ..organizationName = organizationName
      ..organizationSubscriptionRequired = organizationSubscriptionRequired
      ..organizationSubscriptionExpiration = organizationSubscriptionExpiration
      ..searchIndexID = searchIndexID
      ..bucketName = bucketName
      ..disabled = disabled
      ..isMarkedForPurge = isMarkedForPurge
      ..purgeDate = purgeDate
      ..documentCount = documentCount;
  }
}
