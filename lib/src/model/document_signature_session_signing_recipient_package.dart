import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';

import '../api_model/document_signature_session_signing_recipient_package.dart' as api_mod;
import '../nucleus_one.dart';
import 'document_content_package.dart';

class DocumentSignatureSessionSigningRecipientPackage with NucleusOneAppDependent {
  DocumentSignatureSessionSigningRecipientPackage._(
      {NucleusOneAppInternal? app,
      required this.requireAccessCode,
      required this.signingRecipient,
      required this.formFieldPackage,
      required this.serverDate,
      required this.contentPackage}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentSignatureSessionSigningRecipientPackage.fromApiModel(
      api_mod.DocumentSignatureSessionSigningRecipientPackage apiModel) {
    return DocumentSignatureSessionSigningRecipientPackage._(
        requireAccessCode: apiModel.requireAccessCode!,
        signingRecipient:
            DocumentSignatureSessionSigningRecipient.fromApiModel(apiModel.signingRecipient!),
        formFieldPackage:
            DocumentSignatureSessionFormFieldPackage.fromApiModel(apiModel.formFieldPackage!),
        serverDate: apiModel.serverDate!,
        contentPackage: DocumentContentPackage.fromApiModel(apiModel.contentPackage!));
  }

  bool requireAccessCode;

  DocumentSignatureSessionSigningRecipient signingRecipient;

  DocumentSignatureSessionFormFieldPackage formFieldPackage;

  String serverDate;

  DocumentContentPackage contentPackage;

  api_mod.DocumentSignatureSessionSigningRecipientPackage toApiModel() {
    return api_mod.DocumentSignatureSessionSigningRecipientPackage()
      ..requireAccessCode = requireAccessCode
      ..signingRecipient = signingRecipient.toApiModel()
      ..formFieldPackage = formFieldPackage.toApiModel()
      ..serverDate = serverDate
      ..contentPackage = contentPackage.toApiModel();
  }
}

class DocumentSignatureSessionFormFieldPackage with NucleusOneAppDependent {
  DocumentSignatureSessionFormFieldPackage._(
      {NucleusOneAppInternal? app,
      required this.formDesignType,
      required this.quickDesignPlaceInitials,
      required this.quickDesignPlaceFullName,
      required this.quickDesignPlaceEmail,
      required this.quickDesignPlaceTitle,
      required this.formFields,
      required this.completedFormFields}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentSignatureSessionFormFieldPackage.fromApiModel(
      api_mod.DocumentSignatureSessionFormFieldPackage apiModel) {
    return DocumentSignatureSessionFormFieldPackage._(
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
            .toList());
  }

  String formDesignType;

  bool quickDesignPlaceInitials;

  bool quickDesignPlaceFullName;

  bool quickDesignPlaceEmail;

  bool quickDesignPlaceTitle;

  List<DocumentSignatureSessionRecipientFormField> formFields;

  List<DocumentSignatureSessionRecipientFormField> completedFormFields;

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
    NucleusOneAppInternal? app,
    List<DocumentSignatureSessionRecipientFormField>? items,
  }) : super(app: app, items: items);

  factory DocumentSignatureSessionRecipientFormFieldCollection.fromApiModel(
      api_mod.DocumentSignatureSessionRecipientFormFieldCollection apiModel) {
    return DocumentSignatureSessionRecipientFormFieldCollection(
        items: apiModel.items
            .map((x) => DocumentSignatureSessionRecipientFormField.fromApiModel(x))
            .toList());
  }

  @override
  api_mod.DocumentSignatureSessionRecipientFormFieldCollection toApiModel() {
    return api_mod.DocumentSignatureSessionRecipientFormFieldCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}

class DocumentSignatureSessionRecipientFormField with NucleusOneAppDependent {
  DocumentSignatureSessionRecipientFormField._(
      {NucleusOneAppInternal? app,
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
      required this.placementRank}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentSignatureSessionRecipientFormField.fromApiModel(
      api_mod.DocumentSignatureSessionRecipientFormField apiModel) {
    return DocumentSignatureSessionRecipientFormField._(
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
        placementRank: apiModel.placementRank!);
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

class DocumentSignatureSessionSigningRecipient with NucleusOneAppDependent {
  DocumentSignatureSessionSigningRecipient._(
      {NucleusOneAppInternal? app, required this.email, required this.fullName}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentSignatureSessionSigningRecipient.fromApiModel(
      api_mod.DocumentSignatureSessionSigningRecipient apiModel) {
    return DocumentSignatureSessionSigningRecipient._(
        email: apiModel.email!, fullName: apiModel.fullName!);
  }

  String email;

  String fullName;

  api_mod.DocumentSignatureSessionSigningRecipient toApiModel() {
    return api_mod.DocumentSignatureSessionSigningRecipient()
      ..email = email
      ..fullName = fullName;
  }
}
