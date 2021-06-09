import 'dart:mirrors';

// This line is needed for "dart:mirrors" functionality
// ignore: unused_import
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:test/test.dart';

void main() {
  test('Verify EntityCollection-derived classes implement a "fromApiModel" factory constructor',
      () {
    String getSymbolName(Symbol? s) {
      if (s == null) {
        return '';
      }
      final r = RegExp(r'(")(.+)(")');
      return r.firstMatch(s.toString())!.group(2)!;
    }

    // Class names include here do not need to implement the factory method
    final classExceptions = ['DocumentForClientCollection'];

    bool foundEntityCollectionClasses = false;
    final mirrorSystem = currentMirrorSystem();

    for (var l in mirrorSystem.libraries.entries) {
      if (l.key.toString().startsWith('package:nucleus_one_dart_sdk/src/model/')) {
        for (var d in l.value.declarations.entries) {
          final dm = d.value;
          if ((dm is ClassMirror) &&
              (getSymbolName(dm.superclass?.simpleName) == 'EntityCollection')) {
            final className = getSymbolName(dm.simpleName);

            if (!classExceptions.contains(className)) {
              foundEntityCollectionClasses = true;
              bool foundFromApiModelMethod = false;
              final fullFactoryMethodName = className + '.fromApiModel';

              for (var m in dm.declarations.entries) {
                if ((m.value is MethodMirror) && getSymbolName(m.key) == fullFactoryMethodName) {
                  foundFromApiModelMethod = true;
                  break;
                }
              }

              expect(foundFromApiModelMethod, isTrue,
                  reason: '$className should define a "$fullFactoryMethodName" factory.');
            }
          }
        }
      }
    }

    expect(foundEntityCollectionClasses, isTrue,
        reason: 'No classes deriving from EntityCollection were found.');
  });
}
