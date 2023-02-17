import 'package:json_annotation/json_annotation.dart';

import '../common/api_model.dart';
import 'query_result.dart';

part 'document_folder.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class DocumentFolder extends Entity {
  DocumentFolder();

  /// A necessary factory constructor for creating a new DocumentFolder instance
  /// from a map. Pass the map to the generated [_$DocumentFolderFromJson()] constructor.
  /// The constructor is named after the source class, in this case, DocumentFolder.
  factory DocumentFolder.fromJson(Map<String, dynamic> json) => _$DocumentFolderFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'UniqueID')
  String? uniqueID;

  @JsonKey(name: 'ParentID')
  String? parentID;

  @JsonKey(name: 'AncestorIDs')
  List<String>? ancestorIDs;

  @JsonKey(name: 'OrganizationID')
  String? organizationID;

  @JsonKey(name: 'ProjectID')
  String? projectID;

  @JsonKey(name: 'ProjectName')
  String? projectName;

  @JsonKey(name: 'ProjectAccessType')
  String? projectAccessType;

  @JsonKey(name: 'CreatedOn')
  String? createdOn;

  @JsonKey(name: 'CreatedByUserEmail')
  String? createdByUserEmail;

  @JsonKey(name: 'CreatedByUserName')
  String? createdByUserName;

  @JsonKey(name: 'CreatedByUserID')
  String? createdByUserID;

  @JsonKey(name: 'ModifiedOn')
  String? modifiedOn;

  @JsonKey(name: 'ModifiedByUserEmail')
  String? modifiedByUserEmail;

  @JsonKey(name: 'ModifiedByUserName')
  String? modifiedByUserName;

  @JsonKey(name: 'ModifiedByUserID')
  String? modifiedByUserID;

  @JsonKey(name: 'Name')
  String? name;

  @JsonKey(name: 'NameLower')
  String? nameLower;

  @JsonKey(name: 'Depth')
  int? depth;

  @JsonKey(name: 'AncestorAssignmentUserEmails')
  List<String>? ancestorAssignmentUserEmails;

  @JsonKey(name: 'AssignmentUserEmails')
  List<String>? assignmentUserEmails;

  @JsonKey(name: 'HexColor')
  String? hexColor;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentFolderToJson].
  @override
  Map<String, dynamic> toJson() => _$DocumentFolderToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class DocumentFolderCollection implements IQueryResultEntityCollection {
  DocumentFolderCollection();

  /// A necessary factory constructor for creating a new DocumentFolderCollection instance
  /// from a map. Pass the map to the generated [_$DocumentFolderFromJson()] constructor.
  /// The constructor is named after the source class, in this case, DocumentFolderCollection.
  factory DocumentFolderCollection.fromJson(Map<String, dynamic> json) =>
      _$DocumentFolderCollectionFromJson(json);

  @JsonKey(name: 'DocumentFolders')
  List<DocumentFolder>? documentFolders;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentFolderCollectionToJson].
  Map<String, dynamic> toJson() => _$DocumentFolderCollectionToJson(this);
  // coverage:ignore-end
}
