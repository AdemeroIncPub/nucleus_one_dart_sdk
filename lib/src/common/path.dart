String combine(String a, String b) {
  final aSlash = a.endsWith('/');
  final bSlash = b.startsWith('/');

  if (aSlash && bSlash) {
    return a + b.substring(1);
  }
  if (!(aSlash || bSlash)) {
    return a + '/' + b;
  }
  return a + b;
}
