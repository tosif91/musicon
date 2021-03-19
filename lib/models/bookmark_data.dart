import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'bookmark_data.g.dart';

@HiveType(typeId: 0)
class BookMarkData {
  @HiveField(0)
  final String trackId;
  @HiveField(1)
  final String trackName;
  BookMarkData(this.trackId, this.trackName);
}
