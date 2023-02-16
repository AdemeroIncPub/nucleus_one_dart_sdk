import 'package:nucleus_one_dart_sdk/src/common/api_model.dart';
import 'package:test/test.dart';

void main() {
  group('EntityCollection class tests', () {
    test('fromJson method test', () {
      final c1 = _TestEntityCollection.fromJson([<String, dynamic>{}]);
      expect(c1.items.length, 1);

      final c2 = _TestEntityCollection.fromJson([<String, dynamic>{}, <String, dynamic>{}]);
      expect(c2.items.length, 2);
    });
  });
}

class _TestEntity extends Entity {
  _TestEntity();

  @override
  Map<String, dynamic> toJson() => {};
}

class _TestEntityCollection extends EntityCollection<_TestEntity> {
  _TestEntityCollection() : super();

  factory _TestEntityCollection.fromJson(List<Map<String, dynamic>> json) {
    return EntityCollection.fromJsonArray(
      json: json,
      instance: _TestEntityCollection(),
      entityFromJsonCallback: (x) => _TestEntity(),
    );
  }
}
