import 'package:musicon/models/filter_data.dart';
import 'package:musicon/utils/constants.dart';

class BaseResponse<T> {
  T data;
  String message;
  bool success;
  BaseResponse({
    this.data,
    this.message,
    this.success,
  });
}
