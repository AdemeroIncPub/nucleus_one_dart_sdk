import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';

import '../../nucleus_one_dart_sdk.dart';
import '../api_model/folder_hierarchies.dart' as api_mod;
import '../nucleus_one.dart';

class FolderHierarchyCollection
    extends EntityCollection<FolderHierarchy, api_mod.FolderHierarchyCollection> {
  FolderHierarchyCollection({
    NucleusOneAppInternal? app,
    List<FolderHierarchy>? items,
  }) : super(app: app, items: items);

  factory FolderHierarchyCollection.fromApiModel(api_mod.FolderHierarchyCollection apiModel) {
    return FolderHierarchyCollection(
        items: apiModel.folderHierarchies?.map((x) => FolderHierarchy.fromApiModel(x)).toList());
  }

  @override
  api_mod.FolderHierarchyCollection toApiModel() {
    return api_mod.FolderHierarchyCollection()
      ..folderHierarchies = items.map((x) => x.toApiModel()).toList();
  }
}

class FolderHierarchy with NucleusOneAppDependent {
  FolderHierarchy._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.createdOn,
      required this.name,
      required this.nameLower}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory FolderHierarchy.fromApiModel(api_mod.FolderHierarchy apiModel) {
    return FolderHierarchy._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        name: apiModel.name!,
        nameLower: apiModel.nameLower!);
  }

  String id;

  String createdOn;

  String name;

  String nameLower;

  api_mod.FolderHierarchy toApiModel() {
    return api_mod.FolderHierarchy()
      ..id = id
      ..createdOn = createdOn
      ..name = name
      ..nameLower = nameLower;
  }
}

class FolderHierarchyItemCollection
    extends EntityCollection<FolderHierarchyItem, api_mod.FolderHierarchyItemCollection> {
  FolderHierarchyItemCollection({
    NucleusOneAppInternal? app,
    List<FolderHierarchyItem>? items,
  }) : super(app: app, items: items);

  factory FolderHierarchyItemCollection.fromApiModel(
      api_mod.FolderHierarchyItemCollection apiModel) {
    return FolderHierarchyItemCollection(
        items: apiModel.items.map((x) => FolderHierarchyItem.fromApiModel(x)).toList());
  }

  @override
  api_mod.FolderHierarchyItemCollection toApiModel() {
    return api_mod.FolderHierarchyItemCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}

class FolderHierarchyItem with NucleusOneAppDependent {
  FolderHierarchyItem._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.folderHierarchyID,
      required this.folderHierarchyName,
      required this.rank,
      required this.type,
      required this.fieldID,
      required this.fieldName,
      required this.fieldType,
      required this.fieldValueType}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory FolderHierarchyItem.fromApiModel(api_mod.FolderHierarchyItem apiModel) {
    return FolderHierarchyItem._(
        id: apiModel.id!,
        folderHierarchyID: apiModel.folderHierarchyID!,
        folderHierarchyName: apiModel.folderHierarchyName!,
        rank: apiModel.rank!,
        type: apiModel.type!,
        fieldID: apiModel.fieldID!,
        fieldName: apiModel.fieldName!,
        fieldType: apiModel.fieldType!,
        fieldValueType: apiModel.fieldValueType!);
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
