import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';

import '../../nucleus_one_dart_sdk.dart';
import '../api_model/tenant.dart' as api_mod;
import '../nucleus_one.dart';

class TenantCollection extends EntityCollection<Tenant, api_mod.TenantCollection> {
  TenantCollection({
    NucleusOneAppInternal? app,
    List<Tenant>? items,
  }) : super(app: app, items: items);

  factory TenantCollection.fromApiModel(api_mod.TenantCollection apiModel) {
    return TenantCollection(items: apiModel.tenants?.map((x) => Tenant.fromApiModel(x)).toList());
  }

  @override
  api_mod.TenantCollection toApiModel() {
    return api_mod.TenantCollection()..tenants = items.map((x) => x.toApiModel()).toList();
  }
}

class Tenant with NucleusOneAppDependent {
  Tenant._(
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

  factory Tenant.fromApiModel(api_mod.Tenant apiModel) {
    return Tenant._(
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

  api_mod.Tenant toApiModel() {
    return api_mod.Tenant()
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
