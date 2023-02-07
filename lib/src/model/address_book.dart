import '../api_model/address_book.dart' as api_model;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

class AddressBook extends Entity with NucleusOneAppDependent {
  AddressBook._({
    NucleusOneApp? app,
    required this.items,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory AddressBook.fromApiModel(
    api_model.AddressBook apiModel, {
    NucleusOneApp? app,
  }) {
    return AddressBook._(
      app: app,
      items: apiModel.items.map((x) => AddressBookItem.fromApiModel(x)).toList(),
    );
  }

  List<AddressBookItem> items;

  @override
  api_model.AddressBook toApiModel() {
    return api_model.AddressBook()..items = items.map((x) => x.toApiModel()).toList();
  }
}

class AddressBookItem extends Entity with NucleusOneAppDependent {
  AddressBookItem._({
    NucleusOneApp? app,
    required this.emailLower,
    required this.name,
    required this.tenantMemberID,
    required this.roleID,
    required this.fieldID,
    required this.formTemplateID,
    required this.formTemplateName,
    required this.formTemplateFieldID,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory AddressBookItem.fromApiModel(
    api_model.AddressBookItem apiModel, {
    NucleusOneApp? app,
  }) {
    return AddressBookItem._(
      app: app,
      emailLower: apiModel.emailLower!,
      name: apiModel.name!,
      tenantMemberID: apiModel.tenantMemberID!,
      roleID: apiModel.roleID!,
      fieldID: apiModel.fieldID!,
      formTemplateID: apiModel.formTemplateID!,
      formTemplateName: apiModel.formTemplateName!,
      formTemplateFieldID: apiModel.formTemplateFieldID!,
    );
  }

  String emailLower;

  String name;

  String tenantMemberID;

  String roleID;

  String fieldID;

  String formTemplateID;

  String formTemplateName;

  String formTemplateFieldID;

  @override
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
