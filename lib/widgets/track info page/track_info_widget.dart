import 'package:flutter/material.dart';
import 'package:musicon/models/track_info_response.dart';
import 'package:musicon/widgets/api_error_widget.dart';

class TrackInfoWidget extends StatelessWidget {
  final TrackInfoResponse data;
  TrackInfoWidget({@required this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Album Info',
              style: TextStyle(fontSize: 30, color: Colors.white70),
            ),
            // OutlinedButton(onPressed: () {}, child: Text('bookMark'),style: ,)
          ],
        ),
        (data == null)
            ? ApiErrorWidget()
            : Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoWidget(
                        title: 'Album Name',
                        content: '${data.message.body.track.albumName}'),
                    const SizedBox(
                      height: 10,
                    ),
                    InfoWidget(
                        title: 'Artist Name',
                        content: '${data.message.body.track.artistName}'),
                    const SizedBox(
                      height: 10,
                    ),
                    InfoWidget(
                        title: 'Explicit',
                        content: (data.message.body.track.explicit == 0)
                            ? 'false'
                            : 'true'),
                    InfoWidget(
                        title: 'Rating',
                        content: '# ${data.message.body.track.trackRating}'),
                    Divider(
                      color: Colors.white,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ],
                ),
              )
      ],
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String title;
  final String content;
  InfoWidget({@required this.title, @required this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15, color: Colors.white70),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              content,
              style: TextStyle(fontSize: 30, color: Colors.amber),
            ),
          )
        ],
      ),
    );
  }
}
