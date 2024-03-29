import '../api_model/organization_member.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

// Originally generated by nucleus_one_utilities.
class OrganizationMember extends Entity with NucleusOneAppDependent {
  OrganizationMember._({
    NucleusOneApp? app,
    required this.id,
    required this.createdOn,
    required this.organizationID,
    required this.organizationName,
    required this.userID,
    required this.userName,
    required this.userNameLower,
    required this.userEmail,
    required this.disabled,
    required this.isReadOnly,
    required this.isAdmin,
  }) {
    this.app = getEffectiveNucleusOneApp(app);
  }

  factory OrganizationMember.fromApiModel(
    api_mod.OrganizationMember apiModel, {
    NucleusOneApp? app,
  }) {
    return OrganizationMember._(
      app: app,
      id: apiModel.id!,
      createdOn: apiModel.createdOn!,
      organizationID: apiModel.organizationID!,
      organizationName: apiModel.organizationName!,
      userID: apiModel.userID!,
      userName: apiModel.userName!,
      userNameLower: apiModel.userNameLower!,
      userEmail: apiModel.userEmail!,
      disabled: apiModel.disabled!,
      isReadOnly: apiModel.isReadOnly!,
      isAdmin: apiModel.isAdmin!,
    );
  }

  String id;

  String createdOn;

  String organizationID;

  String organizationName;

  String userID;

  String userName;

  String userNameLower;

  String userEmail;

  bool disabled;

  bool isReadOnly;

  bool isAdmin;
  @override
  api_mod.OrganizationMember toApiModel() {
    return api_mod.OrganizationMember()
      ..id = id
      ..createdOn = createdOn
      ..organizationID = organizationID
      ..organizationName = organizationName
      ..userID = userID
      ..userName = userName
      ..userNameLower = userNameLower
      ..userEmail = userEmail
      ..disabled = disabled
      ..isReadOnly = isReadOnly
      ..isAdmin = isAdmin;
  }
}
