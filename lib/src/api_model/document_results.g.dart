// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentResultCollection _$DocumentResultCollectionFromJson(
    Map<String, dynamic> json) {
  return DocumentResultCollection()
    ..documents = (json['Documents'] as List<dynamic>?)
        ?.map((e) => DocumentForClient.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DocumentResultCollectionToJson(
    DocumentResultCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Documents', instance.documents);
  return val;
}
