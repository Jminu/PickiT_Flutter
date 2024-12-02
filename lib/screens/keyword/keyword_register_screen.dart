import 'package:flutter/material.dart';
import '../../models/recommended_keywords.dart';
import 'package:pickit_flutter/theme.dart';
import '../../keywordmanager.dart';
import '../../global.dart';
import 'package:pickit_flutter/Keyword.dart';

class KeywordRegisterScreen extends StatefulWidget {
  final Function(Keyword) onKeywordAdded; // Add this callback

  const KeywordRegisterScreen({Key? key, required this.onKeywordAdded})
      : super(key: key);

  @override
  _KeywordRegisterScreenState createState() => _KeywordRegisterScreenState();
}

class _KeywordRegisterScreenState extends State<KeywordRegisterScreen> {
  final TextEditingController _controller = TextEditingController();
  late KeywordManager keywordManager; // KeywordManager instance

  @override
  void initState() {
    super.initState();
    final userId = Global.getLoggedInUserId(); // Get logged-in userId
    keywordManager = KeywordManager(userId); // Initialize KeywordManager
  }

  // Register and activate keyword
  Future<void> _registerAndActivateKeyword(String keywordText) async {
    if (keywordManager.userId == null) {
      print("User is not logged in.");
      return;
    }

    final keyword = Keyword(keywordText);

    // Add and activate keyword
    await keywordManager.addKeyword(keyword);
    await keywordManager.activateKeyword(keyword);

    // Remove from recommended list after registration
    setState(() {
      recommendedKeywords.removeWhere((k) => k.keyWord == keywordText);
    });

    // Notify KeywordScreen via callback
    widget.onKeywordAdded(keyword);

    // Show registration success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('키워드가 등록되었습니다.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('키워드 추천&등록'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: '키워드를 등록하세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                MaterialButton(
                  onPressed: () {
                    final keyword = _controller.text.trim();
                    if (keyword.isNotEmpty) {
                      _registerAndActivateKeyword(keyword);
                      _controller.clear(); // Clear the input field
                    }
                  },
                  child: Text(
                    '등록',
                    style: TextStyle(fontSize: 18),
                  ),
                  color: Colors.grey[700],
                  textColor: Colors.white,
                  height: 52,
                  minWidth: 5,
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Text(
            "🔥요새 키워드 트렌드",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 15),
          // Trend keywords list
          Expanded(
            child: ListView.builder(
              itemCount: recommendedKeywords.length,
              itemBuilder: (context, index) {
                final keyword = recommendedKeywords[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 32.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(1, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        keyword.keyWord,
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: MaterialButton(
                        onPressed: () {
                          _registerAndActivateKeyword(keyword.keyWord);
                        },
                        color: Colors.grey[400],
                        textColor: Colors.white,
                        minWidth: 50,
                        child: const Text(
                          '등록',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
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
