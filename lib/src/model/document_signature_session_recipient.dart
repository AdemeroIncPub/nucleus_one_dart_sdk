import '../api_model/document_signature_session_recipient.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

class DocumentSignatureSessionRecipient extends Entity with NucleusOneAppDependent {
  DocumentSignatureSessionRecipient._({
    NucleusOneApp? app,
    required this.id,
    required this.tenantID,
    required this.documentID,
    required this.documentCreatedOn,
    required this.documentBucketName,
    required this.documentThumbnailObjectName,
    required this.documentName,
    required this.documentNameLower,
    required this.documentPageCount,
    required this.documentFileSize,
    required this.documentClassificationID,
    required this.documentClassificationName,
    required this.documentClassificationNameLower,
    required this.documentPreviewMetadata,
    required this.documentSignatureSessionID,
    required this.documentSignatureSessionIsActive,
    required this.documentSignatureSessionIsComplete,
    required this.uniqueID,
    required this.rank,
    required this.email,
    required this.fullName,
    required this.type,
    required this.tenantMemberID,
    required this.signingRequestSent,
    required this.requestedOn,
    required this.isActive,
    required this.isComplete,
    required this.completedOn,
    required this.ipAddress,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory DocumentSignatureSessionRecipient.fromApiModel(
    api_mod.DocumentSignatureSessionRecipient apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionRecipient._(
      app: app,
      id: apiModel.id!,
      tenantID: apiModel.tenantID!,
      documentID: apiModel.documentID!,
      documentCreatedOn: apiModel.documentCreatedOn!,
      documentBucketName: apiModel.documentBucketName!,
      documentThumbnailObjectName: apiModel.documentThumbnailObjectName!,
      documentName: apiModel.documentName!,
      documentNameLower: apiModel.documentNameLower!,
      documentPageCount: apiModel.documentPageCount!,
      documentFileSize: apiModel.documentFileSize!,
      documentClassificationID: apiModel.documentClassificationID!,
      documentClassificationName: apiModel.documentClassificationName!,
      documentClassificationNameLower: apiModel.documentClassificationNameLower!,
      documentPreviewMetadata: (apiModel.documentPreviewMetadata == null)
          ? null
          : apiModel.documentPreviewMetadata!.toList(),
      documentSignatureSessionID: apiModel.documentSignatureSessionID!,
      documentSignatureSessionIsActive: apiModel.documentSignatureSessionIsActive!,
      documentSignatureSessionIsComplete: apiModel.documentSignatureSessionIsComplete!,
      uniqueID: apiModel.uniqueID!,
      rank: apiModel.rank!,
      email: apiModel.email!,
      fullName: apiModel.fullName!,
      type: apiModel.type!,
      tenantMemberID: apiModel.tenantMemberID!,
      signingRequestSent: apiModel.signingRequestSent!,
      requestedOn: apiModel.requestedOn!,
      isActive: apiModel.isActive!,
      isComplete: apiModel.isComplete!,
      completedOn: apiModel.completedOn!,
      ipAddress: apiModel.ipAddress!,
    );
  }

  String id;

  String tenantID;

  String documentID;

  String documentCreatedOn;

  String documentBucketName;

  String documentThumbnailObjectName;

  String documentName;

  String documentNameLower;

  int documentPageCount;

  int documentFileSize;

  String documentClassificationID;

  String documentClassificationName;

  String documentClassificationNameLower;

  List<Map<String, String>>? documentPreviewMetadata;

  String documentSignatureSessionID;

  bool documentSignatureSessionIsActive;

  bool documentSignatureSessionIsComplete;

  String uniqueID;

  int rank;

  String email;

  String fullName;

  String type;

  String tenantMemberID;

  bool signingRequestSent;

  String requestedOn;

  bool isActive;

  bool isComplete;

  String completedOn;

  String ipAddress;

  @override
  api_mod.DocumentSignatureSessionRecipient toApiModel() {
    return api_mod.DocumentSignatureSessionRecipient()
      ..id = id
      ..tenantID = tenantID
      ..documentID = documentID
      ..documentCreatedOn = documentCreatedOn
      ..documentBucketName = documentBucketName
      ..documentThumbnailObjectName = documentThumbnailObjectName
      ..documentName = documentName
      ..documentNameLower = documentNameLower
      ..documentPageCount = documentPageCount
      ..documentFileSize = documentFileSize
      ..documentClassificationID = documentClassificationID
      ..documentClassificationName = documentClassificationName
      ..documentClassificationNameLower = documentClassificationNameLower
      ..documentPreviewMetadata = documentPreviewMetadata
      ..documentSignatureSessionID = documentSignatureSessionID
      ..documentSignatureSessionIsActive = documentSignatureSessionIsActive
      ..documentSignatureSessionIsComplete = documentSignatureSessionIsComplete
      ..uniqueID = uniqueID
      ..rank = rank
      ..email = email
      ..fullName = fullName
      ..type = type
      ..tenantMemberID = tenantMemberID
      ..signingRequestSent = signingRequestSent
      ..requestedOn = requestedOn
      ..isActive = isActive
      ..isComplete = isComplete
      ..completedOn = completedOn
      ..ipAddress = ipAddress;
  }
}
