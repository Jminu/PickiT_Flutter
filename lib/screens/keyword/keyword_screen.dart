import 'package:flutter/material.dart';
import '../../models/keyword_data.dart';
import 'components/keyword_register_button.dart';
import 'components/keyword_list_item.dart';
import 'components/swipe_to_delete.dart';

class KeywordScreen extends StatefulWidget {
  @override
  _KeywordScreenState createState() => _KeywordScreenState();
}

class _KeywordScreenState extends State<KeywordScreen> {
  List<KeywordData> registeredKeywords = [];

  void _addKeyword(KeywordData keyword) {
    setState(() {
      registeredKeywords.add(keyword);
    });
  }

  void _removeKeyword(int index) {
    setState(() {
      registeredKeywords.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('키워드 관리'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          KeywordRegisterButton(onKeywordAdded: _addKeyword),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: registeredKeywords.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 30.0,
                  ),

                  //여기에 키워드 관리 창에서 등록된 키워드 누르면 그 키워드 페이지 라우팅
                  child: SwipeToDelete(
                    onDelete: () => _removeKeyword(index),
                    child: KeywordListItem(
                      keyword: registeredKeywords[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              appBar: AppBar(
                                title: Text(registeredKeywords[index].title),
                              ),
                              body: Center(
                                child: Text(
                                  'This is the detail page for ${registeredKeywords[index].title}.',
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
