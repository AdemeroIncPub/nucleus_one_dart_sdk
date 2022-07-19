import 'package:get_it/get_it.dart';

import '../api_model/document_signature_session.dart' as api_mod;
import '../common/model.dart';
import '../nucleus_one.dart';

class DocumentSignatureSession with NucleusOneAppDependent {
  DocumentSignatureSession._({
    NucleusOneApp? app,
    required this.id,
    required this.createdOn,
    required this.modifiedOn,
    required this.createdByUserID,
    required this.createdByUserEmail,
    required this.createdByUserName,
    required this.lastModifiedByUserID,
    required this.lastModifiedByUserEmail,
    required this.lastModifiedByUserName,
    required this.documentID,
    required this.documentRevisionID,
    required this.isActive,
    required this.isComplete,
    required this.wasStopped,
    required this.completedOn,
    required this.isRendered,
    required this.renderedOn,
    required this.formDesignType,
    required this.useAccessCode,
    required this.accessCode,
    required this.useCustomSubjectAndBody,
    required this.customSubject,
    required this.customBody,
    required this.quickDesignPlaceInitials,
    required this.quickDesignPlaceFullName,
    required this.quickDesignPlaceEmail,
    required this.quickDesignPlaceTitle,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
  }

  factory DocumentSignatureSession.fromApiModel(
    api_mod.DocumentSignatureSession apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSession._(
      app: app,
      id: apiModel.id!,
      createdOn: apiModel.createdOn!,
      modifiedOn: apiModel.modifiedOn!,
      createdByUserID: apiModel.createdByUserID!,
      createdByUserEmail: apiModel.createdByUserEmail!,
      createdByUserName: apiModel.createdByUserName!,
      lastModifiedByUserID: apiModel.lastModifiedByUserID!,
      lastModifiedByUserEmail: apiModel.lastModifiedByUserEmail!,
      lastModifiedByUserName: apiModel.lastModifiedByUserName!,
      documentID: apiModel.documentID!,
      documentRevisionID: apiModel.documentRevisionID!,
      isActive: apiModel.isActive!,
      isComplete: apiModel.isComplete!,
      wasStopped: apiModel.wasStopped!,
      completedOn: apiModel.completedOn!,
      isRendered: apiModel.isRendered!,
      renderedOn: apiModel.renderedOn!,
      formDesignType: apiModel.formDesignType!,
      useAccessCode: apiModel.useAccessCode!,
      accessCode: apiModel.accessCode!,
      useCustomSubjectAndBody: apiModel.useCustomSubjectAndBody!,
      customSubject: apiModel.customSubject!,
      customBody: apiModel.customBody!,
      quickDesignPlaceInitials: apiModel.quickDesignPlaceInitials!,
      quickDesignPlaceFullName: apiModel.quickDesignPlaceFullName!,
      quickDesignPlaceEmail: apiModel.quickDesignPlaceEmail!,
      quickDesignPlaceTitle: apiModel.quickDesignPlaceTitle!,
    );
  }

  String id;

  String createdOn;

  String modifiedOn;

  String createdByUserID;

  String createdByUserEmail;

  String createdByUserName;

  String lastModifiedByUserID;

  String lastModifiedByUserEmail;

  String lastModifiedByUserName;

  String documentID;

  String documentRevisionID;

  bool isActive;

  bool isComplete;

  bool wasStopped;

  String completedOn;

  bool isRendered;

  String renderedOn;

  String formDesignType;

  bool useAccessCode;

  String accessCode;

  bool useCustomSubjectAndBody;

  String customSubject;

  String customBody;

  bool quickDesignPlaceInitials;

  bool quickDesignPlaceFullName;

  bool quickDesignPlaceEmail;

  bool quickDesignPlaceTitle;

  api_mod.DocumentSignatureSession toApiModel() {
    return api_mod.DocumentSignatureSession()
      ..id = id
      ..createdOn = createdOn
      ..modifiedOn = modifiedOn
      ..createdByUserID = createdByUserID
      ..createdByUserEmail = createdByUserEmail
      ..createdByUserName = createdByUserName
      ..lastModifiedByUserID = lastModifiedByUserID
      ..lastModifiedByUserEmail = lastModifiedByUserEmail
      ..lastModifiedByUserName = lastModifiedByUserName
      ..documentID = documentID
      ..documentRevisionID = documentRevisionID
      ..isActive = isActive
      ..isComplete = isComplete
      ..wasStopped = wasStopped
      ..completedOn = completedOn
      ..isRendered = isRendered
      ..renderedOn = renderedOn
      ..formDesignType = formDesignType
      ..useAccessCode = useAccessCode
      ..accessCode = accessCode
      ..useCustomSubjectAndBody = useCustomSubjectAndBody
      ..customSubject = customSubject
      ..customBody = customBody
      ..quickDesignPlaceInitials = quickDesignPlaceInitials
      ..quickDesignPlaceFullName = quickDesignPlaceFullName
      ..quickDesignPlaceEmail = quickDesignPlaceEmail
      ..quickDesignPlaceTitle = quickDesignPlaceTitle;
  }
}

class DocumentSignatureSessionRecipient with NucleusOneAppDependent {
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
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
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

class DocumentSignatureSessionPackageCollection extends EntityCollection<
    DocumentSignatureSessionPackage, api_mod.DocumentSignatureSessionPackageCollection> {
  DocumentSignatureSessionPackageCollection({
    NucleusOneApp? app,
    List<DocumentSignatureSessionPackage>? items,
  }) : super(app: app, items: items);

  factory DocumentSignatureSessionPackageCollection.fromApiModel(
    api_mod.DocumentSignatureSessionPackageCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionPackageCollection(
        app: app,
        items: apiModel.items
            .map((x) => DocumentSignatureSessionPackage.fromApiModel(x, app: app))
            .toList());
  }

  @override
  api_mod.DocumentSignatureSessionPackageCollection toApiModel() {
    return api_mod.DocumentSignatureSessionPackageCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}

class DocumentSignatureSessionPackage with NucleusOneAppDependent {
  DocumentSignatureSessionPackage._({
    NucleusOneApp? app,
    required this.session,
    required this.recipients,
    required this.beginSession,
    required this.resetSession,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
  }

  factory DocumentSignatureSessionPackage.fromApiModel(
    api_mod.DocumentSignatureSessionPackage apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionPackage._(
      app: app,
      session: DocumentSignatureSession.fromApiModel(apiModel.session!, app: app),
      recipients: apiModel.recipients!
          .map((x) => DocumentSignatureSessionRecipient.fromApiModel(x, app: app))
          .toList(),
      beginSession: apiModel.beginSession!,
      resetSession: apiModel.resetSession!,
    );
  }

  DocumentSignatureSession session;

  List<DocumentSignatureSessionRecipient> recipients;

  bool beginSession;

  bool resetSession;

  api_mod.DocumentSignatureSessionPackage toApiModel() {
    return api_mod.DocumentSignatureSessionPackage()
      ..session = session.toApiModel()
      ..recipients = recipients.map((x) => x.toApiModel()).toList()
      ..beginSession = beginSession
      ..resetSession = resetSession;
  }
}
