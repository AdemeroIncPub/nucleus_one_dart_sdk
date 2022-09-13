import '../api_model/field_list_item.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

class FieldListItemCollection
    extends EntityCollection<FieldListItem, api_mod.FieldListItemCollection> {
  FieldListItemCollection({
    NucleusOneApp? app,
    List<FieldListItem>? items,
  }) : super(app: app, items: items);

  factory FieldListItemCollection.fromApiModel(
    api_mod.FieldListItemCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return FieldListItemCollection(
        items: apiModel.items.map((x) => FieldListItem.fromApiModel(x)).toList());
  }

  @override
  api_mod.FieldListItemCollection toApiModel() {
    return api_mod.FieldListItemCollection()..items = items.map((x) => x.toApiModel()).toList();
  }
}

class FieldListItem with NucleusOneAppDependent {
  FieldListItem._({
    NucleusOneApp? app,
    required this.id,
    required this.parentValue,
    required this.value,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory FieldListItem.createNew({
    required String parentValue,
    required String value,
  }) {
    return FieldListItem._(id: '', parentValue: parentValue, value: value);
  }

  factory FieldListItem.fromApiModel(
    api_mod.FieldListItem apiModel, {
    NucleusOneApp? app,
  }) {
    return FieldListItem._(
      app: app,
      id: apiModel.id!,
      parentValue: apiModel.parentValue!,
      value: apiModel.value!,
    );
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
