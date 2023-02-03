import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';
import 'query_result.dart';

part 'support_error_event.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class SupportErrorEventCollection implements IQueryResultEntityCollection {
  SupportErrorEventCollection();

  /// A necessary factory constructor for creating a new FieldCollection instance
  /// from a map. Pass the map to the generated [_$SupportErrorEventCollectionFromJson()] constructor.
  /// The constructor is named after the source class, in this case, FieldCollection.
  factory SupportErrorEventCollection.fromJson(Map<String, dynamic> json) =>
      _$SupportErrorEventCollectionFromJson(json);

  @JsonKey(name: 'ErrorEvents')
  List<SupportErrorEvent>? supportErrorEvents;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$SupportErrorEventCollectionToJson].
  Map<String, dynamic> toJson() => _$SupportErrorEventCollectionToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class SupportErrorEvent extends Entity {
  SupportErrorEvent();

  /// A necessary factory constructor for creating a new SupportErrorEvent instance
  /// from a map. Pass the map to the generated [_$SupportErrorEventFromJson()] constructor.
  /// The constructor is named after the source class, in this case, SupportErrorEvent.
  factory SupportErrorEvent.fromJson(Map<String, dynamic> json) =>
      _$SupportErrorEventFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'CreatedOn')
  String? createdOn;

  @JsonKey(name: 'TenantID')
  String? tenantID;

  @JsonKey(name: 'TenantName')
  String? tenantName;

  @JsonKey(name: 'TenantNameLower')
  String? tenantNameLower;

  @JsonKey(name: 'UserEmailLower')
  String? userEmailLower;

  @JsonKey(name: 'UserID')
  String? userID;

  @JsonKey(name: 'ServiceNameLower')
  String? serviceNameLower;

  @JsonKey(name: 'Level')
  String? level;

  @JsonKey(name: 'UniqueID')
  String? uniqueID;

  @JsonKey(name: 'RequestURI')
  String? requestURI;

  @JsonKey(name: 'Header')
  String? header;

  @JsonKey(name: 'Message')
  String? message;

  @JsonKey(name: 'ClientMessage')
  String? clientMessage;

  @JsonKey(name: 'HttpStatus')
  int? httpStatus;

  @JsonKey(name: 'OtherValues')
  List<String>? otherValues;

  @JsonKey(name: 'WordsLower')
  List<String>? wordsLower;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$SupportErrorEventToJson].
  @override
  Map<String, dynamic> toJson() => _$SupportErrorEventToJson(this);
  // coverage:ignore-end
}
