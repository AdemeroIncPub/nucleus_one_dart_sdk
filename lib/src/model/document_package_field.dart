import 'package:get_it/get_it.dart';

import '../api_model/document_package_field.dart' as api_mod;
import '../nucleus_one.dart';

class DocumentPackageField with NucleusOneAppDependent {
  DocumentPackageField._(
      {NucleusOneApp? app,
      required this.fieldID,
      required this.fieldRank,
      required this.parentFieldID,
      required this.name,
      required this.labelOrName,
      required this.type,
      required this.displaySelectionList,
      required this.allowMultipleLines,
      required this.rows,
      required this.allowMultipleValues,
      required this.allowNewSelectionListItems,
      required this.saveNewSelectionListItems,
      required this.decimalPlaces,
      required this.mask,
      required this.required,
      required this.value,
      required this.values,
      required this.useCreationDate,
      required this.textMatchType}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
  }

  factory DocumentPackageField.fromApiModel(
    api_mod.DocumentPackageField apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentPackageField._(
      app: app,
      fieldID: apiModel.fieldID!,
      fieldRank: apiModel.fieldRank!,
      parentFieldID: apiModel.parentFieldID!,
      name: apiModel.name!,
      labelOrName: apiModel.labelOrName!,
      type: apiModel.type!,
      displaySelectionList: apiModel.displaySelectionList!,
      allowMultipleLines: apiModel.allowMultipleLines!,
      rows: apiModel.rows!,
      allowMultipleValues: apiModel.allowMultipleValues!,
      allowNewSelectionListItems: apiModel.allowNewSelectionListItems!,
      saveNewSelectionListItems: apiModel.saveNewSelectionListItems!,
      decimalPlaces: apiModel.decimalPlaces!,
      mask: apiModel.mask!,
      required: apiModel.required!,
      value: apiModel.value!,
      values: apiModel.values!,
      useCreationDate: apiModel.useCreationDate!,
      textMatchType: apiModel.textMatchType!,
    );
  }

  String fieldID;

  int fieldRank;

  String parentFieldID;

  String name;

  String labelOrName;

  String type;

  bool displaySelectionList;

  bool allowMultipleLines;

  int rows;

  bool allowMultipleValues;

  bool allowNewSelectionListItems;

  bool saveNewSelectionListItems;

  int decimalPlaces;

  String mask;

  bool required;

  String value;

  String values;

  bool useCreationDate;

  String textMatchType;

  api_mod.DocumentPackageField toApiModel() {
    return api_mod.DocumentPackageField()
      ..fieldID = fieldID
      ..fieldRank = fieldRank
      ..parentFieldID = parentFieldID
      ..name = name
      ..labelOrName = labelOrName
      ..type = type
      ..displaySelectionList = displaySelectionList
      ..allowMultipleLines = allowMultipleLines
      ..rows = rows
      ..allowMultipleValues = allowMultipleValues
      ..allowNewSelectionListItems = allowNewSelectionListItems
      ..saveNewSelectionListItems = saveNewSelectionListItems
      ..decimalPlaces = decimalPlaces
      ..mask = mask
      ..required = required
      ..value = value
      ..values = values
      ..useCreationDate = useCreationDate
      ..textMatchType = textMatchType;
  }
}
