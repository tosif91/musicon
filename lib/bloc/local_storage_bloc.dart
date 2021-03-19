import 'package:hive/hive.dart';
import 'package:musicon/models/bookmark_data.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class LocalStorageBloc {
  Box _trackBox;
  Future<bool> initHive() async {
    try {
      final getappDocumentDirectory =
          //get path for hive
          await path_provider.getApplicationDocumentsDirectory();
      //intiliase hive.
      Hive.init(getappDocumentDirectory.path);
      Hive.registerAdapter(BookMarkDataAdapter());
      return true;
    } catch (e) {
      return false;
    }
  }

  openHiveBox() async {
    try {
      _trackBox = await Hive.openBox('trackbook');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future saveBookMark(BookMarkData data) async {
    // _trackBox.con
    if (data != null) return await _trackBox.add(data).then((value) => true);
    return false;
  }

  BookMarkData retrieveItem(int index) {
    // _trackBox.
    return _trackBox.get(index) as BookMarkData;
  }

  filterTrackHistory(BookMarkData data) {
    var result;
    try {
      result = _trackBox.values
          .firstWhere((element) => data.trackId == element.trackId);
      return true;
    } catch (e) {
      return false;
    }
  }

  int getTrackBookLength() => _trackBox.length;
}
