import 'dart:mirrors';

import 'package:test/test.dart';

import '../../../src/mirrors.dart';

void main() {
  test('Verify EntityCollection-derived classes implement a "fromApiModel" factory constructor',
      () {
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
