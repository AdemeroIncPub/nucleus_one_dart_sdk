void ensureArgumentIsNotEmpty({
  required String argumentName,
  required String argumentValue,
}) {
  if (argumentValue.isEmpty) {
    throw ArgumentError.value(argumentValue, argumentName, 'Value cannot be blank.');
  }
}
