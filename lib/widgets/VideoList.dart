import 'package:flutter/material.dart';
import 'package:pixabay/widgets/media_grid.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  bool showVideo = false;
  var videoList;
  List<String> paths = [];
  List<String> thumbnails = [];

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          color: Colors.yellow,
          child: Text('Show/Hide Videos'),
          onPressed: () {
            setState(() {
              showVideo = !showVideo;
            });
          },
        ),
        showVideo?MediaGrid() : Container()
        // showVideo
        //     ? Container(
        //         height: MediaQuery.of(context).size.height * 0.5,
        //         child: ListView.builder(
        //           itemCount: paths.length,
        //           itemBuilder: (context, index) {
        //             print(paths[index]);
        //             return ListTile(
        //               // leading: Image(
        //               //   image: thumbnails[index],
        //               // ),
        //               subtitle: Text(
        //                 paths[index],
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //             );
        //           },
        //         ),
        //       )
        //     : Container()
      ],
    );
  }
}
