import 'package:get_it/get_it.dart';

import '../api_model/field_list_item.dart' as api_mod;
import '../common/model.dart';
import '../nucleus_one.dart';

class FieldListItemCollection
    extends EntityCollection<FieldListItem, api_mod.FieldListItemCollection> {
  FieldListItemCollection({
    NucleusOneAppInternal? app,
    List<FieldListItem>? items,
  }) : super(app: app, items: items);

  factory FieldListItemCollection.fromApiModel(api_mod.FieldListItemCollection apiModel) {
    return FieldListItemCollection(
        items: apiModel.items.map((x) => FieldListItem.fromApiModel(x)).toList());
  }

  @override
  api_mod.FieldListItemCollection toApiModel() {
    return api_mod.FieldListItemCollection()..items = items.map((x) => x.toApiModel()).toList();
  }
}

class FieldListItem with NucleusOneAppDependent {
  FieldListItem._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.parentValue,
      required this.value}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory FieldListItem.createNew({required String parentValue, required String value}) {
    return FieldListItem._(id: '', parentValue: parentValue, value: value);
  }

  factory FieldListItem.fromApiModel(api_mod.FieldListItem apiModel) {
    return FieldListItem._(
        id: apiModel.id!, parentValue: apiModel.parentValue!, value: apiModel.value!);
  }

  String id;

  String parentValue;

  String value;

  api_mod.FieldListItem toApiModel() {
    return api_mod.FieldListItem()
      ..id = id
      ..parentValue = parentValue
      ..value = value;
  }
}
