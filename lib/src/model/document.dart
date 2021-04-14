import '../api_model/document.dart' as api_model;
import 'preview_metadata_item.dart';

class Document {
  Document._(
      {required this.uniqueID,
      required this.documentID,
      required this.createdOn,
      required this.purgeDate,
      required this.name,
      required this.pageCount,
      required this.fileSize,
      required this.thumbnailUrl,
      required this.isSigned,
      required this.classificationID,
      required this.classificationName,
      required this.previewMetadata,
      required this.documentApprovalID,
      required this.documentApprovalCreatedOn,
      required this.documentSubscriptionID,
      required this.documentSubscriptionCreatedOn,
      required this.documentSignatureSessionRecipientID,
      required this.documentSignatureSessionID,
      required this.documentSignatureSessionRecipientEmail,
      required this.documentSignatureSessionRecipientFullName,
      required this.documentSignatureSessionRecipientRequestedOn,
      required this.roleName,
      required this.processName,
      required this.processElementName,
      required this.score});

  factory Document.fromApiModel(api_model.Document apiModel) {
    return Document._(
        uniqueID: apiModel.uniqueID!,
        documentID: apiModel.documentID!,
        createdOn: apiModel.createdOn!,
        purgeDate: apiModel.purgeDate!,
        name: apiModel.name!,
        pageCount: apiModel.pageCount!,
        fileSize: apiModel.fileSize!,
        thumbnailUrl: apiModel.thumbnailUrl!,
        isSigned: apiModel.isSigned!,
        classificationID: apiModel.classificationID!,
        classificationName: apiModel.classificationName!,
        previewMetadata:
            apiModel.previewMetadata?.map((x) => PreviewMetadataItem.fromApiModel(x)).toList(),
        documentApprovalID: apiModel.documentApprovalID!,
        documentApprovalCreatedOn: apiModel.documentApprovalCreatedOn!,
        documentSubscriptionID: apiModel.documentSubscriptionID!,
        documentSubscriptionCreatedOn: apiModel.documentSubscriptionCreatedOn!,
        documentSignatureSessionRecipientID: apiModel.documentSignatureSessionRecipientID!,
        documentSignatureSessionID: apiModel.documentSignatureSessionID!,
        documentSignatureSessionRecipientEmail: apiModel.documentSignatureSessionRecipientEmail!,
        documentSignatureSessionRecipientFullName:
            apiModel.documentSignatureSessionRecipientFullName!,
        documentSignatureSessionRecipientRequestedOn:
            apiModel.documentSignatureSessionRecipientRequestedOn!,
        roleName: apiModel.roleName!,
        processName: apiModel.processName!,
        processElementName: apiModel.processElementName!,
        score: apiModel.score!);
  }

  String uniqueID;

  String documentID;

  String createdOn;

  String purgeDate;

  String name;

  int pageCount;

  int fileSize;

  String thumbnailUrl;

  bool isSigned;

  String classificationID;

  String classificationName;

  List<PreviewMetadataItem>? previewMetadata;

  String documentApprovalID;

  String documentApprovalCreatedOn;

  String documentSubscriptionID;

  String documentSubscriptionCreatedOn;

  String documentSignatureSessionRecipientID;

  String documentSignatureSessionID;

  String documentSignatureSessionRecipientEmail;

  String documentSignatureSessionRecipientFullName;

  String documentSignatureSessionRecipientRequestedOn;

  String roleName;

  String processName;

  String processElementName;

  int score;

  api_model.Document toApiModel() {
    return api_model.Document()
      ..uniqueID = uniqueID
      ..documentID = documentID
      ..createdOn = createdOn
      ..purgeDate = purgeDate
      ..name = name
      ..pageCount = pageCount
      ..fileSize = fileSize
      ..thumbnailUrl = thumbnailUrl
      ..isSigned = isSigned
      ..classificationID = classificationID
      ..classificationName = classificationName
      ..previewMetadata = previewMetadata!.map((x) => x.toApiModel()).toList()
      ..documentApprovalID = documentApprovalID
      ..documentApprovalCreatedOn = documentApprovalCreatedOn
      ..documentSubscriptionID = documentSubscriptionID
      ..documentSubscriptionCreatedOn = documentSubscriptionCreatedOn
      ..documentSignatureSessionRecipientID = documentSignatureSessionRecipientID
      ..documentSignatureSessionID = documentSignatureSessionID
      ..documentSignatureSessionRecipientEmail = documentSignatureSessionRecipientEmail
      ..documentSignatureSessionRecipientFullName = documentSignatureSessionRecipientFullName
      ..documentSignatureSessionRecipientRequestedOn = documentSignatureSessionRecipientRequestedOn
      ..roleName = roleName
      ..processName = processName
      ..processElementName = processElementName
      ..score = score;
  }
}
