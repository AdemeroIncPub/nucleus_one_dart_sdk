import 'package:get_it/get_it.dart';

import '../api_model/document_content_package.dart' as api_mod;
import '../nucleus_one.dart';

class DocumentContentPackage with NucleusOneAppDependent {
  DocumentContentPackage._(
      {NucleusOneAppInternal? app,
      required this.url,
      required this.contentType,
      required this.name,
      required this.pageIndex,
      required this.pageCount}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentContentPackage.fromApiModel(api_mod.DocumentContentPackage apiModel) {
    return DocumentContentPackage._(
        url: apiModel.url!,
        contentType: apiModel.contentType!,
        name: apiModel.name!,
        pageIndex: apiModel.pageIndex!,
        pageCount: apiModel.pageCount!);
  }

  String url;

  String contentType;

  String name;

  int pageIndex;

  int pageCount;

  api_mod.DocumentContentPackage toApiModel() {
    return api_mod.DocumentContentPackage()
      ..url = url
      ..contentType = contentType
      ..name = name
      ..pageIndex = pageIndex
      ..pageCount = pageCount;
  }
}
