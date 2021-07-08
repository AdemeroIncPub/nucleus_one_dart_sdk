import 'package:get_it/get_it.dart';

import '../api_model/document.dart' as api_mod;
import '../nucleus_one.dart';

class Document with NucleusOneAppDependent {
  Document._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.createdOn,
      required this.createdByUserID,
      required this.createdByUserEmail,
      required this.createdByUserName,
      required this.name,
      required this.nameLower,
      required this.origin,
      required this.isActive,
      required this.isClassified,
      required this.isMarkedForPurge,
      required this.isSigned,
      required this.signatureSessionIsActive,
      required this.hasSinglePageImages,
      required this.signaturesCompletedOn,
      required this.purgeMarkedOn,
      required this.failedBuildAttempts,
      required this.lastError,
      required this.pageCount,
      required this.fileSize,
      required this.bucketName,
      required this.sourceObjectName,
      required this.thumbnailObjectName,
      required this.classificationID,
      required this.classificationName,
      required this.classificationNameLower,
      required this.previewMetadata}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory Document.fromApiModel(api_mod.Document apiModel) {
    return Document._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        createdByUserID: apiModel.createdByUserID!,
        createdByUserEmail: apiModel.createdByUserEmail!,
        createdByUserName: apiModel.createdByUserName!,
        name: apiModel.name!,
        nameLower: apiModel.nameLower!,
        origin: apiModel.origin!,
        isActive: apiModel.isActive!,
        isClassified: apiModel.isClassified!,
        isMarkedForPurge: apiModel.isMarkedForPurge!,
        isSigned: apiModel.isSigned!,
        signatureSessionIsActive: apiModel.signatureSessionIsActive!,
        hasSinglePageImages: apiModel.hasSinglePageImages!,
        signaturesCompletedOn: apiModel.signaturesCompletedOn!,
        purgeMarkedOn: apiModel.purgeMarkedOn!,
        failedBuildAttempts: apiModel.failedBuildAttempts!,
        lastError: apiModel.lastError!,
        pageCount: apiModel.pageCount!,
        fileSize: apiModel.fileSize!,
        bucketName: apiModel.bucketName!,
        sourceObjectName: apiModel.sourceObjectName!,
        thumbnailObjectName: apiModel.thumbnailObjectName!,
        classificationID: apiModel.classificationID!,
        classificationName: apiModel.classificationName!,
        classificationNameLower: apiModel.classificationNameLower!,
        previewMetadata:
            apiModel.previewMetadata?.map((x) => Map<String, String>.from(x)).toList());
  }

  String id;

  String createdOn;

  String createdByUserID;

  String createdByUserEmail;

  String createdByUserName;

  String name;

  String nameLower;

  String origin;

  bool isActive;

  bool isClassified;

  bool isMarkedForPurge;

  bool isSigned;

  bool signatureSessionIsActive;

  bool hasSinglePageImages;

  String signaturesCompletedOn;

  String purgeMarkedOn;

  bool failedBuildAttempts;

  String lastError;

  int pageCount;

  int fileSize;

  String bucketName;

  String sourceObjectName;

  String thumbnailObjectName;

  String classificationID;

  String classificationName;

  String classificationNameLower;

  List<Map<String, String>>? previewMetadata;

  api_mod.Document toApiModel() {
    return api_mod.Document()
      ..id = id
      ..createdOn = createdOn
      ..createdByUserID = createdByUserID
      ..createdByUserEmail = createdByUserEmail
      ..createdByUserName = createdByUserName
      ..name = name
      ..nameLower = nameLower
      ..origin = origin
      ..isActive = isActive
      ..isClassified = isClassified
      ..isMarkedForPurge = isMarkedForPurge
      ..isSigned = isSigned
      ..signatureSessionIsActive = signatureSessionIsActive
      ..hasSinglePageImages = hasSinglePageImages
      ..signaturesCompletedOn = signaturesCompletedOn
      ..purgeMarkedOn = purgeMarkedOn
      ..failedBuildAttempts = failedBuildAttempts
      ..lastError = lastError
      ..pageCount = pageCount
      ..fileSize = fileSize
      ..bucketName = bucketName
      ..sourceObjectName = sourceObjectName
      ..thumbnailObjectName = thumbnailObjectName
      ..classificationID = classificationID
      ..classificationName = classificationName
      ..classificationNameLower = classificationNameLower
      ..previewMetadata = previewMetadata!.map((x) => Map<String, String>.from(x)).toList();
  }
}
