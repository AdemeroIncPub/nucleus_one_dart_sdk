import '../api_model/user_profile.dart' as api_mod;
import '../common/get_it.dart';
import '../nucleus_one.dart';

class UserProfile with NucleusOneAppDependent {
  UserProfile._({
    NucleusOneApp? app,
    required this.userProvider,
    required this.userEmail,
    required this.userName,
    required this.otpsmsNumber,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory UserProfile.fromApiModel(
    api_mod.UserProfile apiModel, {
    NucleusOneApp? app,
  }) {
    return UserProfile._(
      app: app,
      userProvider: apiModel.userProvider!,
      userEmail: apiModel.userEmail!,
      userName: apiModel.userName!,
      otpsmsNumber: apiModel.otpsmsNumber!,
    );
  }

  String userProvider;

  String userEmail;

  String userName;

  String otpsmsNumber;

  api_mod.UserProfile toApiModel() {
    return api_mod.UserProfile()
      ..userProvider = userProvider
      ..userEmail = userEmail
      ..userName = userName
      ..otpsmsNumber = otpsmsNumber;
  }
}
