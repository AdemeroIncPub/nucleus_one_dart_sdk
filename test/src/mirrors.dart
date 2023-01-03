import 'dart:mirrors';

import 'package:collection/collection.dart';

String getSymbolName(Symbol? s) {
  if (s == null) {
    return '';
  }
  final r = RegExp(r'(")(.+)(")');
  return r.firstMatch(s.toString())!.group(2)!;
}

bool classIsSubtypeOf<TClass, TMixin>() {
  final c = reflectClass(TClass);
  final m = reflectClass(TMixin);
  return c.isSubtypeOf(m);
}

// int getClassFieldCount(Type classType) {
//   int count = 0;
//   final classMirror = reflectClass(classType);
//   for (var v in classMirror.declarations.values) {
//     if (v is VariableMirror) {
//       ++count;
//     }
//   }
//   return count;
// }

int getClassPublicFieldCount(Type classType) {
  int count = 0;
  final classMirror = reflectClass(classType);

  final iterableList = [
    classMirror.mixin.declarations.values,
  ];
  if (classMirror.superclass != null) {
    iterableList.add(classMirror.superclass!.mixin.declarations.values);
  }

  for (var iterable in iterableList) {
    for (var d in iterable) {
      if ((d is VariableMirror) && !d.isPrivate) {
        ++count;
      }
    }
  }
  return count;
}
