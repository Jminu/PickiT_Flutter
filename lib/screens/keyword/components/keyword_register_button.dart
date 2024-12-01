import 'package:flutter/material.dart';
import 'package:pickit_flutter/Keyword.dart';
import 'package:pickit_flutter/KeywordManager.dart';

class KeywordRegisterButton extends StatelessWidget {
  final Function(Keyword) onKeywordAdded;
  final KeywordManager keywordManager;

  const KeywordRegisterButton({
    required this.onKeywordAdded,
    required this.keywordManager,
    Key? key,
  }) : super(key: key);

  void _showKeywordDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("키워드 추가"),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: "키워드를 입력하세요",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("취소"),
            ),
            TextButton(
              onPressed: () async {
                String keywordText = _controller.text.trim();
                if (keywordText.isNotEmpty) {
                  Keyword newKeyword = Keyword(keywordText, true);

                  // Add keyword only if it is not a duplicate
                  await keywordManager.addKeyword(newKeyword);

                  // Notify the parent widget about the new keyword (only if it was added)
                  onKeywordAdded(newKeyword);

                  // Close the dialog
                  Navigator.pop(context);
                }
              },
              child: const Text("추가"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showKeywordDialog(context);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            vertical: 14.0, horizontal: 30.0), // Increase button size
      ),
      child: const Text('키워드 추가'),
    );
  }
}
