import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';

part 'document_signature_session_recipient_form_field.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class DocumentSignatureSessionRecipientFormField extends Entity {
  DocumentSignatureSessionRecipientFormField();

  /// A necessary factory constructor for creating a new DocumentSignatureSessionRecipientFormField instance
  /// from a map. Pass the map to the generated [_$DocumentSignatureSessionRecipientFormFieldFromJson()] constructor.
  /// The constructor is named after the source class, in this case, DocumentSignatureSessionRecipientFormField.
  factory DocumentSignatureSessionRecipientFormField.fromJson(Map<String, dynamic> json) =>
      _$DocumentSignatureSessionRecipientFormFieldFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'DocumentSignatureFormFieldID')
  String? documentSignatureFormFieldID;

  @JsonKey(name: 'DocumentSignatureSessionRecipientID')
  String? documentSignatureSessionRecipientID;

  @JsonKey(name: 'DocumentSignatureSessionRecipientRank')
  int? documentSignatureSessionRecipientRank;

  @JsonKey(name: 'IsComplete')
  bool? isComplete;

  @JsonKey(name: 'Type')
  String? type;

  @JsonKey(name: 'PageIndex')
  int? pageIndex;

  @JsonKey(name: 'X')
  double? x;

  @JsonKey(name: 'Y')
  double? y;

  @JsonKey(name: 'Value')
  String? value;

  @JsonKey(name: 'PlacementRank')
  int? placementRank;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentSignatureSessionRecipientFormFieldToJson].
  @override
  Map<String, dynamic> toJson() => _$DocumentSignatureSessionRecipientFormFieldToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
class DocumentSignatureSessionRecipientFormFieldCollection
    extends EntityCollection<DocumentSignatureSessionRecipientFormField> {
  DocumentSignatureSessionRecipientFormFieldCollection() : super();

  factory DocumentSignatureSessionRecipientFormFieldCollection.fromJson(
      List<Map<String, dynamic>> json) {
    return EntityCollection.fromJsonArray(
      json: json,
      instance: DocumentSignatureSessionRecipientFormFieldCollection(),
      entityFromJsonCallback: (x) => DocumentSignatureSessionRecipientFormField.fromJson(x),
    );
  }
}
