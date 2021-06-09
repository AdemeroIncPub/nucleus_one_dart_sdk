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

  @JsonKey(name: 'Origin')
  String? origin;

  @JsonKey(name: 'IsActive')
  bool? isActive;

  @JsonKey(name: 'IsClassified')
  bool? isClassified;

  @JsonKey(name: 'IsMarkedForPurge')
  bool? isMarkedForPurge;

  @JsonKey(name: 'IsSigned')
  bool? isSigned;

  @JsonKey(name: 'SignatureSessionIsActive')
  bool? signatureSessionIsActive;

  @JsonKey(name: 'HasSinglePageImages')
  bool? hasSinglePageImages;

  @JsonKey(name: 'SignaturesCompletedOn')
  String? signaturesCompletedOn;

  @JsonKey(name: 'PurgeMarkedOn')
  String? purgeMarkedOn;

  @JsonKey(name: 'FailedBuildAttempts')
  bool? failedBuildAttempts;

  @JsonKey(name: 'LastError')
  String? lastError;

  @JsonKey(name: 'PageCount')
  int? pageCount;

  @JsonKey(name: 'FileSize')
  int? fileSize;

  @JsonKey(name: 'BucketName')
  String? bucketName;

  @JsonKey(name: 'SourceObjectName')
  String? sourceObjectName;

  @JsonKey(name: 'ThumbnailObjectName')
  String? thumbnailObjectName;

  @JsonKey(name: 'ClassificationID')
  String? classificationID;

  @JsonKey(name: 'ClassificationName')
  String? classificationName;

  @JsonKey(name: 'ClassificationNameLower')
  String? classificationNameLower;

  @JsonKey(name: 'PreviewMetadata')
  List<PreviewMetadataItem>? previewMetadata;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentToJson].
  Map<String, dynamic> toJson() => _$DocumentToJson(this);
  // coverage:ignore-end
}
