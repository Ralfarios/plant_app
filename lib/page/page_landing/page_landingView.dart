import 'package:flutter/material.dart';
import 'package:plant_app/core/consts/style/color.dart';
import 'package:plant_app/core/consts/style/theme.dart';

import '../../core/consts/element/widget.dart';
import 'model/page_landingModel.dart';

class PageLandingView extends StatefulWidget {
  @override
  _PageLandingViewState createState() => _PageLandingViewState();
}

class _PageLandingViewState extends State<PageLandingView> {
  int _currentIndex = 0;
  String _title;
  final List<Widget> _children = [
    BrowseTab(),
    ExploreTab(),
  ];

  @override
  void initState() {
    super.initState();
    _title = "Browse";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context, null, withButton(context, _title, Icon(Icons.settings))),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8,
        onTap: onTabTapped,
        backgroundColor: cWhite,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              "Browse",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontMedium,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text(
              "Explore",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontMedium,
              ),
            ),
          )
        ],
        selectedItemColor: cgGreenLeft,
        selectedFontSize: 14,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          {
            _title = "Browse";
          }
          break;
        case 1:
          {
            _title = "Explore";
          }
          break;
      }
    });
  }
}
