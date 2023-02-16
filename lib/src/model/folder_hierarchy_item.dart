import '../common/get_it.dart';
import '../common/model.dart';

import '../api_model/folder_hierarchy_item.dart' as api_mod;
import '../hierarchy/nucleus_one_app_project.dart';
import '../nucleus_one.dart';

class FolderHierarchyItem extends Entity with NucleusOneAppDependent {
  FolderHierarchyItem._({
    NucleusOneApp? app,
    required this.id,
    required this.folderHierarchyID,
    required this.folderHierarchyName,
    required this.rank,
    required this.type,
    required this.fieldID,
    required this.fieldName,
    required this.fieldType,
    required this.fieldValueType,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory FolderHierarchyItem.fromApiModel(
    api_mod.FolderHierarchyItem apiModel, {
    NucleusOneApp? app,
  }) {
    return FolderHierarchyItem._(
      app: app,
      id: apiModel.id!,
      folderHierarchyID: apiModel.folderHierarchyID!,
      folderHierarchyName: apiModel.folderHierarchyName!,
      rank: apiModel.rank!,
      type: apiModel.type!,
      fieldID: apiModel.fieldID!,
      fieldName: apiModel.fieldName!,
      fieldType: apiModel.fieldType!,
      fieldValueType: apiModel.fieldValueType!,
    );
  }

  String id;

  String folderHierarchyID;

  String folderHierarchyName;

  int rank;

  String type;

  String fieldID;

  String fieldName;

  String fieldType;

  String fieldValueType;

  @override
  api_mod.FolderHierarchyItem toApiModel() {
    return api_mod.FolderHierarchyItem()
      ..id = id
      ..folderHierarchyID = folderHierarchyID
      ..folderHierarchyName = folderHierarchyName
      ..rank = rank
      ..type = type
      ..fieldID = fieldID
      ..fieldName = fieldName
      ..fieldType = fieldType
      ..fieldValueType = fieldValueType;
  }
}

class FolderHierarchyItemCollection
    extends EntityCollection<FolderHierarchyItem, api_mod.FolderHierarchyItemCollection>
    with NucleusOneAppProjectDependent {
  FolderHierarchyItemCollection({
    NucleusOneAppProject? project,
    List<FolderHierarchyItem>? items,
  }) : super(app: project?.app, items: items) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  factory FolderHierarchyItemCollection.fromApiModel(
    api_mod.FolderHierarchyItemCollection apiModel, {
    NucleusOneAppProject? project,
  }) {
    return FolderHierarchyItemCollection(
      project: project,
      items: apiModel.items
          .map((x) => FolderHierarchyItem.fromApiModel(x, app: project?.app))
          .toList(),
    );
  }

  @override
  api_mod.FolderHierarchyItemCollection toApiModel() {
    return api_mod.FolderHierarchyItemCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}
