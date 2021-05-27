import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import '../api_model/document_field.dart' as api_mod;
import '../nucleus_one.dart';
import '../common/model.dart';

class DocumentFieldCollection
    extends EntityCollection<DocumentField, api_mod.DocumentFieldCollection> {
  DocumentFieldCollection({
    NucleusOneAppInternal? app,
    List<DocumentField>? items,
  }) : super(app: app, items: items);

  factory DocumentFieldCollection.fromApiModel(api_mod.DocumentFieldCollection apiModel) {
    return DocumentFieldCollection(
        items: apiModel.documentFields?.map((x) => DocumentField.fromApiModel(x)).toList());
  }

  @override
  api_mod.DocumentFieldCollection toApiModel() {
    return api_mod.DocumentFieldCollection()
      ..documentFields = items.map((x) => x.toApiModel()).toList();
  }
}

class DocumentField with NucleusOneAppDependent {
  DocumentField._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.fieldID,
      required this.documentID,
      required this.classificationID,
      required this.value,
      required this.uniqueTextValue,
      required this.uniqueFirst1,
      required this.uniqueFirst2,
      required this.uniqueFirst3,
      required this.uniqueFloatValue,
      required this.uniqueTimeValue,
      required this.uniqueYear,
      required this.uniqueYearMonth}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentField.fromApiModel(api_mod.DocumentField apiModel) {
    return DocumentField._(
        id: apiModel.id!,
        fieldID: apiModel.fieldID!,
        documentID: apiModel.documentID!,
        classificationID: apiModel.classificationID!,
        value: apiModel.value!,
        uniqueTextValue: apiModel.uniqueTextValue!,
        uniqueFirst1: apiModel.uniqueFirst1!,
        uniqueFirst2: apiModel.uniqueFirst2!,
        uniqueFirst3: apiModel.uniqueFirst3!,
        uniqueFloatValue: apiModel.uniqueFloatValue!,
        uniqueTimeValue: apiModel.uniqueTimeValue!,
        uniqueYear: apiModel.uniqueYear!,
        uniqueYearMonth: apiModel.uniqueYearMonth!);
  }

  String id;

  String fieldID;

  String documentID;

  String classificationID;

  String value;

  String uniqueTextValue;

  String uniqueFirst1;

  String uniqueFirst2;

  String uniqueFirst3;

  double uniqueFloatValue;

  String uniqueTimeValue;

  String uniqueYear;

  String uniqueYearMonth;

  api_mod.DocumentField toApiModel() {
    return api_mod.DocumentField()
      ..id = id
      ..fieldID = fieldID
      ..documentID = documentID
      ..classificationID = classificationID
      ..value = value
      ..uniqueTextValue = uniqueTextValue
      ..uniqueFirst1 = uniqueFirst1
      ..uniqueFirst2 = uniqueFirst2
      ..uniqueFirst3 = uniqueFirst3
      ..uniqueFloatValue = uniqueFloatValue
      ..uniqueTimeValue = uniqueTimeValue
      ..uniqueYear = uniqueYear
      ..uniqueYearMonth = uniqueYearMonth;
  }
}
