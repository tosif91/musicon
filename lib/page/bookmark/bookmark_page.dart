import 'package:flutter/material.dart';
import 'package:musicon/models/bookmark_data.dart';
import 'package:musicon/models/chart_track_response.dart';
import 'package:musicon/page/bookmark/bookmark_bloc.dart';
import 'package:stacked/stacked.dart';

class BookMarkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookMarkBloc>.reactive(
      viewModelBuilder: () => BookMarkBloc(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, _) => Scaffold(
          appBar: AppBar(
            title: Text('Track Book'),
          ),
          body: (model.isBusy)
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  child: (model.bookLength == 0)
                      ? Center(
                          child: Text('no saved TrackBook!',style: TextStyle(fontSize: 25),),
                        )
                      : ListView.builder(
                          itemCount: model.bookLength,
                          itemBuilder: (context, index) => InkWell(
                              onTap: () => model.navigateToTrackInfo(index),
                              child: TrackBookItem(
                                  data: model.retrieveItem(index)))),
                )),
    );
  }
}

class TrackBookItem extends StatelessWidget {
  final BookMarkData data;
  TrackBookItem({@required this.data});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.queue_music_sharp),
      title: Text(data.trackName),
      subtitle: Text(
        "${data.trackId}",
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
