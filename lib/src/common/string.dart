bool isNotEmpty(String? value) {
  return (value != null) && value.isNotEmpty;
}

bool isNullOrEmpty(String? value) {
  return (value == null) || value.isEmpty;
}
