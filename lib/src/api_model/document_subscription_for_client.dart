import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';
import 'query_result.dart';

part 'document_subscription_for_client.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class DocumentSubscriptionForClient extends Entity {
  DocumentSubscriptionForClient();

  /// A necessary factory constructor for creating a new DocumentSubscriptionForClient instance
  /// from a map. Pass the map to the generated [_$DocumentSubscriptionForClientFromJson()] constructor.
  /// The constructor is named after the source class, in this case, DocumentSubscriptionForClient.
  factory DocumentSubscriptionForClient.fromJson(Map<String, dynamic> json) =>
      _$DocumentSubscriptionForClientFromJson(json);

  // /// A necessary factory constructor for creating a new DocumentSubscriptionForClient instance
  // /// from a map. Pass the map to the generated [_$DocumentSubscriptionForClientFromJson()] constructor.
  // /// The constructor is named after the source class, in this case, DocumentSubscriptionForClient.
  // factory DocumentSubscriptionForClient.fromJson(List<Map<String, dynamic>> json) {
  //   return _$DocumentSubscriptionForClientFromJson(json)
  //     ..mapValue = JsonEncoder().convert(json['MapValue']);
  // }

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'Subscribed')
  bool? subscribed;

  @JsonKey(name: 'Notify')
  bool? notify;

  @JsonKey(name: 'CreatedOn')
  String? createdOn;

  @JsonKey(name: 'OrganizationID')
  String? organizationID;

  @JsonKey(name: 'ProjectID')
  String? projectID;

  @JsonKey(name: 'ProjectName')
  String? projectName;

  @JsonKey(name: 'ProjectAccessType')
  String? projectAccessType;

  @JsonKey(name: 'DocumentID')
  String? documentID;

  @JsonKey(name: 'DocumentCreatedOn')
  String? documentCreatedOn;

  @JsonKey(name: 'DocumentName')
  String? documentName;

  @JsonKey(name: 'DocumentPageCount')
  int? documentPageCount;

  @JsonKey(name: 'DocumentFileSize')
  int? documentFileSize;

  @JsonKey(name: 'DocumentPreviewMetadata')
  List<Map<String, String>>? documentPreviewMetadata;

  @JsonKey(name: 'DocumentIsSigned')
  bool? documentIsSigned;

  @JsonKey(name: 'DocumentThumbnailUrl')
  String? documentThumbnailUrl;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentSubscriptionForClientToJson].
  @override
  Map<String, dynamic> toJson() => _$DocumentSubscriptionForClientToJson(this);
  // coverage:ignore-end
}

// // Originally generated by nucleus_one_utilities.
// class DocumentSubscriptionForClientCollection
//     extends EntityCollection<DocumentSubscriptionForClient> {
//   DocumentSubscriptionForClientCollection() : super();

//   /// This JSON structure has an array at its root, which is not currently implicitly supported by json_serializable.
//   /// https://github.com/google/json_serializable.dart/issues/648
//   factory DocumentSubscriptionForClientCollection.fromJson(List<Map<String, dynamic>> json) {
//     return DocumentSubscriptionForClientCollection()
//       ..items = json.map((m) => DocumentSubscriptionForClient.fromJson(m)).toList();
//   }
// }

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class DocumentSubscriptionForClientCollection implements IQueryResultEntityCollection {
  DocumentSubscriptionForClientCollection();

  /// A necessary factory constructor for creating a new FieldCollection instance
  /// from a map. Pass the map to the generated [_$DocumentSubscriptionForClientCollectionFromJson()] constructor.
  /// The constructor is named after the source class, in this case, FieldCollection.
  factory DocumentSubscriptionForClientCollection.fromJson(Map<String, dynamic> json) =>
      _$DocumentSubscriptionForClientCollectionFromJson(json);

  @JsonKey(name: 'DocumentSubscriptions')
  List<DocumentSubscriptionForClient>? documentSubscriptions;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$DocumentSubscriptionForClientCollectionToJson].
  Map<String, dynamic> toJson() => _$DocumentSubscriptionForClientCollectionToJson(this);
  // coverage:ignore-end
}
