import 'package:get_it/get_it.dart';

import '../api_model/email_login_options.dart' as api_mod;
import '../nucleus_one.dart';

class EmailLoginOptions with NucleusOneAppDependent {
  EmailLoginOptions._({
    NucleusOneApp? app,
    required this.userExists,
    required this.smsNumberLast2,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
  }

  factory EmailLoginOptions.fromApiModel(
    api_mod.EmailLoginOptions apiModel, {
    NucleusOneApp? app,
  }) {
    return EmailLoginOptions._(
      app: app,
      userExists: apiModel.userExists!,
      smsNumberLast2: apiModel.smsNumberLast2!,
    );
  }

  bool userExists;

  String smsNumberLast2;

  api_mod.EmailLoginOptions toApiModel() {
    return api_mod.EmailLoginOptions()
      ..userExists = userExists
      ..smsNumberLast2 = smsNumberLast2;
  }
}
