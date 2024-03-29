import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';
import 'query_result.dart';

part 'task_event.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class TaskEventCollection implements IQueryResultEntityCollection {
  TaskEventCollection();

  /// A necessary factory constructor for creating a new TaskEventCollection instance
  /// from a map. Pass the map to the generated [_$TaskEventCollectionFromJson()] constructor.
  /// The constructor is named after the source class, in this case, TaskEventCollection.
  factory TaskEventCollection.fromJson(Map<String, dynamic> json) =>
      _$TaskEventCollectionFromJson(json);

  @JsonKey(name: 'TaskEvents')
  List<TaskEvent>? taskEvents;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$TaskEventCollectionToJson].
  Map<String, dynamic> toJson() => _$TaskEventCollectionToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class TaskEvent extends Entity {
  TaskEvent();

  /// A necessary factory constructor for creating a new TaskEvent instance
  /// from a map. Pass the map to the generated [_$TaskEventFromJson()] constructor.
  /// The constructor is named after the source class, in this case, TaskEvent.
  factory TaskEvent.fromJson(Map<String, dynamic> json) => _$TaskEventFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'TaskID')
  String? taskID;

  @JsonKey(name: 'CreatedOn')
  String? createdOn;

  @JsonKey(name: 'CreatedByUserID')
  String? createdByUserID;

  @JsonKey(name: 'CreatedByUserName')
  String? createdByUserName;

  @JsonKey(name: 'CreatedByUserEmail')
  String? createdByUserEmail;

  @JsonKey(name: 'ModifiedOn')
  String? modifiedOn;

  @JsonKey(name: 'Type')
  String? type;

  @JsonKey(name: 'TaskRevision')
  int? taskRevision;

  @JsonKey(name: 'DetailJson')
  String? detailJson;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$TaskEventToJson].
  @override
  Map<String, dynamic> toJson() => _$TaskEventToJson(this);
  // coverage:ignore-end
}
