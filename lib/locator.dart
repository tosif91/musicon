import 'package:get_it/get_it.dart';
import 'package:musicon/bloc/api_bloc.dart';
import 'package:musicon/bloc/connection_bloc.dart';
import 'package:musicon/bloc/local_storage_bloc.dart';

import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

setUpLocator() {
  //stacked service..
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  //services
  locator.registerLazySingleton(() => ApiBloc());
  locator.registerLazySingleton(() => ConnectionBloc());
  locator.registerLazySingleton(() => LocalStorageBloc());
}
