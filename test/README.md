# Tests
- [Tests](#tests)
  - [Executing](#executing)
  - [Structure](#structure)
    - [Unit Tests](#unit-tests)
    - [Integration Tests](#integration-tests)

## Executing

To execute all tests, run
```
dart test
```
Results will be printed to the console.

To execute all tests with coverage, run

```
dart test --coverage=coverage
dart run coverage:format_coverage --in=coverage/test --out=coverage/lcov.info --lcov --packages=.dart_tool/package_config.json --report-on=lib --check-ignore
dart run remove_from_coverage -f coverage/lcov.info -r \.g\.dart$
```
Results will be printed to the console.  The coverage report will be output to `coverage/lcov.info`.  This can be viewed with any standard LCOV viewer.  We recommend either of the following
- [Atom](https://atom.io/), using the `lcov-info` package
- [VS Code](https://code.visualstudio.com/), using the [Cover Gutters](https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters) extension

If using VS Code, you can alternatively run either the `Dart: Run All Tests` or `Dart: Run All Tests w/ Coverage` launch configuration.

## Structure

The entry point for tests is `test/index.dart` (as controlled by `dart_test.yaml`).  As tests are added, they will need to be manually included in the call hierarchy.  Each test file contains a `main` method, which executes its respective tests.  This approach removes the need for the superfluous "test" prefix/suffix on each test file and reduces total path length for Windows systems.

### Unit Tests

The hierarchy of unit test files will mimic that of the files under test.  For example, if `lib` directory is structured like this:
```
lib\
  cats\
    cat_stuff.dart
  dogs\
    dog_stuff.dart
  emus\
    emu_stuff.dart
  util.dart
```
then the `test\unit` directory is structured the same:
```
test\unit\
  cats\
    cat_stuff.dart
  dogs\
    dog_stuff.dart
  emus\
    emu_stuff.dart
  util.dart
```

### Integration Tests

Since the approach used for unit tests will not work here, the hierarchy of integration test files will be conceptual, based on the concept under test.  For example, assuming the same `lib` file structure above, the `test\integration` directory could be structured like this:
```
test\integration\
  birds\
    capabilities.dart
  mammals\
    capabilities.dart
```
There is obviously more than one conceivable structure that could be used, so just be thoughtful about the resulting structure.
