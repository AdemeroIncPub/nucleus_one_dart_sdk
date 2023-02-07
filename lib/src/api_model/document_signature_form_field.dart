import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';

part 'document_signature_form_field.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class DocumentSignatureFormField extends Entity {
  DocumentSignatureFormField();

  /// A necessary factory constructor for creating a new DocumentSignatureFormField instance
  /// from a map. Pass the map to the generated [_$DocumentSignatureFormFieldFromJson()] constructor.
  /// The constructor is named after the source class, in this case, DocumentSignatureFormField.
  factory DocumentSignatureFormField.fromJson(Map<String, dynamic> json) =>
      _$DocumentSignatureFormFieldFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'CreatedOn')
  String? createdOn;

  @JsonKey(name: 'Type')
  String? type;

  @JsonKey(name: 'PageIndex')
  int? pageIndex;

  @JsonKey(name: 'DocumentSignatureSessionRecipientID')
  String? documentSignatureSessionRecipientID;

  @JsonKey(name: 'X')
  double? x;

  @JsonKey(name: 'Y')
  double? y;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentSignatureFormFieldToJson].
  @override
  Map<String, dynamic> toJson() => _$DocumentSignatureFormFieldToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
class DocumentSignatureFormFieldCollection extends EntityCollection<DocumentSignatureFormField> {
  DocumentSignatureFormFieldCollection() : super();

  factory DocumentSignatureFormFieldCollection.fromJson(List<Map<String, dynamic>> json) {
    return EntityCollection.fromJsonArray(
      json: json,
      instance: DocumentSignatureFormFieldCollection(),
      entityFromJsonCallback: (x) => DocumentSignatureFormField.fromJson(x),
    );
  }
}
