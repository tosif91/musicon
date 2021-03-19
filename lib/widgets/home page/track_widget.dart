import 'package:flutter/material.dart';
import 'package:musicon/models/chart_track_response.dart';
import 'package:musicon/page/home/home_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:timeago/timeago.dart' as timeago;

class TrackWidget extends ViewModelWidget<HomeBloc> {
  final TrackList data;
  TrackWidget({@required this.data});
  @override
  Widget build(BuildContext context, HomeBloc model) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      elevation: 10.0,
      child: InkWell(
        onTap: () => model.navigateToLyrics(data),
        child: Container(
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          // color: Colors.amber[600],
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data.track.albumName}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${data.track.artistName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '#${data.track.trackRating}',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              Divider(
                color: Colors.white60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_outline_rounded,
                        color: Colors.white70,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('${data.track.numFavourite}')
                    ],
                  ),
                  Text(
                    '${timeago.format(data.track.updatedTime, locale: 'en')}',
                    style: TextStyle(fontSize: 14, color: Colors.white60),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
