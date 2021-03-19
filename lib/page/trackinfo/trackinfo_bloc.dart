import 'package:dio/dio.dart';
import 'package:musicon/bloc/api_bloc.dart';
import 'package:musicon/bloc/local_storage_bloc.dart';
import 'package:musicon/locator.dart';
import 'package:musicon/models/base_response.dart';
import 'package:musicon/models/bookmark_data.dart';
import 'package:musicon/models/chart_track_response.dart';
import 'package:musicon/models/track_info_response.dart';
import 'package:musicon/models/track_lyrics_response.dart';
import 'package:musicon/utils/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TrackInfoBloc extends BaseViewModel {
  TrackList data;
  ApiBloc _apiBloc = locator<ApiBloc>();
  TrackInfoResponse trackInfo;
  TrackLyricsResponse lyricsInfo;
  bool isBookMarked = true;
  LocalStorageBloc _localStorageBloc = locator<LocalStorageBloc>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  int trackID;
  initialize(var arg) async {
    setBusy(true);
    if (arg is TrackList) {
      data = arg;
      trackID = data.track.trackId;
      isBookMarked = data.isBooked;
    } else {
      //from bookmark
      BookMarkData data = arg;
      isBookMarked = true;
      trackID = int.parse(data.trackId);
    }
    BaseResponse infoResult = await fetchTrackInfo();
    if (infoResult.data != null) {
      trackInfo = infoResult.data;
    }

    BaseResponse lyricsResult = await fetchTrackLyrics();
    if (lyricsResult.data != null) {
      lyricsInfo = lyricsResult.data;
    }
    setBusy(false);
  }

  handleBack() {
    _navigationService.back(result: isBookMarked);
  }

  saveToBookMark() async {
    // _localStorageBloc.
    if (trackInfo == null) {
      _snackbarService.showSnackbar(message: 'server side error found !');
      return;
    }
    bool status = await _localStorageBloc.saveBookMark(
        BookMarkData("${data.track.trackId}", "${data.track.trackName}"));

    if (status) {
      isBookMarked = true;
      print('data saved is ${data.track.trackId} and ${data.track.trackName}');
      notifyListeners();
      _snackbarService.showSnackbar(message: 'Track Saved');
    } else
      _snackbarService.showCustomSnackBar(message: 'Something went wrong!');
  }

  Future<BaseResponse> fetchTrackLyrics() async {
    Map<String, dynamic> params = {
      'track_id': trackID,
    };
    Response<BaseResponse> response = await _apiBloc.handleGet(
        type: FetchDataType.LYRICS, parameters: params);
    return response.data;
  }

  Future<BaseResponse> fetchTrackInfo() async {
    Map<String, dynamic> params = {
      'track_id': trackID,
      // "chart_name": filter.toShortString(),
    };
    Response<BaseResponse> response = await _apiBloc.handleGet(
        type: FetchDataType.TRACKINFO, parameters: params);
    return response.data;
  }
}
