import 'package:get_it/get_it.dart';

import 'authentication_service.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  locator.registerLazySingleton(() => AuthenticationService());
}
