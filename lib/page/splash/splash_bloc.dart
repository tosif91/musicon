import 'dart:io';

import 'package:musicon/bloc/connection_bloc.dart';
import 'package:musicon/bloc/local_storage_bloc.dart';
import 'package:musicon/locator.dart';
import 'package:musicon/utils/routes.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashBloc extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  LocalStorageBloc _localStorageBloc = locator<LocalStorageBloc>();
  ConnectionBloc _connectionBloc = locator<ConnectionBloc>();

  initialize() async {
    await initApp();
    _navigationService.clearStackAndShow(home);
  }

  initApp() async {
    _connectionBloc.initialize();
    bool status = await _localStorageBloc.initHive();
    if (status) {
      await _localStorageBloc.openHiveBox();
    }
  }
}
