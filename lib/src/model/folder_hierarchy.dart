import '../common/get_it.dart';
import '../common/model.dart';

import '../api_model/folder_hierarchy.dart' as api_mod;
import '../hierarchy/nucleus_one_app_project.dart';
import '../nucleus_one.dart';

class FolderHierarchy extends Entity with NucleusOneAppDependent {
  FolderHierarchy._({
    NucleusOneApp? app,
    required this.id,
    required this.createdOn,
    required this.name,
    required this.nameLower,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory FolderHierarchy.fromApiModel(
    api_mod.FolderHierarchy apiModel, {
    NucleusOneApp? app,
  }) {
    return FolderHierarchy._(
      app: app,
      id: apiModel.id!,
      createdOn: apiModel.createdOn!,
      name: apiModel.name!,
      nameLower: apiModel.nameLower!,
    );
  }

  String id;

  String createdOn;

  String name;

  String nameLower;

  @override
  api_mod.FolderHierarchy toApiModel() {
    return api_mod.FolderHierarchy()
      ..id = id
      ..createdOn = createdOn
      ..name = name
      ..nameLower = nameLower;
  }
}

class FolderHierarchyCollection
    extends EntityCollection<FolderHierarchy, api_mod.FolderHierarchyCollection>
    with NucleusOneAppProjectDependent {
  FolderHierarchyCollection({
    NucleusOneAppProject? project,
    List<FolderHierarchy>? items,
  }) : super(app: project?.app, items: items) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  factory FolderHierarchyCollection.fromApiModel(
    api_mod.FolderHierarchyCollection apiModel, {
    NucleusOneAppProject? project,
  }) {
    return FolderHierarchyCollection(
      project: project,
      items: apiModel.folderHierarchies
          ?.map((x) => FolderHierarchy.fromApiModel(x, app: project?.app))
          .toList(),
    );
  }

  @override
  api_mod.FolderHierarchyCollection toApiModel() {
    return api_mod.FolderHierarchyCollection()
      ..folderHierarchies = items.map((x) => x.toApiModel()).toList();
  }
}
