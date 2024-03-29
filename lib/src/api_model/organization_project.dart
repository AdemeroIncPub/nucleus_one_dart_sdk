import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';
import 'query_result.dart';

part 'organization_project.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class OrganizationProjectCollection implements IQueryResultEntityCollection {
  OrganizationProjectCollection();

  /// A necessary factory constructor for creating a new OrganizationProjectCollection instance
  /// from a map. Pass the map to the generated [_$OrganizationProjectCollectionFromJson()] constructor.
  /// The constructor is named after the source class, in this case, OrganizationProjectCollection.
  factory OrganizationProjectCollection.fromJson(Map<String, dynamic> json) =>
      _$OrganizationProjectCollectionFromJson(json);

  @JsonKey(name: 'Projects')
  List<OrganizationProject>? projects;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$OrganizationProjectCollectionToJson].
  Map<String, dynamic> toJson() => _$OrganizationProjectCollectionToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class OrganizationProject extends Entity {
  OrganizationProject();

  /// A necessary factory constructor for creating a new OrganizationProject instance
  /// from a map. Pass the map to the generated [_$OrganizationProjectFromJson()] constructor.
  /// The constructor is named after the source class, in this case, OrganizationProject.
  factory OrganizationProject.fromJson(Map<String, dynamic> json) =>
      _$OrganizationProjectFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'OrganizationID')
  String? organizationID;

  @JsonKey(name: 'AccessType')
  String? accessType;

  @JsonKey(name: 'CreatedOn')
  String? createdOn;

  @JsonKey(name: 'CreatedByUserID')
  String? createdByUserID;

  @JsonKey(name: 'CreatedByUserEmail')
  String? createdByUserEmail;

  @JsonKey(name: 'CreatedByUserName')
  String? createdByUserName;

  @JsonKey(name: 'Name')
  String? name;

  @JsonKey(name: 'NameLower')
  String? nameLower;

  @JsonKey(name: 'Disabled')
  bool? disabled;

  @JsonKey(name: 'IsMarkedForPurge')
  bool? isMarkedForPurge;

  @JsonKey(name: 'PurgeMarkedOn')
  String? purgeMarkedOn;

  @JsonKey(name: 'PurgeMarkedByUserID')
  String? purgeMarkedByUserID;

  @JsonKey(name: 'PurgeMarkedByUserName')
  String? purgeMarkedByUserName;

  @JsonKey(name: 'PurgeMarkedByUserEmail')
  String? purgeMarkedByUserEmail;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$OrganizationProjectToJson].
  @override
  Map<String, dynamic> toJson() => _$OrganizationProjectToJson(this);
  // coverage:ignore-end
}
