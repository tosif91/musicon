import 'package:musicon/bloc/local_storage_bloc.dart';
import 'package:musicon/locator.dart';
import 'package:musicon/models/bookmark_data.dart';
import 'package:musicon/utils/routes.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BookMarkBloc extends BaseViewModel {
  List<BookMarkData> trackList = <BookMarkData>[];
  LocalStorageBloc _localStorageBloc = locator<LocalStorageBloc>();
  NavigationService _navigationService = locator<NavigationService>();
  int bookLength;
  initialize() {
    bookLength = _localStorageBloc.getTrackBookLength();
  }

  retrieveItem(int index) => _localStorageBloc.retrieveItem(index);

  navigateToTrackInfo(int index) {
    _navigationService.navigateTo(trackInfo,
        arguments: _localStorageBloc.retrieveItem(index));
  }
}
