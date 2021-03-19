import 'package:flutter/material.dart';
import 'package:musicon/models/track_lyrics_response.dart';
import 'package:musicon/widgets/api_error_widget.dart';

class TrackLyricsWidget extends StatelessWidget {
  final TrackLyricsResponse data;
  TrackLyricsWidget({@required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Lyrics',
            style: TextStyle(fontSize: 30, color: Colors.white70),
          ),
          (data == null)
              ? ApiErrorWidget()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${data.message.body.lyrics.lyricsBody}',
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                )
        ],
      ),
    );
  }
}
