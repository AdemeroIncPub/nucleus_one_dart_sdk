import 'package:get_it/get_it.dart';

import '../api_model/document_subscription.dart' as api_mod;
import '../model/preview_metadata_item.dart';
import '../nucleus_one.dart';

class DocumentSubscription with NucleusOneAppDependent {
  DocumentSubscription._(
      {NucleusOneAppInternal? app,
      required this.subscribed,
      required this.notify,
      required this.createdOn,
      required this.documentID,
      required this.documentCreatedOn,
      required this.documentName,
      required this.documentPageCount,
      required this.documentFileSize,
      required this.documentClassificationID,
      required this.documentClassificationName,
      required this.documentPreviewMetadata,
      required this.documentIsSigned}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentSubscription.fromApiModel(api_mod.DocumentSubscription apiModel) {
    return DocumentSubscription._(
        subscribed: apiModel.subscribed!,
        notify: apiModel.notify!,
        createdOn: apiModel.createdOn!,
        documentID: apiModel.documentID!,
        documentCreatedOn: apiModel.documentCreatedOn!,
        documentName: apiModel.documentName!,
        documentPageCount: apiModel.documentPageCount!,
        documentFileSize: apiModel.documentFileSize!,
        documentClassificationID: apiModel.documentClassificationID!,
        documentClassificationName: apiModel.documentClassificationName!,
        documentPreviewMetadata: apiModel.documentPreviewMetadata
            ?.map((x) => PreviewMetadataItem.fromApiModel(x))
            .toList(),
        documentIsSigned: apiModel.documentIsSigned!);
  }

  bool subscribed;

  bool notify;

  String createdOn;

  String documentID;

  String documentCreatedOn;

  String documentName;

  int documentPageCount;

  int documentFileSize;

  String documentClassificationID;

  String documentClassificationName;

  List<PreviewMetadataItem>? documentPreviewMetadata;

  bool documentIsSigned;

  api_mod.DocumentSubscription toApiModel() {
    return api_mod.DocumentSubscription()
      ..subscribed = subscribed
      ..notify = notify
      ..createdOn = createdOn
      ..documentID = documentID
      ..documentCreatedOn = documentCreatedOn
      ..documentName = documentName
      ..documentPageCount = documentPageCount
      ..documentFileSize = documentFileSize
      ..documentClassificationID = documentClassificationID
      ..documentClassificationName = documentClassificationName
      ..documentPreviewMetadata = documentPreviewMetadata!.map((x) => x.toApiModel()).toList()
      ..documentIsSigned = documentIsSigned;
  }
}
