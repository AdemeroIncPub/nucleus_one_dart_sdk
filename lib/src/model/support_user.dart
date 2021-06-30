import 'package:get_it/get_it.dart';
import '../common/model.dart';
import '../api_model/support_user.dart' as api_mod;
import '../nucleus_one.dart';

class SupportUserCollection extends EntityCollection<SupportUser, api_mod.SupportUserCollection> {
  SupportUserCollection({
    NucleusOneAppInternal? app,
    List<SupportUser>? items,
  }) : super(app: app, items: items);

  factory SupportUserCollection.fromApiModel(api_mod.SupportUserCollection apiModel) {
    return SupportUserCollection(
        items: apiModel.supportUsers?.map((x) => SupportUser.fromApiModel(x)).toList());
  }

  @override
  api_mod.SupportUserCollection toApiModel() {
    return api_mod.SupportUserCollection()
      ..supportUsers = items.map((x) => x.toApiModel()).toList();
  }
}

class SupportUser with NucleusOneAppDependent {
  SupportUser._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.createdOn,
      required this.lastSignIn,
      required this.lastActivity,
      required this.email,
      required this.provider,
      required this.name}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory SupportUser.fromApiModel(api_mod.SupportUser apiModel) {
    return SupportUser._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        lastSignIn: apiModel.lastSignIn!,
        lastActivity: apiModel.lastActivity!,
        email: apiModel.email!,
        provider: apiModel.provider!,
        name: apiModel.name!);
  }

  String id;

  String createdOn;

  String lastSignIn;

  String lastActivity;

  String email;

  String provider;

  String name;

  api_mod.SupportUser toApiModel() {
    return api_mod.SupportUser()
      ..id = id
      ..createdOn = createdOn
      ..lastSignIn = lastSignIn
      ..lastActivity = lastActivity
      ..email = email
      ..provider = provider
      ..name = name;
  }
}
