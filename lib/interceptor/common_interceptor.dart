import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:musicon/models/base_response.dart';
import 'package:musicon/models/filter_data.dart';
import 'package:musicon/utils/constants.dart';

class CommonInterceptor extends Interceptor {
  FetchDataType type;
  CommonInterceptor({@required this.type});
  @override
  Future onResponse(Response response) {
    // TODO: implement onResponse
    return super.onResponse(checkResponse(response: response, dataType: type));
  }

  @override
  Future onError(DioError err) {
    // TODO: implement onError

    return super.onError(err);
  }

  @override
  Future onRequest(RequestOptions options) {
    // TODO: implement onRequest
    print(" header => ${options.headers}");
    print("baseURL => ${options.baseUrl}");
    print("path => ${options.path}");
    print("body => ${options.data}");
    print("parameters => ${options.queryParameters}");
    return super.onRequest(options);
  }

  Response<BaseResponse> checkResponse(
      {@required Response response, FetchDataType dataType}) {
    BaseResponse returnData = BaseResponse();
    Response<BaseResponse> returnResponse = Response<BaseResponse>();

    var jsonResponse = jsonDecode(response.data.toString());

    int responseStatusCode = jsonResponse["message"]["header"]['status_code'];

    if (response != null && responseStatusCode == 200) {
      //we got response from server
      returnData.success = true;
      print('insied code 200 interceptor : $response');
      returnData.success = true;

      returnData.data =
          FilterData.fromMap(response: jsonResponse, type: dataType);
    } else {
      returnData.success = false;
      returnData.data = null;
    }
    returnResponse.data = returnData;
    return returnResponse;
  }
}
