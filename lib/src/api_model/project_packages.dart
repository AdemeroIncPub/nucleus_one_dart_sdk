import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';

import 'project.dart';

part 'project_packages.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class ProjectPackage extends Entity {
  ProjectPackage();

  /// A necessary factory constructor for creating a new ProjectPackage instance
  /// from a map. Pass the map to the generated [_$ProjectPackageFromJson()] constructor.
  /// The constructor is named after the source class, in this case, ProjectPackage.
  factory ProjectPackage.fromJson(Map<String, dynamic> json) => _$ProjectPackageFromJson(json);

  @JsonKey(name: 'Tenant')
  Project? tenant;

  @JsonKey(name: 'TenantMember')
  ProjectMember? tenantMember;

  @JsonKey(name: 'IsAdmin')
  bool? isAdmin;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$ProjectPackageToJson].
  @override
  Map<String, dynamic> toJson() => _$ProjectPackageToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
class ProjectPackageCollection extends EntityCollection<ProjectPackage> {
  ProjectPackageCollection() : super();

  factory ProjectPackageCollection.fromJson(List<Map<String, dynamic>> json) {
    return EntityCollection.fromJsonArray(
      json: json,
      instance: ProjectPackageCollection(),
      entityFromJsonCallback: (x) => ProjectPackage.fromJson(x),
    );
  }
}
