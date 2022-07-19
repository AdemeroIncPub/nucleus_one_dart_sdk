import 'package:json_annotation/json_annotation.dart';

import '../common/api_model.dart';
import 'query_result.dart';

part 'user_organization_project.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class UserOrganizationProject extends Entity {
  UserOrganizationProject();

  /// A necessary factory constructor for creating a new UserOrganizationProject instance
  /// from a map. Pass the map to the generated [_$UserOrganizationProjectFromJson()] constructor.
  /// The constructor is named after the source class, in this case, UserOrganizationProject.
  factory UserOrganizationProject.fromJson(Map<String, dynamic> json) =>
      _$UserOrganizationProjectFromJson(json);

  @JsonKey(name: 'UserEmail')
  String? userEmail;

  @JsonKey(name: 'OrganizationID')
  String? organizationID;

  @JsonKey(name: 'OrganizationName')
  String? organizationName;

  @JsonKey(name: 'ProjectID')
  String? projectID;

  @JsonKey(name: 'ProjectName')
  String? projectName;

  @JsonKey(name: 'ProjectAccessType')
  String? projectAccessType;

  @JsonKey(name: 'ProjectIsDisabled')
  bool? projectIsDisabled;

  @JsonKey(name: 'AssignmentTypes')
  List<String>? assignmentTypes;

  @JsonKey(name: 'HasAssignment')
  bool? hasAssignment;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$UserOrganizationProjectToJson].
  @override
  Map<String, dynamic> toJson() => _$UserOrganizationProjectToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class UserOrganizationProjectCollection implements IQueryResultEntityCollection {
  UserOrganizationProjectCollection();

  /// A necessary factory constructor for creating a new UserOrganizationProjectCollection instance
  /// from a map. Pass the map to the generated [_$UserOrganizationProjectCollectionFromJson()] constructor.
  /// The constructor is named after the source class, in this case, UserOrganizationProjectCollection.
  factory UserOrganizationProjectCollection.fromJson(Map<String, dynamic> json) =>
      _$UserOrganizationProjectCollectionFromJson(json);

  @JsonKey(name: 'UserOrganizationProjects')
  List<UserOrganizationProject>? userOrganizationProjects;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$UserOrganizationProjectCollectionToJson].
  Map<String, dynamic> toJson() => _$UserOrganizationProjectCollectionToJson(this);
  // coverage:ignore-end
}