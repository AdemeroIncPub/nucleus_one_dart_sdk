import '../api_model/form_template.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../hierarchy/nucleus_one_app_project.dart';
import '../nucleus_one.dart';

class FormTemplate extends Entity with NucleusOneAppDependent {
  FormTemplate._({
    NucleusOneApp? app,
    required this.id,
    required this.tenantID,
    required this.uniqueID,
    required this.createdOn,
    required this.name,
    required this.nameLower,
    required this.pageCount,
    required this.isPublic,
    required this.classificationID,
    required this.classificationName,
    required this.classificationNameLower,
    required this.aspect,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory FormTemplate.fromApiModel(
    api_mod.FormTemplate apiModel, {
    NucleusOneApp? app,
  }) {
    return FormTemplate._(
      app: app,
      id: apiModel.id!,
      tenantID: apiModel.tenantID!,
      uniqueID: apiModel.uniqueID!,
      createdOn: apiModel.createdOn!,
      name: apiModel.name!,
      nameLower: apiModel.nameLower!,
      pageCount: apiModel.pageCount!,
      isPublic: apiModel.isPublic!,
      classificationID: apiModel.classificationID!,
      classificationName: apiModel.classificationName!,
      classificationNameLower: apiModel.classificationNameLower!,
      aspect: apiModel.aspect!,
    );
  }

  String id;

  String tenantID;

  String uniqueID;

  String createdOn;

  String name;

  String nameLower;

  int pageCount;

  bool isPublic;

  String classificationID;

  String classificationName;

  String classificationNameLower;

  double aspect;

  @override
  api_mod.FormTemplate toApiModel() {
    return api_mod.FormTemplate()
      ..id = id
      ..tenantID = tenantID
      ..uniqueID = uniqueID
      ..createdOn = createdOn
      ..name = name
      ..nameLower = nameLower
      ..pageCount = pageCount
      ..isPublic = isPublic
      ..classificationID = classificationID
      ..classificationName = classificationName
      ..classificationNameLower = classificationNameLower
      ..aspect = aspect;
  }
}

class FormTemplateCollection extends EntityCollection<FormTemplate, api_mod.FormTemplateCollection>
    with NucleusOneAppProjectDependent {
  FormTemplateCollection({
    NucleusOneAppProject? project,
    List<FormTemplate>? items,
  }) : super(app: project?.app, items: items) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  factory FormTemplateCollection.fromApiModel(
    api_mod.FormTemplateCollection apiModel, {
    NucleusOneAppProject? project,
  }) {
    return FormTemplateCollection(
        project: project,
        items: apiModel.formTemplates?.map((x) => FormTemplate.fromApiModel(x)).toList());
  }

  @override
  api_mod.FormTemplateCollection toApiModel() {
    return api_mod.FormTemplateCollection()
      ..formTemplates = items.map((x) => x.toApiModel()).toList();
  }
}
