import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';
import 'query_result.dart';

part 'approval.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class ApprovalCollection implements IQueryResultEntityCollection {
  ApprovalCollection();

  /// A necessary factory constructor for creating a new FieldCollection instance
  /// from a map. Pass the map to the generated [_$ApprovalCollectionFromJson()] constructor.
  /// The constructor is named after the source class, in this case, FieldCollection.
  factory ApprovalCollection.fromJson(Map<String, dynamic> json) =>
      _$ApprovalCollectionFromJson(json);

  @JsonKey(name: 'Approvals')
  List<Approval>? approvals;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$ApprovalCollectionToJson].
  Map<String, dynamic> toJson() => _$ApprovalCollectionToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class Approval extends Entity {
  Approval();

  /// A necessary factory constructor for creating a new Approval instance
  /// from a map. Pass the map to the generated [_$ApprovalFromJson()] constructor.
  /// The constructor is named after the source class, in this case, Approval.
  factory Approval.fromJson(Map<String, dynamic> json) => _$ApprovalFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'CreatedOn')
  String? createdOn;

  @JsonKey(name: 'RoleID')
  String? roleID;

  @JsonKey(name: 'RoleName')
  String? roleName;

  @JsonKey(name: 'ProcessID')
  String? processID;

  @JsonKey(name: 'ProcessName')
  String? processName;

  @JsonKey(name: 'ProcessElementID')
  String? processElementID;

  @JsonKey(name: 'ProcessElementName')
  String? processElementName;

  @JsonKey(name: 'ParticipationType')
  String? participationType;

  @JsonKey(name: 'ApprovingTenantMemberIDs')
  Map<String, bool>? approvingTenantMemberIDs;

  @JsonKey(name: 'Result')
  String? result;

  @JsonKey(name: 'ItemType')
  String? itemType;

  @JsonKey(name: 'ItemID')
  String? itemID;

  @JsonKey(name: 'ItemCreatedOn')
  String? itemCreatedOn;

  @JsonKey(name: 'ItemCreatedByUserID')
  String? itemCreatedByUserID;

  @JsonKey(name: 'ItemCreatedByUserEmail')
  String? itemCreatedByUserEmail;

  @JsonKey(name: 'ItemCreatedByUserName')
  String? itemCreatedByUserName;

  @JsonKey(name: 'ItemCompletedOn')
  String? itemCompletedOn;

  @JsonKey(name: 'ItemCompletedByUserID')
  String? itemCompletedByUserID;

  @JsonKey(name: 'ItemCompletedByUserEmail')
  String? itemCompletedByUserEmail;

  @JsonKey(name: 'ItemCompletedByUserName')
  String? itemCompletedByUserName;

  @JsonKey(name: 'ItemName')
  String? itemName;

  @JsonKey(name: 'ItemDescription')
  String? itemDescription;

  @JsonKey(name: 'DocumentName')
  String? documentName;

  @JsonKey(name: 'DocumentCreatedOn')
  String? documentCreatedOn;

  @JsonKey(name: 'DocumentCreatedByUserID')
  String? documentCreatedByUserID;

  @JsonKey(name: 'DocumentCreatedByUserEmail')
  String? documentCreatedByUserEmail;

  @JsonKey(name: 'DocumentCreatedByUserName')
  String? documentCreatedByUserName;

  @JsonKey(name: 'DocumentPageCount')
  int? documentPageCount;

  @JsonKey(name: 'DocumentFileSize')
  int? documentFileSize;

  @JsonKey(name: 'DocumentClassificationID')
  String? documentClassificationID;

  @JsonKey(name: 'DocumentClassificationName')
  String? documentClassificationName;

  @JsonKey(name: 'DocumentPreviewMetadata')
  List<Map<String, String>>? documentPreviewMetadata;

  @JsonKey(name: 'DocumentIsSigned')
  bool? documentIsSigned;

  @JsonKey(name: 'WorkTaskDueOn')
  String? workTaskDueOn;

  @JsonKey(name: 'ThumbnailUrl')
  String? thumbnailUrl;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$ApprovalToJson].
  @override
  Map<String, dynamic> toJson() => _$ApprovalToJson(this);
  // coverage:ignore-end
}
