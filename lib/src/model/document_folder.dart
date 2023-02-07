import 'package:meta/meta.dart';

import '../api_model/document_folder.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

class DocumentFolder extends Entity with NucleusOneAppDependent {
  @visibleForTesting
  DocumentFolder({
    NucleusOneApp? app,
    required this.id,
    required this.uniqueID,
    required this.parentID,
    required this.ancestorIDs,
    required this.organizationID,
    required this.projectID,
    required this.projectName,
    required this.projectAccessType,
    required this.createdOn,
    required this.createdByUserEmail,
    required this.createdByUserName,
    required this.createdByUserID,
    required this.modifiedOn,
    required this.modifiedByUserEmail,
    required this.modifiedByUserName,
    required this.modifiedByUserID,
    required this.name,
    required this.nameLower,
    required this.depth,
    required this.ancestorAssignmentUserEmails,
    required this.assignmentUserEmails,
    required this.hexColor,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory DocumentFolder.fromApiModel(
    api_mod.DocumentFolder apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentFolder(
      app: app,
      id: apiModel.id!,
      uniqueID: apiModel.uniqueID!,
      parentID: apiModel.parentID!,
      ancestorIDs: apiModel.ancestorIDs ?? [],
      organizationID: apiModel.organizationID!,
      projectID: apiModel.projectID!,
      projectName: apiModel.projectName!,
      projectAccessType: apiModel.projectAccessType!,
      createdOn: apiModel.createdOn!,
      createdByUserEmail: apiModel.createdByUserEmail!,
      createdByUserName: apiModel.createdByUserName!,
      createdByUserID: apiModel.createdByUserID!,
      modifiedOn: apiModel.modifiedOn!,
      modifiedByUserEmail: apiModel.modifiedByUserEmail!,
      modifiedByUserName: apiModel.modifiedByUserName!,
      modifiedByUserID: apiModel.modifiedByUserID!,
      name: apiModel.name!,
      nameLower: apiModel.nameLower!,
      depth: apiModel.depth!,
      ancestorAssignmentUserEmails: apiModel.ancestorAssignmentUserEmails ?? [],
      assignmentUserEmails: apiModel.assignmentUserEmails ?? [],
      hexColor: apiModel.hexColor!,
    );
  }

  String id;

  String uniqueID;

  String parentID;

  List<String> ancestorIDs;

  String organizationID;

  String projectID;

  String projectName;

  String projectAccessType;

  String createdOn;

  String createdByUserEmail;

  String createdByUserName;

  String createdByUserID;

  String modifiedOn;

  String modifiedByUserEmail;

  String modifiedByUserName;

  String modifiedByUserID;

  String name;

  String nameLower;

  int depth;

  List<String> ancestorAssignmentUserEmails;

  List<String> assignmentUserEmails;

  String hexColor;

  @override
  api_mod.DocumentFolder toApiModel() {
    return api_mod.DocumentFolder()
      ..id = id
      ..uniqueID = uniqueID
      ..parentID = parentID
      ..ancestorIDs = ancestorIDs
      ..organizationID = organizationID
      ..projectID = projectID
      ..projectName = projectName
      ..projectAccessType = projectAccessType
      ..createdOn = createdOn
      ..createdByUserEmail = createdByUserEmail
      ..createdByUserName = createdByUserName
      ..createdByUserID = createdByUserID
      ..modifiedOn = modifiedOn
      ..modifiedByUserEmail = modifiedByUserEmail
      ..modifiedByUserName = modifiedByUserName
      ..modifiedByUserID = modifiedByUserID
      ..name = name
      ..nameLower = nameLower
      ..depth = depth
      ..ancestorAssignmentUserEmails = ancestorAssignmentUserEmails
      ..assignmentUserEmails = assignmentUserEmails
      ..hexColor = hexColor;
  }
}

class DocumentFolderCollection
    extends EntityCollection<DocumentFolder, api_mod.DocumentFolderCollection> {
  DocumentFolderCollection({
    NucleusOneApp? app,
    List<DocumentFolder>? items,
  }) : super(app: app, items: items);

  factory DocumentFolderCollection.fromApiModel(
    api_mod.DocumentFolderCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentFolderCollection(
        items: apiModel.documentFolders?.map((x) => DocumentFolder.fromApiModel(x)).toList());
  }

  @override
  api_mod.DocumentFolderCollection toApiModel() {
    return api_mod.DocumentFolderCollection()
      ..documentFolders = items.map((x) => x.toApiModel()).toList();
  }
}
