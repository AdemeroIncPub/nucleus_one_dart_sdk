import 'package:get_it/get_it.dart';

import '../api_model/user_preferences.dart' as api_mod;
import 'selected_twain_device.dart';
import '../nucleus_one.dart';

class UserPreferences with NucleusOneAppDependent {
  UserPreferences._({
    NucleusOneApp? app,
    required this.userID,
    required this.userName,
    required this.userEmail,
    required this.activeOrganizationID,
    required this.activeOrganizationName,
    required this.activeTenantID,
    required this.activeTenantName,
    required this.viewType,
    required this.documentPropertiesOpen,
    required this.documentCommentsOpen,
    required this.singlePagePreview,
    required this.selectedTwainDevice,
    required this.disableTwainDeviceSoftware,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
  }

  factory UserPreferences.fromApiModel(
    api_mod.UserPreferences apiModel, {
    NucleusOneApp? app,
  }) {
    return UserPreferences._(
      app: app,
      userID: apiModel.userID!,
      userName: apiModel.userName!,
      userEmail: apiModel.userEmail!,
      activeOrganizationID: apiModel.activeOrganizationID!,
      activeOrganizationName: apiModel.activeOrganizationName!,
      activeTenantID: apiModel.activeTenantID!,
      activeTenantName: apiModel.activeTenantName!,
      viewType: apiModel.viewType!,
      documentPropertiesOpen: apiModel.documentPropertiesOpen!,
      documentCommentsOpen: apiModel.documentCommentsOpen!,
      singlePagePreview: apiModel.singlePagePreview!,
      selectedTwainDevice: SelectedTwainDevice.fromApiModel(apiModel.selectedTwainDevice!),
      disableTwainDeviceSoftware: apiModel.disableTwainDeviceSoftware!,
    );
  }

  String userID;

  String userName;

  String userEmail;

  String activeOrganizationID;

  String activeOrganizationName;

  String activeTenantID;

  String activeTenantName;

  String viewType;

  bool documentPropertiesOpen;

  bool documentCommentsOpen;

  bool singlePagePreview;

  SelectedTwainDevice selectedTwainDevice;

  bool disableTwainDeviceSoftware;

  api_mod.UserPreferences toApiModel() {
    return api_mod.UserPreferences()
      ..userID = userID
      ..userName = userName
      ..userEmail = userEmail
      ..activeOrganizationID = activeOrganizationID
      ..activeOrganizationName = activeOrganizationName
      ..activeTenantID = activeTenantID
      ..activeTenantName = activeTenantName
      ..viewType = viewType
      ..documentPropertiesOpen = documentPropertiesOpen
      ..documentCommentsOpen = documentCommentsOpen
      ..singlePagePreview = singlePagePreview
      ..selectedTwainDevice = selectedTwainDevice.toApiModel()
      ..disableTwainDeviceSoftware = disableTwainDeviceSoftware;
  }
}
