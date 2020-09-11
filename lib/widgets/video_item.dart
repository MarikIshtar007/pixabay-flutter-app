import 'package:flutter/material.dart';
import 'package:pixabay/model/video_model.dart';
import 'package:video_player/video_player.dart';

Widget VideoItem(Video video) {
  var controller = video.controller;
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      controller != null && controller.value.initialized? 
      GestureDetector(
        onTap: (){
          controller.value.isPlaying? controller.pause(): controller.play();
        },
        child: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.size?.width ?? 0,
              height: controller.value.size?.height?? 0,
              child: VideoPlayer(controller),
            ),
          ),
        ),
      ): Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 50,)
        ],
      ),
    ],
  );
}
