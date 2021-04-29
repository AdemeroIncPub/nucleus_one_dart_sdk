import 'package:json_annotation/json_annotation.dart';

import 'preview_metadata_item.dart';

part 'document.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class Document {
  Document();

  /// A necessary factory constructor for creating a new Document instance
  /// from a map. Pass the map to the generated [_$DocumentFromJson()] constructor.
  /// The constructor is named after the source class, in this case, Document.
  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'DocumentID')
  String? documentID;

  @JsonKey(name: 'CreatedOn')
  String? createdOn;

  @JsonKey(name: 'PurgeDate')
  String? purgeDate;

  @JsonKey(name: 'Name')
  String? name;

  @JsonKey(name: 'PageCount')
  int? pageCount;

  @JsonKey(name: 'FileSize')
  int? fileSize;

  @JsonKey(name: 'ThumbnailUrl')
  String? thumbnailUrl;

  @JsonKey(name: 'IsSigned')
  bool? isSigned;

  @JsonKey(name: 'ClassificationID')
  String? classificationID;

  @JsonKey(name: 'ClassificationName')
  String? classificationName;

  @JsonKey(name: 'PreviewMetadata')
  List<PreviewMetadataItem>? previewMetadata;

  @JsonKey(name: 'DocumentApprovalID')
  String? documentApprovalID;

  @JsonKey(name: 'DocumentApprovalCreatedOn')
  String? documentApprovalCreatedOn;

  @JsonKey(name: 'DocumentSubscriptionID')
  String? documentSubscriptionID;

  @JsonKey(name: 'DocumentSubscriptionCreatedOn')
  String? documentSubscriptionCreatedOn;

  @JsonKey(name: 'DocumentSignatureSessionRecipientID')
  String? documentSignatureSessionRecipientID;

  @JsonKey(name: 'DocumentSignatureSessionID')
  String? documentSignatureSessionID;

  @JsonKey(name: 'DocumentSignatureSessionRecipientEmail')
  String? documentSignatureSessionRecipientEmail;

  @JsonKey(name: 'DocumentSignatureSessionRecipientFullName')
  String? documentSignatureSessionRecipientFullName;

  @JsonKey(name: 'DocumentSignatureSessionRecipientRequestedOn')
  String? documentSignatureSessionRecipientRequestedOn;

  @JsonKey(name: 'RoleName')
  String? roleName;

  @JsonKey(name: 'ProcessName')
  String? processName;

  @JsonKey(name: 'ProcessElementName')
  String? processElementName;

  @JsonKey(name: 'Score')
  int? score;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentToJson].
  Map<String, dynamic> toJson() => _$DocumentToJson(this);
  // coverage:ignore-end
}
