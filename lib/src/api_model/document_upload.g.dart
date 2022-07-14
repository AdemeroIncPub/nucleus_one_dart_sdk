// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentUpload _$DocumentUploadFromJson(Map<String, dynamic> json) =>
    DocumentUpload()
      ..signedUrl = json['SignedUrl'] as String?
      ..objectName = json['ObjectName'] as String?
      ..uniqueId = json['UniqueId'] as String?
      ..originalFilename = json['OriginalFilename'] as String?
      ..originalFileSize = json['OriginalFileSize'] as int?
      ..classificationID = json['ClassificationID'] as String?
      ..fieldIDsAndValues =
          (json['FieldIDsAndValues'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      );

Map<String, dynamic> _$DocumentUploadToJson(DocumentUpload instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SignedUrl', instance.signedUrl);
  writeNotNull('ObjectName', instance.objectName);
  writeNotNull('UniqueId', instance.uniqueId);
  writeNotNull('OriginalFilename', instance.originalFilename);
  writeNotNull('OriginalFileSize', instance.originalFileSize);
  writeNotNull('ClassificationID', instance.classificationID);
  writeNotNull('FieldIDsAndValues', instance.fieldIDsAndValues);
  return val;
}
