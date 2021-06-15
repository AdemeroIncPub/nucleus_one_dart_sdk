import 'package:json_annotation/json_annotation.dart';

part 'document_field.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class DocumentFieldCollection {
  DocumentFieldCollection();

  /// A necessary factory constructor for creating a new DocumentFieldCollection instance
  /// from a map. Pass the map to the generated [_$DocumentFieldCollectionFromJson()] constructor.
  /// The constructor is named after the source class, in this case, DocumentFieldCollection.
  factory DocumentFieldCollection.fromJson(Map<String, dynamic> json) =>
      _$DocumentFieldCollectionFromJson(json);

  @JsonKey(name: 'DocumentFields')
  List<DocumentField>? documentFields;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentFieldCollectionToJson].
  Map<String, dynamic> toJson() => _$DocumentFieldCollectionToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class DocumentField {
  DocumentField();

  /// A necessary factory constructor for creating a new DocumentField instance
  /// from a map. Pass the map to the generated [_$DocumentFieldFromJson()] constructor.
  /// The constructor is named after the source class, in this case, DocumentField.
  factory DocumentField.fromJson(Map<String, dynamic> json) => _$DocumentFieldFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'FieldID')
  String? fieldID;

  @JsonKey(name: 'DocumentID')
  String? documentID;

  @JsonKey(name: 'ClassificationID')
  String? classificationID;

  @JsonKey(name: 'Value')
  String? value;

  @JsonKey(name: 'UniqueTextValue')
  String? uniqueTextValue;

  @JsonKey(name: 'UniqueFirst1')
  String? uniqueFirst1;

  @JsonKey(name: 'UniqueFirst2')
  String? uniqueFirst2;

  @JsonKey(name: 'UniqueFirst3')
  String? uniqueFirst3;

  @JsonKey(name: 'UniqueFloatValue')
  double? uniqueFloatValue;

  @JsonKey(name: 'UniqueTimeValue')
  String? uniqueTimeValue;

  @JsonKey(name: 'UniqueYear')
  String? uniqueYear;

  @JsonKey(name: 'UniqueYearMonth')
  String? uniqueYearMonth;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentFieldToJson].
  Map<String, dynamic> toJson() => _$DocumentFieldToJson(this);
  // coverage:ignore-end
}