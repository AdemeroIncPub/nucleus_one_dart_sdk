import 'package:get_it/get_it.dart';

import '../api_model/signature_form_template.dart' as api_mod;
import '../common/model.dart';
import '../common/string.dart';
import '../nucleus_one.dart';

class SignatureFormTemplateCollection
    extends EntityCollection<SignatureFormTemplate, api_mod.SignatureFormTemplateCollection> {
  SignatureFormTemplateCollection({NucleusOneAppInternal? app, List<SignatureFormTemplate>? items})
      : super(app: app, items: items);

  factory SignatureFormTemplateCollection.fromApiModel(
      api_mod.SignatureFormTemplateCollection apiModel) {
    return SignatureFormTemplateCollection(
      items: apiModel.items.map((x) => SignatureFormTemplate.fromApiModel(x)).toList(),
    );
  }

  @override
  api_mod.SignatureFormTemplateCollection toApiModel() {
    return api_mod.SignatureFormTemplateCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}

class SignatureFormTemplate with NucleusOneAppDependent {
  SignatureFormTemplate._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.name,
      required this.nameLower,
      required this.createdOn}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory SignatureFormTemplate.fromApiModel(api_mod.SignatureFormTemplate apiModel) {
    return SignatureFormTemplate._(
        id: apiModel.id!,
        name: apiModel.name!,
        nameLower: apiModel.nameLower!,
        createdOn: apiModel.createdOn!);
  }

  factory SignatureFormTemplate.createNew({
    String? id,
    required String name,
    String createdOn = '',
  }) {
    if (isNullOrEmpty(id)) {
      id = DateTime.now().millisecondsSinceEpoch.toString();
    }

    return SignatureFormTemplate._(
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

  api_mod.SignatureFormTemplate toApiModel() {
    return api_mod.SignatureFormTemplate()
      ..id = id
      ..name = name
      ..nameLower = nameLower
      ..createdOn = createdOn;
  }
}
