String getSymbolName(Symbol? s) {
  if (s == null) {
    return '';
  }
  final r = RegExp(r'(")(.+)(")');
  return r.firstMatch(s.toString())!.group(2)!;
}
