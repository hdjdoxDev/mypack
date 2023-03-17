import 'package:mypack/frontend/locator.dart';

void setupEgLocator() {
  final l = locator;
  // services
  // l.registerLazySingleton(() => EgService());
  // l.registerLazySingletonAsync<EgSqflApi>(() => EgSqflApi.init());

  // models
  // l.registerFactory<EgModel>(() => DumbEgModel());

  // subsections
  // setupEgLocator();
}