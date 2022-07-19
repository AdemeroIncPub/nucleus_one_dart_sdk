import 'package:json_annotation/json_annotation.dart';

import '../common/api_model.dart';

part 'user_organization.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class UserOrganization extends Entity {
  UserOrganization();

  /// A necessary factory constructor for creating a new UserOrganization instance
  /// from a map. Pass the map to the generated [_$UserOrganizationFromJson()] constructor.
  /// The constructor is named after the source class, in this case, UserOrganization.
  factory UserOrganization.fromJson(Map<String, dynamic> json) => _$UserOrganizationFromJson(json);

  @JsonKey(name: 'UserEmail')
  String? userEmail;

  @JsonKey(name: 'OrganizationID')
  String? organizationID;

  @JsonKey(name: 'OrganizationName')
  String? organizationName;

  @JsonKey(name: 'AssignmentTypes')
  List<String>? assignmentTypes;

  @JsonKey(name: 'HasAssignment')
  bool? hasAssignment;

  @JsonKey(name: 'IsOrganizationMember')
  bool? isOrganizationMember;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$UserOrganizationToJson].
  @override
  Map<String, dynamic> toJson() => _$UserOrganizationToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
class UserOrganizationCollection extends EntityCollection<UserOrganization> {
  UserOrganizationCollection() : super();

  /// This JSON structure has an array at its root, which is not currently implicitly supported by json_serializable.
  /// https://github.com/google/json_serializable.dart/issues/648
  factory UserOrganizationCollection.fromJson(List<dynamic> json) {
    return UserOrganizationCollection()
      ..items = json.map((m) => UserOrganization.fromJson(m)).toList();
  }
}
