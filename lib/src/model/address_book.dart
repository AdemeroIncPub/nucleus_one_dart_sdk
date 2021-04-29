import 'package:get_it/get_it.dart';

import '../api_model/address_book.dart' as api_model;
import '../nucleus_one.dart';

class AddressBook with NucleusOneAppDependent {
  AddressBook._({NucleusOneAppInternal? app, required this.items}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory AddressBook.fromApiModel(api_model.AddressBook apiModel) {
    return AddressBook._(
        items: apiModel.items.map((x) => AddressBookItem.fromApiModel(x)).toList());
  }

  List<AddressBookItem> items;

  api_model.AddressBook toApiModel() {
    return api_model.AddressBook()..items = items.map((x) => x.toApiModel()).toList();
  }
}

class AddressBookItem with NucleusOneAppDependent {
  AddressBookItem._(
      {NucleusOneAppInternal? app,
      required this.emailLower,
      required this.name,
      required this.tenantMemberID,
      required this.roleID,
      required this.fieldID,
      required this.formTemplateID,
      required this.formTemplateName,
      required this.formTemplateFieldID}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory AddressBookItem.fromApiModel(api_model.AddressBookItem apiModel) {
    return AddressBookItem._(
        emailLower: apiModel.emailLower!,
        name: apiModel.name!,
        tenantMemberID: apiModel.tenantMemberID!,
        roleID: apiModel.roleID!,
        fieldID: apiModel.fieldID!,
        formTemplateID: apiModel.formTemplateID!,
        formTemplateName: apiModel.formTemplateName!,
        formTemplateFieldID: apiModel.formTemplateFieldID!);
  }

  String emailLower;

  String name;

  String tenantMemberID;

  String roleID;

  String fieldID;

  String formTemplateID;

  String formTemplateName;

  String formTemplateFieldID;

  api_model.AddressBookItem toApiModel() {
    return api_model.AddressBookItem()
      ..emailLower = emailLower
      ..name = name
      ..tenantMemberID = tenantMemberID
      ..roleID = roleID
      ..fieldID = fieldID
      ..formTemplateID = formTemplateID
      ..formTemplateName = formTemplateName
      ..formTemplateFieldID = formTemplateFieldID;
  }
}