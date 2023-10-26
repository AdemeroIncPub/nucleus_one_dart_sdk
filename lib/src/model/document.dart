import '../api_model/document.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

class Document extends Entity with NucleusOneAppDependent {
  Document._({
    NucleusOneApp? app,
    required this.id,
    required this.organizationID,
    required this.projectID,
    required this.projectName,
    required this.projectAccessType,
    required this.documentID,
    required this.documentFolderID,
    required this.documentFolderPath,
    required this.assignmentUserEmails,
    required this.groupID,
    required this.createdOn,
    required this.createdByUserEmail,
    required this.createdByUserName,
    required this.modifiedOn,
    required this.modifiedByUserEmail,
    required this.modifiedByUserName,
    required this.purgeDate,
    required this.name,
    required this.origin,
    required this.pageCount,
    required this.fileSize,
    required this.thumbnailUrl,
    required this.isSigned,
    required this.previewMetadata,
    required this.approvalID,
    required this.approvalCreatedOn,
    required this.isMarkedForPurge,
    required this.hasSinglePageImages,
    required this.signatureSessionIsActive,
    required this.signaturesCompletedOn,
    required this.documentSubscriptionID,
    required this.documentSubscriptionCreatedOn,
    required this.processName,
    required this.processElementName,
    required this.revision,
    required this.paperSize,
    required this.paperOrientation,
    required this.paperMarginLeft,
    required this.paperMarginRight,
    required this.paperMarginTop,
    required this.paperMarginBottom,
  }) {
    this.app = getEffectiveNucleusOneApp(app);
  }

  factory Document.fromApiModel(
    api_mod.Document apiModel, {
    NucleusOneApp? app,
  }) {
    return Document._(
      app: app,
      id: apiModel.id!,
      organizationID: apiModel.organizationID!,
      projectID: apiModel.projectID!,
      projectName: apiModel.projectName!,
      projectAccessType: apiModel.projectAccessType!,
      documentID: apiModel.documentID!,
      documentFolderID: apiModel.documentFolderID!,
      documentFolderPath: apiModel.documentFolderPath!,
      assignmentUserEmails: apiModel.assignmentUserEmails ?? [],
      groupID: apiModel.groupID!,
      createdOn: apiModel.createdOn!,
      createdByUserEmail: apiModel.createdByUserEmail!,
      createdByUserName: apiModel.createdByUserName!,
      modifiedOn: apiModel.modifiedOn!,
      modifiedByUserEmail: apiModel.modifiedByUserEmail!,
      modifiedByUserName: apiModel.modifiedByUserName!,
      purgeDate: apiModel.purgeDate!,
      name: apiModel.name!,
      origin: apiModel.origin!,
      pageCount: apiModel.pageCount!,
      fileSize: apiModel.fileSize!,
      thumbnailUrl: apiModel.thumbnailUrl!,
      isSigned: apiModel.isSigned!,
      previewMetadata: apiModel.previewMetadata,
      approvalID: apiModel.approvalID!,
      approvalCreatedOn: apiModel.approvalCreatedOn!,
      isMarkedForPurge: apiModel.isMarkedForPurge!,
      hasSinglePageImages: apiModel.hasSinglePageImages!,
      signatureSessionIsActive: apiModel.signatureSessionIsActive!,
      signaturesCompletedOn: apiModel.signaturesCompletedOn!,
      documentSubscriptionID: apiModel.documentSubscriptionID!,
      documentSubscriptionCreatedOn: apiModel.documentSubscriptionCreatedOn!,
      processName: apiModel.processName!,
      processElementName: apiModel.processElementName!,
      revision: apiModel.revision!,
      paperSize: apiModel.paperSize!,
      paperOrientation: apiModel.paperOrientation!,
      paperMarginLeft: apiModel.paperMarginLeft!,
      paperMarginRight: apiModel.paperMarginRight!,
      paperMarginTop: apiModel.paperMarginTop!,
      paperMarginBottom: apiModel.paperMarginBottom!,
    );
  }

  String id;

  String organizationID;

  String projectID;

  String projectName;

  String projectAccessType;

  String documentID;

  String documentFolderID;

  String documentFolderPath;

  List<String> assignmentUserEmails;

  String groupID;

  String createdOn;

  String createdByUserEmail;

  String createdByUserName;

  String modifiedOn;

  String modifiedByUserEmail;

  String modifiedByUserName;

  String purgeDate;

  String name;

  String origin;

  int pageCount;

  int fileSize;

  String thumbnailUrl;

  bool isSigned;

  List<Map<String, String>>? previewMetadata;

  String approvalID;

  String approvalCreatedOn;

  bool isMarkedForPurge;

  bool hasSinglePageImages;

  bool signatureSessionIsActive;

  String signaturesCompletedOn;

  String documentSubscriptionID;

  String documentSubscriptionCreatedOn;

  String processName;

  String processElementName;

  int revision;

  String paperSize;

  String paperOrientation;

  double paperMarginLeft;

  double paperMarginRight;

  double paperMarginTop;

  double paperMarginBottom;

  @override
  api_mod.Document toApiModel() {
    return api_mod.Document()
      ..id = id
      ..organizationID = organizationID
      ..projectID = projectID
      ..projectName = projectName
      ..projectAccessType = projectAccessType
      ..documentID = documentID
      ..documentFolderID = documentFolderID
      ..documentFolderPath = documentFolderPath
      ..assignmentUserEmails = assignmentUserEmails.toList()
      ..groupID = groupID
      ..createdOn = createdOn
      ..createdByUserEmail = createdByUserEmail
      ..createdByUserName = createdByUserName
      ..modifiedOn = modifiedOn
      ..modifiedByUserEmail = modifiedByUserEmail
      ..modifiedByUserName = modifiedByUserName
      ..purgeDate = purgeDate
      ..name = name
      ..origin = origin
      ..pageCount = pageCount
      ..fileSize = fileSize
      ..thumbnailUrl = thumbnailUrl
      ..isSigned = isSigned
      ..previewMetadata = previewMetadata
      ..approvalID = approvalID
      ..approvalCreatedOn = approvalCreatedOn
      ..isMarkedForPurge = isMarkedForPurge
      ..hasSinglePageImages = hasSinglePageImages
      ..signatureSessionIsActive = signatureSessionIsActive
      ..signaturesCompletedOn = signaturesCompletedOn
      ..documentSubscriptionID = documentSubscriptionID
      ..documentSubscriptionCreatedOn = documentSubscriptionCreatedOn
      ..processName = processName
      ..processElementName = processElementName
      ..revision = revision
      ..paperSize = paperSize
      ..paperOrientation = paperOrientation
      ..paperMarginLeft = paperMarginLeft
      ..paperMarginRight = paperMarginRight
      ..paperMarginTop = paperMarginTop
      ..paperMarginBottom = paperMarginBottom;
  }
}

class DocumentCollection extends EntityCollection<Document, api_mod.DocumentCollection> {
  DocumentCollection({
    NucleusOneApp? app,
    List<Document>? items,
  }) : super(app: app, items: items);

  factory DocumentCollection.fromApiModel(
    api_mod.DocumentCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentCollection(
      app: app,
      items: apiModel.documents?.map((x) => Document.fromApiModel(x, app: app)).toList(),
    );
  }

  @override
  api_mod.DocumentCollection toApiModel() {
    return api_mod.DocumentCollection()..documents = items.map((x) => x.toApiModel()).toList();
  }
}
