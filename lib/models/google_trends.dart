import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleTrendsScreen extends StatefulWidget {
  @override
  _GoogleTrendsScreenState createState() => _GoogleTrendsScreenState();
}

class _GoogleTrendsScreenState extends State<GoogleTrendsScreen> {
  late final WebViewController _controller;
  List<String> trendingKeywords = [];
  bool isLoading = true; // 로딩 상태 관리

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
          onPageFinished: (_) => _extractKeywords(), // 페이지 로드 후 키워드 추출
        ),
      );
  }

  Future<void> _extractKeywords() async {
    try {
      // JavaScript 실행해서 키워드 가져옴 & 개발자 도구 켜서, 주소 찾아서 입력
      final result = await _controller.runJavaScriptReturningResult("""
        (() => {
          const elements = document.querySelectorAll('.mZ3RIc');
          return Array.from(elements).map(el => el.innerText).join('|');
        })();
      """);

      // 데이터 깨끗하게 처리
      setState(() {
        trendingKeywords = result
            .toString()
            .replaceAll('"', '')
            .split('|')
            .where((keyword) => keyword.isNotEmpty)
            .toList();
        isLoading = false; // 로딩 종료
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("데이터 추출 실패: $e")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            )
          else if (trendingKeywords.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: trendingKeywords.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(trendingKeywords[index]),
                  );
                },
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '키워드를 가져올 수 없습니다.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
