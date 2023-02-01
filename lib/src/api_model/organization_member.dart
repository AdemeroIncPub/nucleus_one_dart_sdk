import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';

part 'organization_member.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class OrganizationMember extends Entity {
  OrganizationMember();

  /// A necessary factory constructor for creating a new OrganizationMember instance
  /// from a map. Pass the map to the generated [_$OrganizationMemberFromJson()] constructor.
  /// The constructor is named after the source class, in this case, OrganizationMember.
  factory OrganizationMember.fromJson(Map<String, dynamic> json) =>
      _$OrganizationMemberFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'CreatedOn')
  String? createdOn;

  @JsonKey(name: 'OrganizationID')
  String? organizationID;

  @JsonKey(name: 'OrganizationName')
  String? organizationName;

  @JsonKey(name: 'UserID')
  String? userID;

  @JsonKey(name: 'UserName')
  String? userName;

  @JsonKey(name: 'UserNameLower')
  String? userNameLower;

  @JsonKey(name: 'UserEmail')
  String? userEmail;

  @JsonKey(name: 'Disabled')
  bool? disabled;

  @JsonKey(name: 'IsReadOnly')
  bool? isReadOnly;

  @JsonKey(name: 'IsAdmin')
  bool? isAdmin;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$OrganizationMemberToJson].
  @override
  Map<String, dynamic> toJson() => _$OrganizationMemberToJson(this);
  // coverage:ignore-end
}