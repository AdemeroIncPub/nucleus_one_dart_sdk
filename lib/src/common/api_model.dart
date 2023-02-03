import 'package:meta/meta.dart';

/// Base class for API Model classes which support paging.
abstract class IApiModelPagingCursor {
  abstract String? cursor;
  abstract int? pageSize;
}

/// Base class for API Model classes which support paging and a reverse cursor.
abstract class IApiModelPagingCursor2 extends IApiModelPagingCursor {
  abstract String? reverseCursor;
}

/// The base class for all entities.
abstract class Entity {
  /// Get this object as JSON.
  Map<String, dynamic> toJson();
}

/// Supports serialization of JSON structures that have an array at their root, which is not
/// currently implicitly supported by json_serializable.
/// https://github.com/google/json_serializable.dart/issues/648
abstract class EntityCollection<T extends Entity> {
  /// Creates an instance of the [EntityCollection<T>] class.
  EntityCollection() : items = [];

  /// Creates an instance of the [EntityCollection<T>] class from JSON.
  @protected
  static TCollection
      fromJsonArray<TEntity extends Entity, TCollection extends EntityCollection<TEntity>>({
    required List<dynamic> json,
    required TCollection instance,
    required TEntity Function(Map<String, dynamic>) entityFromJsonCallback,
  }) {
    return instance..items = json.map((m) => entityFromJsonCallback(m)).toList();
  }

  /// The items in the array.
  List<T> items;

  /// Get this object as JSON.
  List<Map<String, dynamic>> toJson() => items.map((x) => x.toJson()).toList();
}
