import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:musicon/interceptor/common_interceptor.dart';
import 'package:musicon/models/base_response.dart';
import 'package:musicon/utils/constants.dart';

class ApiBloc {
  static BaseOptions options = new BaseOptions(
    baseUrl: baseURL,
    connectTimeout: 15000,
    receiveTimeout: 15000,
  );

  Dio _dio = new Dio(
    options,
  );

  // Future<Response<BaseData<dynamic>>> handlePost({
  //   Map<String, dynamic> body,
  //   Map<String, dynamic> parameters,
  //   FetchDataType type,
  // }) async {
  //   Response<BaseData> response = Response<BaseData>();

  //   try {
  //     Map<String, dynamic> requiredData;
  //     // = await fetchCredentials(type);

  //     response = await _dio.post(
  //       requiredData['path'],
  //       queryParameters: parameters,
  //       data: body,
  //       options: Options(
  //         headers: _dioHeader(
  //             token:
  //                 (requiredData['token'] != null) ? requiredData['token'] : '',
  //             sessionID: (requiredData['sessionid'] != null)
  //                 ? requiredData['sessionid']
  //                 : ''),
  //       ),
  //     );
  //     // print(response.runtimeType);
  //     return response;
  //   } catch (e) {
  //     print(e);
  //     print('got an error while api call');
  //     response.data = BaseData(
  //         success: false,
  //         data: null,
  //         message: _setErrorMessage(e),
  //         statusCode: serverError(e));
  //     return response;
  //   }
  // }

  Future<Response<BaseResponse>> handleGet({
    Map<String, dynamic> parameters,
    Map<String, dynamic> extras,
    FetchDataType type,
  }) async {
    Response<BaseResponse> response = Response();
    try {
      _dio.interceptors?.clear();
      _dio.interceptors.add(CommonInterceptor(type: type));
      parameters['apikey'] = apiKey;
      String path = filterPath(type);
      response = await _dio.get(
        path,
        queryParameters: parameters,
      );
      return response;
    } catch (e) {
      print(e);
      response.data = BaseResponse(
          success: false, data: null, message: _setErrorMessage(e));
      return response;
    }
  }

  String filterPath(FetchDataType type) {
    switch (type) {
      case FetchDataType.TRACK:
        return '/chart.tracks.get';
      case FetchDataType.LYRICS:
        return '/track.lyrics.get';
      case FetchDataType.TRACKINFO:
        return '/track.get';
      default:
        return '';
    }
  }

  String _setErrorMessage(DioError err) {
    switch (err.type) {
      case DioErrorType.CANCEL:
        return "please try again";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        return "oop's connection timeout";
        break;

      case DioErrorType.RECEIVE_TIMEOUT:
        return "please try again";
        break;

      case DioErrorType.DEFAULT:
        return (err.error is SocketException)
            ? "check you network connection"
            : "something went wrong";

        break;

      case DioErrorType.SEND_TIMEOUT:
        return "oop's connection timeout";
        break;

      case DioErrorType.RESPONSE:
        return "${err.response.statusMessage}";
    }
  }

  int serverError(DioError err) {
    return err.response.statusCode;
  }
}
