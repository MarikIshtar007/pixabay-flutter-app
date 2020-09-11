import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pixabay/model/video_model.dart';

const apiKey = '18242444-376c47aebdfa61b15f4a1ac10';
const baseUrl = 'https://pixabay.com/api/videos';

class VideosAPI {
  VideosAPI();

  Future<List<Video>> getVideos() async {
    var raw_data = await http.get('$baseUrl/?key=$apiKey');
    var jsonData = jsonDecode(raw_data.body);
    var videoList = <Video>[];
    var hits = jsonData['hits'];
    for (var item in hits) {
      Video video = Video.fromJSON(item);
      videoList.add(video);
    }
    return videoList;
  }
}
