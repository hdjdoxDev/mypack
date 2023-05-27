import '../frontend.dart';

void setupEgLocator() {
  final l = locator;
  'use $l';
  // services
  // l.registerLazySingleton(() => EgService());
  // l.registerLazySingletonAsync<IEgSqflApi>(() => EgSqflApi.init());

  // models
  // l.registerFactory<EgModel>(() => DummyEgModel());

  // subsections
  // setupEgLocator();
}
