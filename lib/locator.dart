import 'package:get_it/get_it.dart';

// Imports of Api
// import 'core/services/sleep_sqfl.dart';
// import 'core/services/bestof.dart';
// import 'core/services/sleepfirestore.dart';
// import 'core/services/sleep_reminder.dart';
// import 'core/services/routines.dart';
// End of Imports of Api

// Imports of Models
// import 'core/viewmodels/bestof.dart';
// import 'core/viewmodels/settings.dart';
// import 'core/viewmodels/sleep.dart';
// import 'core/viewmodels/sleep_reminder.dart';
// import 'core/viewmodels/routines.dart';
// import 'core/models/settings.dart';
// End of Imports of Models

GetIt locator = GetIt.instance;

void setupLocator() {
  // Api
  // locator.registerLazySingletonAsync<SleepSqflApi>(() => SleepSqflApi.init());
  // locator.registerLazySingleton(() => BestofApi());
  // locator.registerLazySingleton(() => SleepReminderApi());
  // locator.registerLazySingleton(() => RoutinesApi());
  // locator.registerLazySingleton(() => SettingsApi());
  // End of Api

  // Models
  // locator.registerFactory(() => BestofModel());
  // locator.registerFactory(() => SleepModel());
  // locator.registerFactory(() => SleepReminderModel());
  // locator.registerFactory(() => RoutinesModel());
  // locator.registerFactory(() => SettingsModel());
  // End of Models
}
