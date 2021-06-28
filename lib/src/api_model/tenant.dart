import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';
import 'query_result.dart';

part 'tenant.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class TenantCollection implements IQueryResultEntityCollection {
  TenantCollection();

  /// A necessary factory constructor for creating a new TenantCollection instance
  /// from a map. Pass the map to the generated [_$TenantCollectionFromJson()] constructor.
  /// The constructor is named after the source class, in this case, TenantCollection.
  factory TenantCollection.fromJson(Map<String, dynamic> json) =>
      _$TenantCollectionFromJson(json);

  @JsonKey(name: 'Tenants')
  List<Tenant>? tenants;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$TenantCollectionToJson].
  Map<String, dynamic> toJson() => _$TenantCollectionToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class Tenant extends Entity {
  Tenant();

  /// A necessary factory constructor for creating a new Tenant instance
  /// from a map. Pass the map to the generated [_$TenantFromJson()] constructor.
  /// The constructor is named after the source class, in this case, Tenant.
  factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'CreatedOn')
  String? createdOn;

  @JsonKey(name: 'Name')
  String? name;

  @JsonKey(name: 'CreatingUserName')
  String? creatingUserName;

  @JsonKey(name: 'CreatingUserEmail')
  String? creatingUserEmail;

  @JsonKey(name: 'CrmAccountId')
  String? crmAccountId;

  @JsonKey(name: 'OrganizationID')
  String? organizationID;

  @JsonKey(name: 'OrganizationName')
  String? organizationName;

  @JsonKey(name: 'OrganizationSubscriptionRequired')
  bool? organizationSubscriptionRequired;

  @JsonKey(name: 'OrganizationSubscriptionExpiration')
  String? organizationSubscriptionExpiration;

  @JsonKey(name: 'SearchIndexID')
  String? searchIndexID;

  @JsonKey(name: 'BucketName')
  String? bucketName;

  @JsonKey(name: 'Disabled')
  bool? disabled;

  @JsonKey(name: 'IsMarkedForPurge')
  bool? isMarkedForPurge;

  @JsonKey(name: 'PurgeDate')
  String? purgeDate;

  @JsonKey(name: 'DocumentCount')
  int? documentCount;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$TenantToJson].
  @override
  Map<String, dynamic> toJson() => _$TenantToJson(this);
  // coverage:ignore-end
}