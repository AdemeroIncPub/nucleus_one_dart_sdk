import '../api_model/signature_form_template.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../common/string.dart';
import '../nucleus_one.dart';

class SignatureFormTemplate extends Entity with NucleusOneAppDependent {
  SignatureFormTemplate._({
    NucleusOneApp? app,
    required this.id,
    required this.name,
    required this.nameLower,
    required this.createdOn,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory SignatureFormTemplate.fromApiModel(
    api_mod.SignatureFormTemplate apiModel, {
    NucleusOneApp? app,
  }) {
    return SignatureFormTemplate._(
      app: app,
      id: apiModel.id!,
      name: apiModel.name!,
      nameLower: apiModel.nameLower!,
      createdOn: apiModel.createdOn!,
    );
  }

  factory SignatureFormTemplate.createNew({
    String? id,
    required String name,
    String createdOn = '',
    NucleusOneApp? app,
  }) {
    if (isNullOrEmpty(id)) {
      id = DateTime.now().millisecondsSinceEpoch.toString();
    }

    return SignatureFormTemplate._(
      app: app,
      id: id!,
      name: name,
      nameLower: name.toLowerCase(),
      createdOn: createdOn,
    );
  }

  String id;

  String name;

  String nameLower;

  String createdOn;

  @override
  api_mod.SignatureFormTemplate toApiModel() {
    return api_mod.SignatureFormTemplate()
      ..id = id
      ..name = name
      ..nameLower = nameLower
      ..createdOn = createdOn;
  }
}

class SignatureFormTemplateCollection
    extends EntityCollection<SignatureFormTemplate, api_mod.SignatureFormTemplateCollection> {
  SignatureFormTemplateCollection({
    NucleusOneApp? app,
    List<SignatureFormTemplate>? items,
  }) : super(app: app, items: items);

  factory SignatureFormTemplateCollection.fromApiModel(
    api_mod.SignatureFormTemplateCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return SignatureFormTemplateCollection(
      app: app,
      items: apiModel.items.map((x) => SignatureFormTemplate.fromApiModel(x, app: app)).toList(),
    );
  }

  @override
  api_mod.SignatureFormTemplateCollection toApiModel() {
    return api_mod.SignatureFormTemplateCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}
