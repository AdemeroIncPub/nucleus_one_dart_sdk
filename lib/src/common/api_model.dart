import 'package:meta/meta.dart';

abstract class Entity {
  Map<String, dynamic> toJson();
}

/// Supports serialization of JSON structures that have an array at their root, which is not currently
/// implicitly supported by json_serializable.
/// https://github.com/google/json_serializable.dart/issues/648
abstract class EntityCollection<T extends Entity> {
  EntityCollection() : items = [];

  @protected
  static TCollection
      fromJson<TEntity extends Entity, TCollection extends EntityCollection<TEntity>>(
          List<dynamic> json,
          TCollection instance,
          TEntity Function(Map<String, dynamic>) entityFromJsonCallback) {
    return instance..items = json.map((m) => entityFromJsonCallback(m)).toList();
  }

  List<T> items;

  List<Map<String, dynamic>> toJson() => items.map((x) => x.toJson()).toList();
}
