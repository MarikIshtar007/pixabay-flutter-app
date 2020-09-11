import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaGrid extends StatefulWidget {
  @override
  _MediaGridState createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  List<Widget> _mediaList = [];
  int currentPage = 0;
  int lastPage;

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  handleScroll(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    var result = await PhotoManager.requestPermission();
    if (result) {
      //load the Album
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(type: RequestType.video);
      List<AssetEntity> media =
          await albums[0].getAssetListPaged(currentPage, 60);

      List<Widget> temp = [];
      for (var asset in media) {
        temp.add(FutureBuilder(
          future: asset.thumbDataWithSize(200, 200),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Positioned.fill(
                      child: Image.memory(
                    snapshot.data,
                    fit: BoxFit.cover,
                  )),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 5, bottom: 5),
                      child: Icon(
                        Icons.videocam,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ));
      }
      setState(() {
        _mediaList.addAll(temp);
        currentPage++;
      });
    } else {
      //fail
      /// if result is fail, you can call `PhotoManager.openSetting();` ,
      ///  to open android/ios applicaton's setting to get permission
      PhotoManager.openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
          child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scroll) {
          handleScroll(scroll);
          return;
        },
        child: GridView.builder(
          itemCount: _mediaList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return _mediaList[index];
          },
        ),
      ),
    );
  }
}
