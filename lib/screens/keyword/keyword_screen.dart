import 'package:flutter/material.dart';
import '../../models/keyword_data.dart';
import 'components/keyword_item.dart';
import 'package:url_launcher/url_launcher.dart';

class KeywordScreen extends StatefulWidget {
  @override
  _KeywordScreenState createState() => _KeywordScreenState();
}

class _KeywordScreenState extends State<KeywordScreen> {
  final KeywordManager keywordManager = KeywordManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('키워드 관리'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 상단 가로 스크롤 키워드 목록
          Container(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: keywordList.map((keywordData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: KeywordItem(
                    keyword: keywordData.keyword,
                    isRegistered: keywordData.registered,
                    onTap: () {
                      setState(() {
                        keywordManager.toggleKeyword(keywordData);
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Divider(),
          // 하단 등록된 키워드 목록
          Expanded(
            child: ListView(
              children: keywordManager.registeredKeywords.map((keywordData) {
                return Dismissible(
                  key: ValueKey(keywordData.keyword),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    setState(() {
                      keywordManager.removeKeyword(keywordData);
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(keywordData.keyword),
                    onTap: () => _launchURL(keywordData.url),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // URL 이동 함수
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'URL 열기 실패: $url';
    }
  }
}
