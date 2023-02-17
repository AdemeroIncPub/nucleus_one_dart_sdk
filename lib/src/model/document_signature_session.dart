import '../api_model/document_signature_session.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

class DocumentSignatureSession extends Entity with NucleusOneAppDependent {
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
    this.app = app ?? getIt.get<NucleusOneApp>();
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

  @override
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
