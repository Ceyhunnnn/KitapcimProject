import 'package:bottom_bar/bottom_bar.dart';
import "package:flutter/material.dart";
import 'package:kitapcim/constants/context_extentions.dart';

import '../view/home/home_view.dart';
import '../view/library/library_view.dart';
import '../view/profile/profile_view.dart';
import '../view/voice_listen/voice_listen.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({Key? key}) : super(key: key);

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int _currentPage = 0;
  final _pageController = PageController();
  List<Widget> bottomBarList = [
    HomePage(),
    Library(),
    VoiceListen(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: bottomBarList,
        onPageChanged: (index) {
          // Use a better state management solution
          // setState is used for simplicity
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        backgroundColor: Color(0xff05595B),
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Anasayfa',
                style: context.customTextStyle(Colors.white, 15.0),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.white),
          BottomBarItem(
              icon: Icon(Icons.book_sharp),
              title: Text(
                'Kütüphane',
                style: context.customTextStyle(Colors.white, 15.0),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.white
              // Optional
              ),
          BottomBarItem(
              icon: Icon(Icons.library_music),
              title: Text(
                'Sesli Dinle',
                style: context.customTextStyle(Colors.white, 15.0),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.white

              // Optional
              ),
          BottomBarItem(
              icon: Icon(Icons.person),
              title: Text(
                'Profil',
                style: context.customTextStyle(Colors.white, 15.0),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.white
              // Optional
              ),
        ],
      ),
    );
  }
}
