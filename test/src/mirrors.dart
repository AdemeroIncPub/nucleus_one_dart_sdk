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
