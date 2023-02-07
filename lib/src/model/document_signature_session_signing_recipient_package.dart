import '../api_model/document_signature_session_signing_recipient_package.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';
import 'document_content_package.dart';

class DocumentSignatureSessionSigningRecipientPackage extends Entity with NucleusOneAppDependent {
  DocumentSignatureSessionSigningRecipientPackage._({
    NucleusOneApp? app,
    required this.requireAccessCode,
    required this.signingRecipient,
    required this.formFieldPackage,
    required this.serverDate,
    required this.contentPackage,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory DocumentSignatureSessionSigningRecipientPackage.fromApiModel(
    api_mod.DocumentSignatureSessionSigningRecipientPackage apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionSigningRecipientPackage._(
      app: app,
      requireAccessCode: apiModel.requireAccessCode!,
      signingRecipient: DocumentSignatureSessionSigningRecipient.fromApiModel(
          apiModel.signingRecipient!,
          app: app),
      formFieldPackage: DocumentSignatureSessionFormFieldPackage.fromApiModel(
          apiModel.formFieldPackage!,
          app: app),
      serverDate: apiModel.serverDate!,
      contentPackage: DocumentContentPackage.fromApiModel(
        apiModel.contentPackage!,
      ),
    );
  }

  bool requireAccessCode;

  DocumentSignatureSessionSigningRecipient signingRecipient;

  DocumentSignatureSessionFormFieldPackage formFieldPackage;

  String serverDate;

  DocumentContentPackage contentPackage;

  @override
  api_mod.DocumentSignatureSessionSigningRecipientPackage toApiModel() {
    return api_mod.DocumentSignatureSessionSigningRecipientPackage()
      ..requireAccessCode = requireAccessCode
      ..signingRecipient = signingRecipient.toApiModel()
      ..formFieldPackage = formFieldPackage.toApiModel()
      ..serverDate = serverDate
      ..contentPackage = contentPackage.toApiModel();
  }
}

class DocumentSignatureSessionFormFieldPackage extends Entity with NucleusOneAppDependent {
  DocumentSignatureSessionFormFieldPackage._({
    NucleusOneApp? app,
    required this.formDesignType,
    required this.quickDesignPlaceInitials,
    required this.quickDesignPlaceFullName,
    required this.quickDesignPlaceEmail,
    required this.quickDesignPlaceTitle,
    required this.formFields,
    required this.completedFormFields,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory DocumentSignatureSessionFormFieldPackage.fromApiModel(
    api_mod.DocumentSignatureSessionFormFieldPackage apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionFormFieldPackage._(
      app: app,
      formDesignType: apiModel.formDesignType!,
      quickDesignPlaceInitials: apiModel.quickDesignPlaceInitials!,
      quickDesignPlaceFullName: apiModel.quickDesignPlaceFullName!,
      quickDesignPlaceEmail: apiModel.quickDesignPlaceEmail!,
      quickDesignPlaceTitle: apiModel.quickDesignPlaceTitle!,
      formFields: apiModel.formFields!
          .map((x) => DocumentSignatureSessionRecipientFormField.fromApiModel(x))
          .toList(),
      completedFormFields: apiModel.completedFormFields!
          .map((x) => DocumentSignatureSessionRecipientFormField.fromApiModel(x))
          .toList(),
    );
  }

  String formDesignType;

  bool quickDesignPlaceInitials;

  bool quickDesignPlaceFullName;

  bool quickDesignPlaceEmail;

  bool quickDesignPlaceTitle;

  List<DocumentSignatureSessionRecipientFormField> formFields;

  List<DocumentSignatureSessionRecipientFormField> completedFormFields;

  @override
  api_mod.DocumentSignatureSessionFormFieldPackage toApiModel() {
    return api_mod.DocumentSignatureSessionFormFieldPackage()
      ..formDesignType = formDesignType
      ..quickDesignPlaceInitials = quickDesignPlaceInitials
      ..quickDesignPlaceFullName = quickDesignPlaceFullName
      ..quickDesignPlaceEmail = quickDesignPlaceEmail
      ..quickDesignPlaceTitle = quickDesignPlaceTitle
      ..formFields = formFields.map((x) => x.toApiModel()).toList()
      ..completedFormFields = completedFormFields.map((x) => x.toApiModel()).toList();
  }
}

class DocumentSignatureSessionRecipientFormFieldCollection extends EntityCollection<
    DocumentSignatureSessionRecipientFormField,
    api_mod.DocumentSignatureSessionRecipientFormFieldCollection> {
  DocumentSignatureSessionRecipientFormFieldCollection({
    NucleusOneApp? app,
    List<DocumentSignatureSessionRecipientFormField>? items,
  }) : super(app: app, items: items);

  factory DocumentSignatureSessionRecipientFormFieldCollection.fromApiModel(
    api_mod.DocumentSignatureSessionRecipientFormFieldCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionRecipientFormFieldCollection(
        app: app,
        items: apiModel.items
            .map((x) => DocumentSignatureSessionRecipientFormField.fromApiModel(x, app: app))
            .toList());
  }

  @override
  api_mod.DocumentSignatureSessionRecipientFormFieldCollection toApiModel() {
    return api_mod.DocumentSignatureSessionRecipientFormFieldCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}

class DocumentSignatureSessionRecipientFormField extends Entity with NucleusOneAppDependent {
  DocumentSignatureSessionRecipientFormField._({
    NucleusOneApp? app,
    required this.id,
    required this.documentSignatureFormFieldID,
    required this.documentSignatureSessionRecipientID,
    required this.documentSignatureSessionRecipientRank,
    required this.isComplete,
    required this.type,
    required this.pageIndex,
    required this.x,
    required this.y,
    required this.value,
    required this.placementRank,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory DocumentSignatureSessionRecipientFormField.fromApiModel(
    api_mod.DocumentSignatureSessionRecipientFormField apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionRecipientFormField._(
      app: app,
      id: apiModel.id!,
      documentSignatureFormFieldID: apiModel.documentSignatureFormFieldID!,
      documentSignatureSessionRecipientID: apiModel.documentSignatureSessionRecipientID!,
      documentSignatureSessionRecipientRank: apiModel.documentSignatureSessionRecipientRank!,
      isComplete: apiModel.isComplete!,
      type: apiModel.type!,
      pageIndex: apiModel.pageIndex!,
      x: apiModel.x!,
      y: apiModel.y!,
      value: apiModel.value!,
      placementRank: apiModel.placementRank!,
    );
  }

  String id;

  String documentSignatureFormFieldID;

  String documentSignatureSessionRecipientID;

  int documentSignatureSessionRecipientRank;

  bool isComplete;

  String type;

  int pageIndex;

  double x;

  double y;

  String value;

  int placementRank;

  @override
  api_mod.DocumentSignatureSessionRecipientFormField toApiModel() {
    return api_mod.DocumentSignatureSessionRecipientFormField()
      ..id = id
      ..documentSignatureFormFieldID = documentSignatureFormFieldID
      ..documentSignatureSessionRecipientID = documentSignatureSessionRecipientID
      ..documentSignatureSessionRecipientRank = documentSignatureSessionRecipientRank
      ..isComplete = isComplete
      ..type = type
      ..pageIndex = pageIndex
      ..x = x
      ..y = y
      ..value = value
      ..placementRank = placementRank;
  }
}

class DocumentSignatureSessionSigningRecipient extends Entity with NucleusOneAppDependent {
  DocumentSignatureSessionSigningRecipient._({
    NucleusOneApp? app,
    required this.email,
    required this.fullName,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory DocumentSignatureSessionSigningRecipient.fromApiModel(
    api_mod.DocumentSignatureSessionSigningRecipient apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionSigningRecipient._(
      app: app,
      email: apiModel.email!,
      fullName: apiModel.fullName!,
    );
  }

  String email;

  String fullName;

  @override
  api_mod.DocumentSignatureSessionSigningRecipient toApiModel() {
    return api_mod.DocumentSignatureSessionSigningRecipient()
      ..email = email
      ..fullName = fullName;
  }
}
