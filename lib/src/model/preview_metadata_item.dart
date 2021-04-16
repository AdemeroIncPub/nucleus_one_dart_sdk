import 'package:get_it/get_it.dart';

import '../api_model/preview_metadata_item.dart' as api_model;
import '../nucleus_one.dart';

class PreviewMetadataItem with NucleusOneAppDependent {
  PreviewMetadataItem._(
      {NucleusOneAppInternal? app, required this.item0, required this.item1, required this.item2}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory PreviewMetadataItem.fromApiModel(api_model.PreviewMetadataItem apiModel) {
    return PreviewMetadataItem._(
        item0: apiModel.item0!, item1: apiModel.item1!, item2: apiModel.item2!);
  }

  String item0;

  String item1;

  String item2;

  api_model.PreviewMetadataItem toApiModel() {
    return api_model.PreviewMetadataItem()
      ..item0 = item0
      ..item1 = item1
      ..item2 = item2;
  }
}
