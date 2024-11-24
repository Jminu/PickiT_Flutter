import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:pickit_flutter/screens/home/home_screen.dart';
import 'package:pickit_flutter/screens/keyword/keyword_screen.dart';
import 'package:pickit_flutter/screens/myaccount/my_account.dart';

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
          HomeScreen(),
          KeywordScreen(),
          MyAccount(),
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
        items: [
          const BottomNavigationBarItem(
              label: "홈", icon: Icon(CupertinoIcons.home)),
          const BottomNavigationBarItem(
              label: "키워드", icon: Icon(CupertinoIcons.tag)),
          const BottomNavigationBarItem(
              label: "내 정보", icon: Icon(CupertinoIcons.person_circle)),
        ],
      ),
    );
  }
}
