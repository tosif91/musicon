import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:musicon/bloc/api_bloc.dart';
import 'package:musicon/bloc/connection_bloc.dart';
import 'package:musicon/locator.dart';
import 'package:musicon/models/base_response.dart';
import 'package:musicon/models/chart_track_response.dart';
import 'package:musicon/utils/constants.dart';
import 'package:musicon/utils/routes.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum ChartName { top, hot, mxmweekly, mxmweekly_new }

extension ParseToString on ChartName {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class HomeBloc extends BaseViewModel {
  ScrollController listController = ScrollController();
  NavigationService _navigationService = locator<NavigationService>();
  int page = 0;
  int pageSize = 10;
  ApiBloc _apiBloc = locator<ApiBloc>();
  ChartTrackResponse trackData;
  List<TrackList> trackList = [];
  bool isFetching = false;
  ChartName filter = ChartName.top;
  bool _isConnected = true;
  StreamSubscription _connectionSubscription;
  get isConnected => _isConnected;
  int _radioGroupValue = 0;
  ConnectionBloc _connectionBloc = locator<ConnectionBloc>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  setFetching(bool value) {
    isFetching = value;
    notifyListeners();
  }

  listenConnection() {
    _isConnected = _connectionBloc.hasConnection;
    notifyListeners();
    _connectionSubscription = _connectionBloc.connectionChange.listen((event) {
      _isConnected = event;
      notifyListeners();
    });
  }

  navigateToBookMark() async {
    bool status = await _navigationService.navigateTo(bookmark);
    // if(status)
  }

  navigateToLyrics(TrackList data) async {
    bool status =
        await _navigationService.navigateTo(trackInfo, arguments: data);
    if (status) {
      int index = trackList.indexOf(data);
      trackList[index].isBooked = true;
    }
  }

  initialize() async {
    listenConnection();
    scrollListener();
    if (_isConnected) {
      setBusy(true);
      BaseResponse result = await fetchTracks();

      if (result.data != null) {
        print('got result is ${result.data}');
        trackData = result.data;
        trackList = trackData.message.body.trackList;
      } else {
        page = 0;
      }
      setBusy(false);
    }
  }

  retryingFetchList() async {
    if (_isConnected) {
      page = 0;
      setBusy(true);
      BaseResponse result = await fetchTracks();

      if (result.data != null) {
        print('got result is ${result.data}');
        trackData = result.data;
        trackList = trackData.message.body.trackList;
      } else
        page = 0;
      setBusy(false);
    } else
      _snackbarService.showSnackbar(message: 'check you network connection!');
  }

  updateFilterRadioButton(int value, ChartName type) {
    _radioGroupValue = value;
    filter = type;
    // notifyListeners();
    // setBusy(true);
    // BaseResponse result = await fetchTracks();
    // if (result.data != null) {
    //   trackData = result.data;
    //   trackList.clear();
    //   trackList = trackData.message.body.trackList;
    // }
    // setBusy(false);
  }

  showFilterChart(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(6.0),
        )),
        builder: (context) => StatefulBuilder(
              builder: (context, stateSetter) => Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter Tracks',
                      style: TextStyle(fontSize: 25),
                    ),
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RadioListTile(
                            dense: true,
                            value: 0,
                            title: Text('TOP'),
                            groupValue: _radioGroupValue,
                            onChanged: (value) => stateSetter(() =>
                                updateFilterRadioButton(value, ChartName.top))),
                        RadioListTile(
                            value: 1,
                            title: Text('HOT'),
                            groupValue: _radioGroupValue,
                            onChanged: (value) => stateSetter(() =>
                                updateFilterRadioButton(value, ChartName.hot))),
                        RadioListTile(
                            value: 2,
                            title: Text('Most Viewed ( week )'),
                            groupValue: _radioGroupValue,
                            onChanged: (value) => stateSetter(() =>
                                updateFilterRadioButton(
                                    value, ChartName.mxmweekly))),
                        RadioListTile(
                            value: 3,
                            title: Text('Most Viewed new release ( week )'),
                            groupValue: _radioGroupValue,
                            onChanged: (value) => stateSetter(() =>
                                updateFilterRadioButton(
                                    value, ChartName.mxmweekly_new))),
                      ],
                    ),
                    Container(
                      color: Colors.greenAccent,
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () => searchFilter(),
                          child: Text('Search',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18))),
                    )
                  ],
                ),
              ),
            ));
  }

  searchFilter() async {
    _navigationService.back();

    if (_isConnected) {
      setBusy(true);
      BaseResponse result = await fetchTracks();

      if (result.data != null) {
        trackData = result.data;
        trackList.clear();
        trackList = trackData.message.body.trackList;
        notifyListeners();
      } else {
        page = 0;
      }
      setBusy(false);
    } else
      _snackbarService.showSnackbar(message: 'check you network connection');
  }

  refreshItems() async {
    // setBusy(true);
    // bookedBusList.clear();
    page = 0;
    BaseResponse result = await fetchTracks();
    if (result.data != null) {
      trackData = result.data;
      trackList.clear();
      trackList = trackData.message.body.trackList;
      notifyListeners();
    } else {
      page = 0;
    }
    // setBusy(false);
    return true;
  }

  scrollListener() {
    listController.addListener(() async {
      if (listController.offset >= listController.position.maxScrollExtent &&
          !listController.position.outOfRange) {
        if (!isFetching && !isBusy) {
          setFetching(true);
          BaseResponse result = await fetchTracks();
          if (result.data != null) {
            trackData = result.data;
            trackList.addAll(trackData.message.body.trackList);
          } else {
            page = 0;
          }
          setFetching(false);
        }

        //TODO:call ten more booked item request;
      }
      if (listController.offset <= listController.position.minScrollExtent &&
          !listController.position.outOfRange) {
        print('reach top');
      }
    });
  }

  Future<BaseResponse> fetchTracks() async {
    print("page is $page");
    Map<String, dynamic> params = {
      "f_has_lyrics": 1,
      "page": page++,
      "page_size": pageSize,
      "chart_name": filter.toShortString(),
    };
    Response<BaseResponse> response =
        await _apiBloc.handleGet(type: FetchDataType.TRACK, parameters: params);
    return response.data;
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
  }
}
