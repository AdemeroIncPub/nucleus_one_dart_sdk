import 'dart:convert';

import '../http.dart' as http;
import '../model/field_list_item.dart' as mod;
import '../nucleus_one.dart';
import 'get_it.dart';

abstract class IToApiModel {
  dynamic toApiModel();
}

/// The base class for all entities.
abstract class Entity implements IToApiModel {}

/// Base class for Model classes which support paging.
abstract class IModelPagingCursor {
  /// The ID of the cursor, from a previous query.  Used for paging results.
  abstract String cursor;

  /// The size of each page of results returned from a query.  Used for paging results.
  abstract int pageSize;
}

/// Base class for Model classes which support paging and a reverse cursor.
abstract class IModelPagingCursor2 extends IModelPagingCursor {
  /// The ID of the cursor used for getting results in reverse order, from a previous query.  Used
  /// for paging results.
  abstract String reverseCursor;
}

// class EntityCollectionIterator<T extends NucleusOneAppDependent> extends Iterator<T> {
//   EntityCollectionIterator(List<T> list) : _list = list;

//   final List<T> _list;

//   int _current = -1;

//   @override
//   bool moveNext() {
//     if (_current == (_list.length - 1)) {
//       return false;
//     }
//     ++_current;
//     return true;
//   }

//   @override
//   T get current => _list[_current];
// }

/// Supports serialization of JSON structures that have an array at their root, which is not
/// currently implicitly supported by json_serializable.
/// https://github.com/google/json_serializable.dart/issues/648
abstract class EntityCollection<TResult extends NucleusOneAppDependent, TApiModel>
    with NucleusOneAppDependent /*, IterableMixin<T>*/ {
  /// Creates an EntityCollection instance.
  ///
  /// [app]: The application to use when connecting to Nucleus One.
  ///
  /// [items]: The items to insert into this new collection.
  EntityCollection({
    NucleusOneApp? app,
    List<TResult>? items,
  }) : _items = List.unmodifiable(items ?? []) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  final List<TResult> _items;

  /// Gets all items in this collections.
  List<TResult> get items => _items;

  // @override
  // Iterator<T> get iterator => EntityCollectionIterator(_items);

  // T operator [](int i) => _items[i];

  /// Gets the API Model representation of this object.
  TApiModel toApiModel();
}

/// Contains logic for operating on list items used with the Nucleus One API.
abstract class ListItems {
  /// Builds query string parameters relevant to list items.
  ///
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  ///
  /// [parentValue]: The parent list item value.
  ///
  /// [valueFilter]: The list item value to filter on.
  static Map<String, dynamic> getListItemsQueryParams({
    String? cursor,
    String? parentValue,
    String? valueFilter,
  }) {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
      ],
    );
    if (parentValue != null) {
      qp['parentValue'] = parentValue;
    }
    if (valueFilter != null) {
      qp['valueFilter'] = valueFilter;
    }
    return qp;
  }

  // static Future<void> downloadListItems({
  //   required NucleusOneApp app,
  //   required String apiRelativeUrlPath,
  //   String? parentValue,
  //   String? valueFilter,
  //   required String destinationFilePath,
  //   String? cursor,
  // }) async {
  //   final qp = getListItemsQueryParams(cursor, parentValue, valueFilter);
  //   qp['getAllAsFlatFile'] = true;
  //   await http.downloadAuthenticated(apiRelativeUrlPath, destinationFilePath, app, queryParams: qp);
  // }

  /// Adds list items to a collection on the Nucleus One server.
  ///
  /// [app]: The application to use when connecting to Nucleus One.
  ///
  /// [apiRelativeUrlPath]: The relative Nucleus One API path to use when call the API.
  ///
  /// [items]: The items to add.
  ///
  /// [additionalQueryParams]: Additional query string parameters.
  static Future<void> addListItems({
    NucleusOneApp? app,
    required String apiRelativeUrlPath,
    required mod.FieldListItemCollection items,
    Map<String, dynamic>? additionalQueryParams,
  }) async {
    final qp = http.StandardQueryParams.get();
    if (additionalQueryParams != null) {
      qp.addAll(additionalQueryParams);
    }

    await http.executePostRequest(
      apiRelativeUrlPath: apiRelativeUrlPath,
      app: app,
      queryParams: qp,
      body: jsonEncode(items.toApiModel()),
    );
  }

  /// Sets or replaces list item values of a collection on the Nucleus One server.
  ///
  /// [app]: The application to use when connecting to Nucleus One.
  ///
  /// [apiRelativeUrlPath]: The relative Nucleus One API path to use when call the API.
  ///
  /// [values]: The values to set.
  ///
  /// [additionalQueryParams]: Additional query string parameters.
  static Future<void> setListItems({
    NucleusOneApp? app,
    required String apiRelativeUrlPath,
    required List<String> values,
    Map<String, dynamic>? additionalQueryParams,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['type'] = 'file';
    if (additionalQueryParams != null) {
      qp.addAll(additionalQueryParams);
    }

    await http.executePostRequest(
      apiRelativeUrlPath: apiRelativeUrlPath,
      app: app,
      queryParams: qp,
      body: '${values.join('\n')}\n',
    );
  }
}
