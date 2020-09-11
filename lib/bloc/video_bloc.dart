import 'package:pixabay/api_data/video_api.dart';
import 'package:pixabay/model/video_model.dart';
import 'package:pixabay/utility/video_manager.dart';
import 'package:rxdart/rxdart.dart';

class VideoBloc {
  final VideosAPI _videosAPI;

  VideoManager videoManager;

  VideoBloc(this._videosAPI) {
    videoManager = VideoManager(stream: this.listVideosEvent);
    loadVideos();
  }

  // ignore: close_sinks
  final BehaviorSubject<List<Video>> _listVideosController =
      BehaviorSubject<List<Video>>.seeded(List<Video>());

  Stream<List<Video>> get listVideos => _listVideosController.stream;

  Sink<List<Video>> get listVideosEvent => _listVideosController.sink;

  List<Video> get videoList => videoManager.listVideos;

  loadVideos() async {
    videoManager.listVideos = await _videosAPI.getVideos();
    await videoManager.loadVideo(0);
    videoManager.playVideo(0);
  }
}
