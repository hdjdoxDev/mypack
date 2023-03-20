import 'package:mypack/frontend/frontend.dart';

void setupEgLocator() {
  final l = locator;
  'use $l';
  // services
  // l.registerLazySingleton(() => EgService());
  // l.registerLazySingletonAsync<EgSqflApi>(() => EgSqflApi.init());

  // models
  // l.registerFactory<EgModel>(() => DumbEgModel());

  // subsections
  // setupEgLocator();
}
