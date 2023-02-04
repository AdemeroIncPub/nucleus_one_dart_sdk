import 'dart:mirrors';

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
  final iterableList = _iterateAllDeclarations(classType);

  for (var iterable in iterableList) {
    for (var d in iterable) {
      if ((d is VariableMirror) && !d.isPrivate) {
        ++count;
      }
    }
  }
  return count;
}

List<Iterable<DeclarationMirror>> _iterateAllDeclarations(Type classType) {
  ClassMirror? classMirror = reflectClass(classType);

  final iterableList = [
    classMirror.mixin.declarations.values,
  ];
  while (classMirror!.superclass != null) {
    iterableList.add(classMirror.superclass!.mixin.declarations.values);
    classMirror = classMirror.superclass;
  }
  return iterableList;
}
