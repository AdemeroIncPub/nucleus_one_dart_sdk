import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import '../common/get_it.dart';
import '../common/model.dart';

import '../api_model/folder_hierarchies.dart' as api_mod;
import '../nucleus_one.dart';

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
