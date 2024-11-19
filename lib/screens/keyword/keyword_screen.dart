import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/new_keyword.dart'; // models 폴더에서 import
import 'components/keyword_detail.dart'; // 상세 페이지로 이동

class KeywordScreen extends StatefulWidget {
  @override
  _KeywordScreenState createState() => _KeywordScreenState();
}

class _KeywordScreenState extends State<KeywordScreen> {
  List<Keyword> recommendedKeywords = [
    Keyword(name: "Flutter"),
    Keyword(name: "Dart"),
    Keyword(name: "Android"),
    Keyword(name: "Programming"),
  ];

  List<Keyword> registeredKeywords = [
    Keyword(name: "Flutter", isRegistered: true),
    Keyword(name: "Dart", isRegistered: true),
  ];

  void _registerKeyword(Keyword keyword) {
    setState(() {
      if (!keyword.isRegistered) {
        registeredKeywords.add(keyword);
        recommendedKeywords = recommendedKeywords
            .where((item) => item.name != keyword.name)
            .toList(); // 추천 키워드에서 제거
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/logo.png", height: 50, width: 125),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(CupertinoIcons.search), onPressed: () {}),
          IconButton(icon: const Icon(CupertinoIcons.bell), onPressed: () {}),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Divider(thickness: 0.5, height: 0.5, color: Colors.grey),
        ),
      ),
      body: ListView(
        children: [
          _buildKeywordSection("추천 키워드", recommendedKeywords, true),
          _buildKeywordSection("등록된 키워드", registeredKeywords, false),
        ],
      ),
    );
  }

  // 키워드 섹션을 구성하는 위젯
  Widget _buildKeywordSection(
      String title, List<Keyword> keywords, bool isRecommended) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // 추천 키워드 섹션: 가로 스크롤 가능한 키워드 목록
          isRecommended
              ? Container(
                  height: 55, // 키워드 높이
                  child: ListView(
                    scrollDirection: Axis.horizontal, // 가로 스크롤
                    children: keywords.map((keyword) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: InkWell(
                          onTap: () {
                            _registerKeyword(keyword); // 키워드 등록
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[500], // 연한 검은색으로 변경

                              borderRadius: BorderRadius.circular(40.0),
                              border: Border.all(
                                  color: Colors.grey[400]!, width: 1.0),
                            ),
                            child: Center(
                              child: Text(
                                keyword.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              : Column(
                  children: keywords.map((keyword) {
                    return ListTile(
                      title: Text(keyword.name),
                      trailing: keyword.isRegistered
                          ? Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        // 등록된 키워드를 클릭 시, 관련 페이지로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                KeywordDetailScreen(keyword: keyword.name),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
