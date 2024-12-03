import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickit_flutter/screens/home/home_screen.dart';
import 'package:pickit_flutter/screens/keyword/keyword_screen.dart';
import 'package:pickit_flutter/screens/myaccount/my_scrapscreen.dart';
import '../global.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(), // 홈 화면
          KeywordScreen(), // 키워드 화면
          MyScrapScreen(userId: Global.loggedInUserId), // 스크랩 화면
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "홈",
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            label: "키워드",
            icon: Icon(CupertinoIcons.tag),
          ),
          BottomNavigationBarItem(
            label: "스크랩",
            icon: Icon(CupertinoIcons.bookmark),
          ),
        ],
      ),
    );
  }
}
