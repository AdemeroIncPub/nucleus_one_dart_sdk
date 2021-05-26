import 'package:get_it/get_it.dart';

import '../api_model/user_preference.dart' as api_mod;
import '../nucleus_one.dart';

class UserPreference with NucleusOneAppDependent {
  UserPreference._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.userID,
      required this.userName,
      required this.userEmail,
      required this.stringValue,
      required this.boolValue,
      required this.intValue,
      required this.floatValue,
      required this.mapValue}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory UserPreference.fromApiModel(api_mod.UserPreference apiModel) {
    return UserPreference._(
        id: apiModel.id!,
        userID: apiModel.userID!,
        userName: apiModel.userName!,
        userEmail: apiModel.userEmail!,
        stringValue: apiModel.stringValue!,
        boolValue: apiModel.boolValue!,
        intValue: apiModel.intValue!,
        floatValue: apiModel.floatValue!,
        mapValue: apiModel.mapValue!);
  }

  String id;

  String userID;

  String userName;

  String userEmail;

  String stringValue;

  bool boolValue;

  int intValue;

  double floatValue;

  String mapValue;

  api_mod.UserPreference toApiModel() {
    return api_mod.UserPreference()
      ..id = id
      ..userID = userID
      ..userName = userName
      ..userEmail = userEmail
      ..stringValue = stringValue
      ..boolValue = boolValue
      ..intValue = intValue
      ..floatValue = floatValue
      ..mapValue = mapValue;
  }
}
