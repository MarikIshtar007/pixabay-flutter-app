import 'package:flutter/material.dart';
import 'package:pixabay/api_data/video_api.dart';
import 'package:pixabay/bloc/video_bloc.dart';
import 'package:pixabay/model/video_model.dart';
import 'package:pixabay/widgets/video_item.dart';

class PixabayScreen extends StatefulWidget {
  @override
  _PixabayScreenState createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  Stream<List<Video>> listVideos;
  VideoBloc _videoBloc;

  @override
  void initState() {
    super.initState();
    _videoBloc = VideoBloc(VideosAPI());
    listVideos = _videoBloc.listVideos;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    initialData: List<Video>(),
                    stream: listVideos,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Video> videos = snapshot.data;
                        if (videos.length > 0) {
                          return PageView.builder(
                            controller: PageController(
                                initialPage: 0, viewportFraction: 1),
                            onPageChanged: (idx) {
                              idx = idx % (videos.length);
                              _videoBloc.videoManager.changeVideo(idx);
                            },
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              index = index % (videos.length);
                              return VideoItem(
                                  _videoBloc.videoManager.listVideos[index]);
                            },
                          );
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
