import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pickit_flutter/global.dart';
import '../../../UserManager.dart';
import '../../../theme.dart';
import '../../myaccount/my_scrapscreen.dart';

class MyAccountHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            _buildProfileRow(),
            const SizedBox(height: 30),
            _buildProfileButton(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoundTextButton(
                  "스크랩",
                  FontAwesomeIcons.bookmark,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MyScrapScreen(userId: loggedInUserId),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow() {
    return Row(
      children: [
        Stack(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32.5),
                child: Image.network(
                  "https://picsum.photos/200/100",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[100],
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("최최최명헌", style: textTheme().displayMedium),
            SizedBox(height: 10),
            Text("나는 나입니다."),
          ],
        )
      ],
    );
  }

  Widget _buildProfileButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFD4D5DD),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        height: 45,
        child: Center(
          child: Text(
            '프로필 보기',
            style: textTheme().titleMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildRoundTextButton(String title, IconData iconData, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          splashColor: Colors.orange.withAlpha(30),
          highlightColor: Colors.orange.withAlpha(50),
          borderRadius: BorderRadius.circular(30.0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: Color(0xFFD4D5DD), width: 0.5),
            ),
            child: Icon(
              iconData,
              color: Colors.orange,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: textTheme().titleMedium,
        ),
      ],
    );
  }
}
