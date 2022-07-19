import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';

/// Defines a [NucleusOneApp] instance in a local scope, such that it may be retrieved using the
/// following code.
///
/// ```dart
/// final app = GetIt.instance.get<NucleusOneApp>();
/// ```
Future<T> DefineN1AppInScope<T>(NucleusOneApp app, T Function() action) async {
  return _DefineObjectInScopeInternal<NucleusOneApp, T>(app, action);
}

/// Defines a [NucleusOneApp] instance in a local scope, such that it may be retrieved using the
/// following code.
///
/// ```dart
/// final app = GetIt.instance.get<NucleusOneApp>();
/// ```
Future<T> DefineN1AppInScopeAsync<T>(NucleusOneApp app, Future<T> Function() action) async {
  return _DefineObjectInScopeAsyncInternal<NucleusOneApp, T>(app, action);
}

/// Defines a [NucleusOneAppProject] instance in a local scope, such that it may be retrieved using the
/// following code.
///
/// ```dart
/// final app = GetIt.instance.get<NucleusOneAppProject>();
/// ```
Future<T> DefineN1AppAndProjectInScope<T>(NucleusOneAppProject project, T Function() action) async {
  return _DefineObjectInScopeAsyncInternal<NucleusOneAppProject, T>(project, () async {
    return await DefineN1AppInScope(project.app, action);
  });
}

/// Defines a [TSingleton] instance in a local scope, such that it may be retrieved using the
/// following code.
///
/// ```dart
/// final app = GetIt.instance.get<TSingleton>();
/// ```
Future<TRet> _DefineObjectInScopeInternal<TSingleton extends Object, TRet>(
  TSingleton value,
  TRet Function() action,
) async {
  final getIt = GetIt.I;
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

Future<TRet> _DefineObjectInScopeAsyncInternal<TSingleton extends Object, TRet>(
  TSingleton value,
  Future<TRet> Function() action,
) async {
  final getIt = GetIt.I;
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
