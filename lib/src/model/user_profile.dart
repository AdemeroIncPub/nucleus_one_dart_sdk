import 'package:get_it/get_it.dart';

import '../api_model/user_profile.dart' as api_mod;
import '../nucleus_one.dart';

class UserProfile with NucleusOneAppDependent {
  UserProfile._(
      {NucleusOneAppInternal? app,
      required this.userProvider,
      required this.userEmail,
      required this.userName,
      required this.otpsmsNumber}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory UserProfile.fromApiModel(api_mod.UserProfile apiModel) {
    return UserProfile._(
        userProvider: apiModel.userProvider!,
        userEmail: apiModel.userEmail!,
        userName: apiModel.userName!,
        otpsmsNumber: apiModel.otpsmsNumber!);
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
