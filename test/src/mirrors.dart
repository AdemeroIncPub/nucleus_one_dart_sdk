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

List<VariableMirror> getClassPublicFields(Type classType) {
  final iterableList = _iterateAllDeclarations(classType);
  final ret = <VariableMirror>[];

  for (var iterable in iterableList) {
    for (var d in iterable) {
      if ((d is VariableMirror) && !d.isPrivate) {
        ret.add(d);
      }
    }
  }
  return ret;
}

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
