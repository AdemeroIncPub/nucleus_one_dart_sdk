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

class SignatureFormTemplateFieldCollection extends EntityCollection<SignatureFormTemplateField,
    api_mod.SignatureFormTemplateFieldCollection> {
  SignatureFormTemplateFieldCollection(
      {NucleusOneAppInternal? app, List<SignatureFormTemplateField>? items})
      : super(app: app, items: items);

  factory SignatureFormTemplateFieldCollection.fromApiModel(
      api_mod.SignatureFormTemplateFieldCollection apiModel) {
    return SignatureFormTemplateFieldCollection(
      items: apiModel.items.map((x) => SignatureFormTemplateField.fromApiModel(x)).toList(),
    );
  }

  @override
  api_mod.SignatureFormTemplateFieldCollection toApiModel() {
    return api_mod.SignatureFormTemplateFieldCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}

class SignatureFormTemplateField with NucleusOneAppDependent {
  SignatureFormTemplateField._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.createdOn,
      required this.type,
      required this.pageIndex,
      required this.documentSignatureSessionRecipientID,
      required this.x,
      required this.y,
      required this.label,
      required this.widthPercent,
      required this.sortRank}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory SignatureFormTemplateField.fromApiModel(api_mod.SignatureFormTemplateField apiModel) {
    return SignatureFormTemplateField._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        type: apiModel.type!,
        pageIndex: apiModel.pageIndex!,
        documentSignatureSessionRecipientID: apiModel.documentSignatureSessionRecipientID!,
        x: apiModel.x!,
        y: apiModel.y!,
        label: apiModel.label,
        widthPercent: apiModel.widthPercent,
        sortRank: apiModel.sortRank);
  }

  factory SignatureFormTemplateField.createNew({
    String? id,
    String createdOn = '',
    required String type,
    required int pageIndex,
    required String documentSignatureSessionRecipientID,
    required double x,
    required double y,
    String? label,
    double? widthPercent,
    int? sortRank,
  }) {
    if (isNullOrEmpty(id)) {
      id = DateTime.now().millisecondsSinceEpoch.toString();
    }

    return SignatureFormTemplateField._(
      id: id!,
      createdOn: createdOn,
      type: type,
      pageIndex: pageIndex,
      documentSignatureSessionRecipientID: documentSignatureSessionRecipientID,
      x: x,
      y: y,
      label: label,
      widthPercent: widthPercent,
      sortRank: sortRank,
    );
  }

  String id;

  String createdOn;

  String type;

  int pageIndex;

  String documentSignatureSessionRecipientID;

  double x;

  double y;

  String? label;

  double? widthPercent;

  int? sortRank;

  api_mod.SignatureFormTemplateField toApiModel() {
    return api_mod.SignatureFormTemplateField()
      ..id = id
      ..createdOn = createdOn.isEmpty ? null : createdOn
      ..type = type
      ..pageIndex = pageIndex
      ..documentSignatureSessionRecipientID = documentSignatureSessionRecipientID
      ..x = x
      ..y = y
      ..label = label
      ..widthPercent = widthPercent
      ..sortRank = sortRank;
  }
}
