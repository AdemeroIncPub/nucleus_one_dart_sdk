import 'package:get_it/get_it.dart';

/// Private instance of GetIt so we don't interfere with clients and clients
///  don't interfere with us - should they do something like getIt.reset().
final getIt = GetIt.asNewInstance();
