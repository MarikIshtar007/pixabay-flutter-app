import 'package:flutter/material.dart';
import 'package:pixabay/widgets/customTab.dart';
import 'local.dart';
import 'pixabay.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Test App'),
          centerTitle: true,
          bottom: TabBar(
            indicator: CircleTabIndicator(color: Colors.white, radius: 3),
            tabs: [
              Tab(
                text: 'Pixabay',
              ),
              Tab(
                text: 'Local',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [PixabayScreen(), LocalScreen()],
        ),
      ),
    );
  }
}
