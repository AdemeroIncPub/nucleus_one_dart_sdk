import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';

part 'document_signature_session.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class DocumentSignatureSession extends Entity {
  DocumentSignatureSession();

  /// A necessary factory constructor for creating a new DocumentSignatureSession instance
  /// from a map. Pass the map to the generated [_$DocumentSignatureSessionFromJson()] constructor.
  /// The constructor is named after the source class, in this case, DocumentSignatureSession.
  factory DocumentSignatureSession.fromJson(Map<String, dynamic> json) =>
      _$DocumentSignatureSessionFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'CreatedOn')
  String? createdOn;

  @JsonKey(name: 'ModifiedOn')
  String? modifiedOn;

  @JsonKey(name: 'CreatedByUserID')
  String? createdByUserID;

  @JsonKey(name: 'CreatedByUserEmail')
  String? createdByUserEmail;

  @JsonKey(name: 'CreatedByUserName')
  String? createdByUserName;

  @JsonKey(name: 'LastModifiedByUserID')
  String? lastModifiedByUserID;

  @JsonKey(name: 'LastModifiedByUserEmail')
  String? lastModifiedByUserEmail;

  @JsonKey(name: 'LastModifiedByUserName')
  String? lastModifiedByUserName;

  @JsonKey(name: 'DocumentID')
  String? documentID;

  @JsonKey(name: 'DocumentRevisionID')
  String? documentRevisionID;

  @JsonKey(name: 'IsActive')
  bool? isActive;

  @JsonKey(name: 'IsComplete')
  bool? isComplete;

  @JsonKey(name: 'WasStopped')
  bool? wasStopped;

  @JsonKey(name: 'CompletedOn')
  String? completedOn;

  @JsonKey(name: 'IsRendered')
  bool? isRendered;

  @JsonKey(name: 'RenderedOn')
  String? renderedOn;

  @JsonKey(name: 'FormDesignType')
  String? formDesignType;

  @JsonKey(name: 'UseAccessCode')
  bool? useAccessCode;

  @JsonKey(name: 'AccessCode')
  String? accessCode;

  @JsonKey(name: 'UseCustomSubjectAndBody')
  bool? useCustomSubjectAndBody;

  @JsonKey(name: 'CustomSubject')
  String? customSubject;

  @JsonKey(name: 'CustomBody')
  String? customBody;

  @JsonKey(name: 'QuickDesignPlaceInitials')
  bool? quickDesignPlaceInitials;

  @JsonKey(name: 'QuickDesignPlaceFullName')
  bool? quickDesignPlaceFullName;

  @JsonKey(name: 'QuickDesignPlaceEmail')
  bool? quickDesignPlaceEmail;

  @JsonKey(name: 'QuickDesignPlaceTitle')
  bool? quickDesignPlaceTitle;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentSignatureSessionToJson].
  @override
  Map<String, dynamic> toJson() => _$DocumentSignatureSessionToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class DocumentSignatureSessionRecipient extends Entity {
  DocumentSignatureSessionRecipient();

  /// A necessary factory constructor for creating a new DocumentSignatureSessionRecipient instance
  /// from a map. Pass the map to the generated [_$DocumentSignatureSessionRecipientFromJson()] constructor.
  /// The constructor is named after the source class, in this case, DocumentSignatureSessionRecipient.
  factory DocumentSignatureSessionRecipient.fromJson(Map<String, dynamic> json) =>
      _$DocumentSignatureSessionRecipientFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'TenantID')
  String? tenantID;

  @JsonKey(name: 'DocumentID')
  String? documentID;

  @JsonKey(name: 'DocumentCreatedOn')
  String? documentCreatedOn;

  @JsonKey(name: 'DocumentBucketName')
  String? documentBucketName;

  @JsonKey(name: 'DocumentThumbnailObjectName')
  String? documentThumbnailObjectName;

  @JsonKey(name: 'DocumentName')
  String? documentName;

  @JsonKey(name: 'DocumentNameLower')
  String? documentNameLower;

  @JsonKey(name: 'DocumentPageCount')
  int? documentPageCount;

  @JsonKey(name: 'DocumentFileSize')
  int? documentFileSize;

  @JsonKey(name: 'DocumentClassificationID')
  String? documentClassificationID;

  @JsonKey(name: 'DocumentClassificationName')
  String? documentClassificationName;

  @JsonKey(name: 'DocumentClassificationNameLower')
  String? documentClassificationNameLower;

  @JsonKey(name: 'DocumentPreviewMetadata')
  List<Map<String, String>>? documentPreviewMetadata;

  @JsonKey(name: 'DocumentSignatureSessionID')
  String? documentSignatureSessionID;

  @JsonKey(name: 'DocumentSignatureSessionIsActive')
  bool? documentSignatureSessionIsActive;

  @JsonKey(name: 'DocumentSignatureSessionIsComplete')
  bool? documentSignatureSessionIsComplete;

  @JsonKey(name: 'UniqueID')
  String? uniqueID;

  @JsonKey(name: 'Rank')
  int? rank;

  @JsonKey(name: 'Email')
  String? email;

  @JsonKey(name: 'FullName')
  String? fullName;

  @JsonKey(name: 'Type')
  String? type;

  @JsonKey(name: 'TenantMemberID')
  String? tenantMemberID;

  @JsonKey(name: 'SigningRequestSent')
  bool? signingRequestSent;

  @JsonKey(name: 'RequestedOn')
  String? requestedOn;

  @JsonKey(name: 'IsActive')
  bool? isActive;

  @JsonKey(name: 'IsComplete')
  bool? isComplete;

  @JsonKey(name: 'CompletedOn')
  String? completedOn;

  @JsonKey(name: 'IPAddress')
  String? ipAddress;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentSignatureSessionRecipientToJson].
  @override
  Map<String, dynamic> toJson() => _$DocumentSignatureSessionRecipientToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
class DocumentSignatureSessionPackageCollection
    extends EntityCollection<DocumentSignatureSessionPackage> {
  DocumentSignatureSessionPackageCollection() : super();

  factory DocumentSignatureSessionPackageCollection.fromJson(List<dynamic> json) {
    return EntityCollection.fromJsonArray(
      json: json,
      instance: DocumentSignatureSessionPackageCollection(),
      entityFromJsonCallback: (x) => DocumentSignatureSessionPackage.fromJson(x),
    );
  }
}

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class DocumentSignatureSessionPackage extends Entity {
  DocumentSignatureSessionPackage();

  /// A necessary factory constructor for creating a new DocumentSignatureSessionPackage instance
  /// from a map. Pass the map to the generated [_$DocumentSignatureSessionPackageFromJson()] constructor.
  /// The constructor is named after the source class, in this case, DocumentSignatureSessionPackage.
  factory DocumentSignatureSessionPackage.fromJson(Map<String, dynamic> json) =>
      _$DocumentSignatureSessionPackageFromJson(json);

  @JsonKey(name: 'Session')
  DocumentSignatureSession? session;

  @JsonKey(name: 'Recipients')
  List<DocumentSignatureSessionRecipient>? recipients;

  @JsonKey(name: 'BeginSession')
  bool? beginSession;

  @JsonKey(name: 'ResetSession')
  bool? resetSession;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentSignatureSessionPackageToJson].
  @override
  Map<String, dynamic> toJson() => _$DocumentSignatureSessionPackageToJson(this);
  // coverage:ignore-end
}
