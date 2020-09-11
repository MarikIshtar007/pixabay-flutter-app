import 'package:video_player/video_player.dart';

class Video {
  int id;
  String url;

  VideoPlayerController controller;

  Video({this.id, this.url});

  Video.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    url = json['videos']['medium']['url'];
  }

  setupVideo() {
    controller = VideoPlayerController.network(url)
      ..initialize().then((_) => controller.setLooping(true));
  }
}
