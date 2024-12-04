import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pickit_flutter/Keyword.dart'; // Keyword import

class GoogleTrendsScreen extends StatefulWidget {
  final Function(List<Keyword>) onKeywordsExtracted; // 키워드 추출 후 호출하는 콜백

  const GoogleTrendsScreen({Key? key, required this.onKeywordsExtracted})
      : super(key: key);

  @override
  _GoogleTrendsScreenState createState() => _GoogleTrendsScreenState();
}

class _GoogleTrendsScreenState extends State<GoogleTrendsScreen> {
  late WebViewController _controller;
  bool isLoading = true;
  bool keywordsExtracted = false; // 키워드 추출 여부
  List<Keyword> extractedKeywords = []; // 추출된 키워드 리스트

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://trends.google.co.kr/trending?geo=KR'))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) => _extractKeywords(),
        ),
      );
  }

  Future<void> _extractKeywords() async {
    try {
      final result = await _controller.runJavaScriptReturningResult("""
        (() => {
          const elements = document.querySelectorAll('.mZ3RIc');
          return Array.from(elements).map(el => el.innerText).slice(0, 20).join('|');
        })();
      """);

      final keywords = result
          .toString()
          .replaceAll('"', '')
          .split('|')
          .where((keyword) => keyword.isNotEmpty)
          .toList();

      final keywordObjects = keywords.map((k) => Keyword(k)).toList();

      widget.onKeywordsExtracted(keywordObjects); // 키워드 추출 후 콜백

      setState(() {
        isLoading = false;
        keywordsExtracted = true;
        extractedKeywords = keywordObjects;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("데이터 추출 실패: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (keywordsExtracted) {
      return ListView.builder(
        itemCount: extractedKeywords.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(extractedKeywords[index].keyWord),
          );
        },
      );
    }

    return const Center(child: Text('키워드가 없습니다.'));
  }
}
