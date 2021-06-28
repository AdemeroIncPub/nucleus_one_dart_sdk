import 'dart:mirrors';

import 'package:test/test.dart';

import '../../../src/mirrors.dart';

void main() {
  test(
      'Verify all classes under api_model either derive from the Entity or EntityCollection classes or implement the IQueryResultEntityCollection interface',
      () {
    // Class names include here do not need to implement the factory method
    final classExceptions = ['QueryResult', 'QueryResult2', 'IQueryResultEntityCollection'];

    bool foundEntityClasses = false;
    final mirrorSystem = currentMirrorSystem();

    for (var l in mirrorSystem.libraries.entries) {
      if (l.key.toString().contains('/api_model/')) {
        for (var d in l.value.declarations.entries) {
          final dm = d.value;

          if (dm is ClassMirror) {
            final className = getSymbolName(dm.simpleName);
            final superName = getSymbolName(dm.superclass?.simpleName);

            if (!classExceptions.contains(className)) {
              // AddressBook is added as an exception to the naming convention here because that name
              // is more sensical than "AddressBookItemCollection"
              if (className.endsWith('Collection') || (className == 'AddressBook')) {
                foundEntityClasses = true;
                final implementsNames = dm.superinterfaces.map((x) => getSymbolName(x.simpleName));

                if (superName == 'EntityCollection') {
                  //
                } else if (implementsNames.contains('IQueryResultEntityCollection')) {
                  //
                } else {
                  fail(
                      '$className should either derive from EntityCollection or implement IQueryResultEntityCollection, depending on its intended use.');
                }
              } else if (superName != 'Entity') {
                fail('$className should derive from Entity.');
              }
            }
          }
        }
      }
    }

    expect(foundEntityClasses, isTrue,
        reason: 'No Entity, EntityCollection or IQueryResultEntityCollection classes were found.');
  });
}
