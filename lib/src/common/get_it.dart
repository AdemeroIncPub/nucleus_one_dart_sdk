import 'package:get_it/get_it.dart';

import '../../nucleus_one_dart_sdk.dart';

/// Private instance of GetIt so we don't interfere with clients and clients
/// don't interfere with us, should they do something like getIt.reset().
final getIt = GetIt.asNewInstance();

NucleusOneApp getEffectiveNucleusOneApp(NucleusOneApp? app) {
  assert((app != null) || getIt.isRegistered<NucleusOneApp>(),
      'A NucleusOneApp instance was not provided and NucleusOneApp has not been registered with GetIt.');
  return app ?? getIt.get<NucleusOneApp>();
}
