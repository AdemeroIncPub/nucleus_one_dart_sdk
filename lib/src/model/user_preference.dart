import '../api_model/user_preference.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

class UserPreference extends Entity with NucleusOneAppDependent {
  UserPreference._({
    NucleusOneApp? app,
    required this.id,
    required this.userID,
    required this.userName,
    required this.userEmail,
    required this.stringValue,
    required this.boolValue,
    required this.intValue,
    required this.floatValue,
    required this.mapValue,
  }) {
    this.app = getEffectiveNucleusOneApp(app);
  }

  factory UserPreference.fromApiModel(
    api_mod.UserPreference apiModel, {
    NucleusOneApp? app,
  }) {
    return UserPreference._(
      app: app,
      id: apiModel.id!,
      userID: apiModel.userID!,
      userName: apiModel.userName!,
      userEmail: apiModel.userEmail!,
      stringValue: apiModel.stringValue!,
      boolValue: apiModel.boolValue!,
      intValue: apiModel.intValue!,
      floatValue: apiModel.floatValue!,
      mapValue: apiModel.mapValue!,
    );
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

  @override
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
