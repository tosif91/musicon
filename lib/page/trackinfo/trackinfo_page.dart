import 'package:flutter/material.dart';
import 'package:musicon/models/chart_track_response.dart';
import 'package:musicon/page/trackinfo/trackinfo_bloc.dart';
import 'package:musicon/widgets/track%20info%20page/track_info_widget.dart';
import 'package:musicon/widgets/track%20info%20page/track_lyrics_widget.dart';
import 'package:stacked/stacked.dart';

class TrackInfoPage extends StatelessWidget {
  final dynamic data;
  TrackInfoPage({@required this.data});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrackInfoBloc>.reactive(
      viewModelBuilder: () => TrackInfoBloc(),
      onModelReady: (model) => model.initialize(data),
      builder: (context, model, _) => WillPopScope(
        onWillPop: () => model.handleBack(),
        child: Scaffold(
            appBar: AppBar(
              title: Text('Lyrics'),
            ),
            floatingActionButton: (model.isBookMarked)
                ? null
                : FloatingActionButton(
                    child: Icon(
                      Icons.bookmarks,
                      color: Colors.white,
                    ),
                    onPressed: () => model.saveToBookMark(),
                  ),
            body: Container(
              child: (model.isBusy)
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TrackInfoWidget(data: model.trackInfo),
                            TrackLyricsWidget(data: model.lyricsInfo)
                          ],
                        ),
                      ),
                    ),
            )),
      ),
    );
  }
}
