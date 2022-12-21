import '../api_model/document_upload.dart' as api_mod;
import '../common/get_it.dart';
import '../nucleus_one.dart';

class DocumentUpload with NucleusOneAppDependent {
  DocumentUpload._({
    NucleusOneApp? app,
    required this.signedUrl,
    required this.objectName,
    required this.uniqueId,
    required this.originalFilename,
    required this.originalFileSize,
    this.classificationID,
    this.fieldIDsAndValues,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory DocumentUpload.fromApiModel(
    api_mod.DocumentUpload apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentUpload._(
      app: app,
      signedUrl: apiModel.signedUrl!,
      objectName: apiModel.objectName!,
      uniqueId: apiModel.uniqueId!,
      originalFilename: apiModel.originalFilename!,
      originalFileSize: apiModel.originalFileSize!,
      classificationID: apiModel.classificationID,
      fieldIDsAndValues: apiModel.fieldIDsAndValues,
    );
  }

  String signedUrl;

  String objectName;

  String uniqueId;

  String originalFilename;

  int originalFileSize;

  String? classificationID;

  Map<String, List<String>>? fieldIDsAndValues;

  api_mod.DocumentUpload toApiModel() {
    return api_mod.DocumentUpload()
      ..signedUrl = signedUrl
      ..objectName = objectName
      ..uniqueId = uniqueId
      ..originalFilename = originalFilename
      ..originalFileSize = originalFileSize
      ..classificationID = classificationID
      ..fieldIDsAndValues = fieldIDsAndValues;
  }
}
