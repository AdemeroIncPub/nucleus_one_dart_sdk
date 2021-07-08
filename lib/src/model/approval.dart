import 'package:get_it/get_it.dart';

import '../api_model/approval.dart' as api_mod;
import '../common/model.dart';
import '../nucleus_one.dart';

class ApprovalCollection extends EntityCollection<Approval, api_mod.ApprovalCollection> {
  ApprovalCollection({
    NucleusOneAppInternal? app,
    List<Approval>? items,
  }) : super(app: app, items: items);

  factory ApprovalCollection.fromApiModel(api_mod.ApprovalCollection apiModel) {
    return ApprovalCollection(
        items: apiModel.approvals?.map((x) => Approval.fromApiModel(x)).toList());
  }

  @override
  api_mod.ApprovalCollection toApiModel() {
    return api_mod.ApprovalCollection()..approvals = items.map((x) => x.toApiModel()).toList();
  }
}

class Approval with NucleusOneAppDependent {
  Approval._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.createdOn,
      required this.roleID,
      required this.roleName,
      required this.processID,
      required this.processName,
      required this.processElementID,
      required this.processElementName,
      required this.participationType,
      required this.approvingTenantMemberIDs,
      required this.result,
      required this.itemType,
      required this.itemID,
      required this.itemCreatedOn,
      required this.itemCreatedByUserID,
      required this.itemCreatedByUserEmail,
      required this.itemCreatedByUserName,
      required this.itemCompletedOn,
      required this.itemCompletedByUserID,
      required this.itemCompletedByUserEmail,
      required this.itemCompletedByUserName,
      required this.itemName,
      required this.itemDescription,
      required this.documentName,
      required this.documentCreatedOn,
      required this.documentCreatedByUserID,
      required this.documentCreatedByUserEmail,
      required this.documentCreatedByUserName,
      required this.documentPageCount,
      required this.documentFileSize,
      required this.documentClassificationID,
      required this.documentClassificationName,
      required this.documentPreviewMetadata,
      required this.documentIsSigned,
      required this.workTaskDueOn,
      required this.thumbnailUrl}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory Approval.fromApiModel(api_mod.Approval apiModel) {
    return Approval._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        roleID: apiModel.roleID!,
        roleName: apiModel.roleName!,
        processID: apiModel.processID!,
        processName: apiModel.processName!,
        processElementID: apiModel.processElementID!,
        processElementName: apiModel.processElementName!,
        participationType: apiModel.participationType!,
        approvingTenantMemberIDs: apiModel.approvingTenantMemberIDs,
        result: apiModel.result!,
        itemType: apiModel.itemType!,
        itemID: apiModel.itemID!,
        itemCreatedOn: apiModel.itemCreatedOn!,
        itemCreatedByUserID: apiModel.itemCreatedByUserID!,
        itemCreatedByUserEmail: apiModel.itemCreatedByUserEmail!,
        itemCreatedByUserName: apiModel.itemCreatedByUserName!,
        itemCompletedOn: apiModel.itemCompletedOn!,
        itemCompletedByUserID: apiModel.itemCompletedByUserID!,
        itemCompletedByUserEmail: apiModel.itemCompletedByUserEmail!,
        itemCompletedByUserName: apiModel.itemCompletedByUserName!,
        itemName: apiModel.itemName!,
        itemDescription: apiModel.itemDescription!,
        documentName: apiModel.documentName!,
        documentCreatedOn: apiModel.documentCreatedOn!,
        documentCreatedByUserID: apiModel.documentCreatedByUserID!,
        documentCreatedByUserEmail: apiModel.documentCreatedByUserEmail!,
        documentCreatedByUserName: apiModel.documentCreatedByUserName!,
        documentPageCount: apiModel.documentPageCount!,
        documentFileSize: apiModel.documentFileSize!,
        documentClassificationID: apiModel.documentClassificationID!,
        documentClassificationName: apiModel.documentClassificationName!,
        documentPreviewMetadata:
            apiModel.documentPreviewMetadata?.map((x) => Map<String, String>.from(x)).toList(),
        documentIsSigned: apiModel.documentIsSigned!,
        workTaskDueOn: apiModel.workTaskDueOn!,
        thumbnailUrl: apiModel.thumbnailUrl!);
  }

  String id;

  String createdOn;

  String roleID;

  String roleName;

  String processID;

  String processName;

  String processElementID;

  String processElementName;

  String participationType;

  Map<String, bool>? approvingTenantMemberIDs;

  String result;

  String itemType;

  String itemID;

  String itemCreatedOn;

  String itemCreatedByUserID;

  String itemCreatedByUserEmail;

  String itemCreatedByUserName;

  String itemCompletedOn;

  String itemCompletedByUserID;

  String itemCompletedByUserEmail;

  String itemCompletedByUserName;

  String itemName;

  String itemDescription;

  String documentName;

  String documentCreatedOn;

  String documentCreatedByUserID;

  String documentCreatedByUserEmail;

  String documentCreatedByUserName;

  int documentPageCount;

  int documentFileSize;

  String documentClassificationID;

  String documentClassificationName;

  List<Map<String, String>>? documentPreviewMetadata;

  bool documentIsSigned;

  String workTaskDueOn;

  String thumbnailUrl;

  api_mod.Approval toApiModel() {
    return api_mod.Approval()
      ..id = id
      ..createdOn = createdOn
      ..roleID = roleID
      ..roleName = roleName
      ..processID = processID
      ..processName = processName
      ..processElementID = processElementID
      ..processElementName = processElementName
      ..participationType = participationType
      ..approvingTenantMemberIDs = approvingTenantMemberIDs
      ..result = result
      ..itemType = itemType
      ..itemID = itemID
      ..itemCreatedOn = itemCreatedOn
      ..itemCreatedByUserID = itemCreatedByUserID
      ..itemCreatedByUserEmail = itemCreatedByUserEmail
      ..itemCreatedByUserName = itemCreatedByUserName
      ..itemCompletedOn = itemCompletedOn
      ..itemCompletedByUserID = itemCompletedByUserID
      ..itemCompletedByUserEmail = itemCompletedByUserEmail
      ..itemCompletedByUserName = itemCompletedByUserName
      ..itemName = itemName
      ..itemDescription = itemDescription
      ..documentName = documentName
      ..documentCreatedOn = documentCreatedOn
      ..documentCreatedByUserID = documentCreatedByUserID
      ..documentCreatedByUserEmail = documentCreatedByUserEmail
      ..documentCreatedByUserName = documentCreatedByUserName
      ..documentPageCount = documentPageCount
      ..documentFileSize = documentFileSize
      ..documentClassificationID = documentClassificationID
      ..documentClassificationName = documentClassificationName
      ..documentPreviewMetadata =
          documentPreviewMetadata!.map((x) => Map<String, String>.from(x)).toList()
      ..documentIsSigned = documentIsSigned
      ..workTaskDueOn = workTaskDueOn
      ..thumbnailUrl = thumbnailUrl;
  }
}
