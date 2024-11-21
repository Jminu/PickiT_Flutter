import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickit_flutter/screens/myaccount/components/my_account_header.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "assets/logo.png",
              height: 50,
              width: 125,
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(CupertinoIcons.search), onPressed: () {}),
          IconButton(icon: const Icon(CupertinoIcons.bell), onPressed: () {})
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Divider(thickness: 0.5, height: 0.5, color: Colors.grey),
        ),
      ),
      body: ListView(
        children: [
          MyAccountHeader(),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
