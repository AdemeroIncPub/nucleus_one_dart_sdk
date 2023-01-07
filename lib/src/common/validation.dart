/// Verifies that an argument's value is not an empty/blank.  If it is, an [ArgumentError] is
/// thrown.
///
/// [argumentName]: The name of the argument.  Used when throwing an exception.
///
/// [argumentValue]: The argument's value.
void ensureArgumentIsNotEmpty({
  required String argumentName,
  required String argumentValue,
}) {
  if (argumentValue.isEmpty) {
    throw ArgumentError.value(argumentValue, argumentName, 'Value cannot be blank.');
  }
}
