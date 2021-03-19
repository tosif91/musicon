import 'package:flutter/material.dart';
import 'package:musicon/page/home/home_bloc.dart';
import 'package:musicon/widgets/home%20page/track_widget.dart';
import 'package:musicon/widgets/network_widget.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeBloc>.reactive(
      viewModelBuilder: () => HomeBloc(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.),
          title: Text('Music On'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: Colors.lightBlueAccent,
                    size: 35,
                  ),
                  onPressed: () => model.navigateToBookMark()),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          mini: true,
          onPressed: () => model.showFilterChart(context),
          child: Icon(
            Icons.filter_alt_rounded,
            color: Colors.white70,
          ),
        ),
        body: (!model.isConnected)
            ? NetworkWidget()
            : Container(
                child: (model.isBusy)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: (model.trackList.isEmpty)
                                ? Container(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.announcement_outlined,
                                                size: 45,
                                                color: Colors.amber,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Oops... \n No Tracks Found !',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            ],
                                          ),
                                          OutlinedButton(
                                              onPressed: () =>
                                                  model.retryingFetchList(),
                                              child: Text('Retry Again'))
                                        ],
                                      ),
                                    ),
                                  )
                                : RefreshIndicator(
                                    onRefresh: () => model.refreshItems(),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        controller: model.listController,
                                        itemCount: model.trackList.length,
                                        itemBuilder: (context, index) =>
                                            TrackWidget(
                                                data: model.trackList[index])),
                                  ),
                          ),
                          Container(
                              child: (model.isFetching)
                                  ? Container(
                                      padding: EdgeInsets.all(5),
                                      height: 35,
                                      width: 35,
                                      child: CircularProgressIndicator())
                                  : Container())
                        ],
                      ),
              ),
      ),
    );
  }
}
