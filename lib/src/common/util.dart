import 'dart:async';
import 'dart:convert';

import 'get_it.dart';

import '../hierarchy/nucleus_one_app_project.dart';
import '../nucleus_one.dart';

/// Defines a [NucleusOneApp] instance in a local scope, such that it may be retrieved using the
/// following code.
///
/// ```dart
/// final app = getIt.get<NucleusOneApp>();
/// ```
Future<T> defineN1AppInScope<T>(NucleusOneApp app, T Function() action) async {
  return _defineObjectInScopeInternal<NucleusOneApp, T>(app, action);
}

/// Defines a [NucleusOneApp] instance in a local scope, such that it may be retrieved using the
/// following code.
///
/// ```dart
/// final app = getIt.get<NucleusOneApp>();
/// ```
Future<T> defineN1AppInScopeAsync<T>(NucleusOneApp app, Future<T> Function() action) async {
  return _defineObjectInScopeAsyncInternal<NucleusOneApp, T>(app, action);
}

/// Defines a [NucleusOneAppProject] instance in a local scope, such that it may be retrieved using the
/// following code.
///
/// ```dart
/// final app = getIt.get<NucleusOneAppProject>();
/// ```
Future<T> defineN1AppAndProjectInScope<T>(NucleusOneAppProject project, T Function() action) async {
  return _defineObjectInScopeAsyncInternal<NucleusOneAppProject, T>(project, () async {
    return await defineN1AppInScope(project.app, action);
  });
}

/// Defines a [TSingleton] instance in a local scope, such that it may be retrieved using the
/// following code.
///
/// ```dart
/// final app = getIt.get<TSingleton>();
/// ```
Future<TRet> _defineObjectInScopeInternal<TSingleton extends Object, TRet>(
  TSingleton value,
  TRet Function() action,
) async {
  bool scopeCreated = false;
  try {
    getIt.pushNewScope();
    scopeCreated = true;
    getIt.registerSingleton<TSingleton>(value);
    return action();
  } finally {
    if (scopeCreated) {
      await getIt.popScope();
    }
  }
}

/// Contains core logic for defining a [NucleusOneApp] instance in a local scope, such that it may
/// be retrieved using the following code.
///
/// ```dart
/// final app = getIt.get<TSingleton>();
/// ```
Future<TRet> _defineObjectInScopeAsyncInternal<TSingleton extends Object, TRet>(
  TSingleton value,
  Future<TRet> Function() action,
) async {
  bool scopeCreated = false;
  try {
    getIt.pushNewScope();
    scopeCreated = true;
    getIt.registerSingleton<TSingleton>(value);
    return await action();
  } finally {
    if (scopeCreated) {
      await getIt.popScope();
    }
  }
}

extension StreamHandling on Stream<List<int>> {
  /// Reads a stream completely to its end then returns the entire contents as a UTF-8 string.
  Future<String> readToEnd() async {
    final StreamTransformer st = utf8.decoder;
    return st.bind(this).join();
  }
}
