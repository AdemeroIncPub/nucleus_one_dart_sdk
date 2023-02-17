import '../api_model/document_signature_session_form_field_package.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';
import 'document_signature_session_recipient_form_field.dart';

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
