import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:musicon/models/chart_track_response.dart';
import 'package:musicon/models/track_info_response.dart';
import 'package:musicon/models/track_lyrics_response.dart';
import 'package:musicon/utils/constants.dart';

class FilterData {
  static fromMap({@required var response, @required FetchDataType type}) {
    if (response != null) {
      switch (type) {
        case FetchDataType.TRACK:
          return ChartTrackResponse.fromJson(response);
        case FetchDataType.TRACKINFO:
          return TrackInfoResponse.fromJson(response);
        case FetchDataType.LYRICS:
          return TrackLyricsResponse.fromJson(response);
      }
    } else {
      return null;
    }
  }
}
