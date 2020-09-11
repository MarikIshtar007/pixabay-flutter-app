import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:pixabay/widgets/VideoList.dart';

class LocalScreen extends StatefulWidget {
  @override
  _LocalScreenState createState() => _LocalScreenState();
}

class _LocalScreenState extends State<LocalScreen> {
  /// String to store the current state of the video processing work
  /// used by the Text Widget, updated within the _recordVideo method.
  String currentState = '';

  String albumName = 'MyMedia';
  bool showVideo = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 15),
      height: size.height,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _recordVideo,
            child: Icon(Icons.camera),
            backgroundColor: Colors.grey,
          ),
          Divider(
            thickness: 2,
            indent: 40,
            endIndent: 40,
          ),
          SizedBox(height: 10),
          Text(currentState, style: TextStyle(color: Colors.blue)),
          Container(
            height: size.height * 0.6,
            child: VideoList(),
          )
        ],
      ),
    );
  }

  /// Uses ImagePicker to Record a Video from the device and ask the user to
  /// confirm the video recorded or retry by taking another video
  void _recordVideo() async {
    ImagePicker().getVideo(source: ImageSource.camera).then((value) {
      if (value != null && value.path != null) {
        setState(() {
          currentState = 'Saving in progress';
        });
        GallerySaver.saveVideo(value.path, albumName: albumName).then((value) {
          setState(() {
            currentState = 'Video Saved';
          });
        });
      }
    });
  }
}
