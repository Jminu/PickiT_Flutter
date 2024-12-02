import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart'; // WebView import
import '../../News.dart';
import '../../models/article.dart';
import '../../Controller/GetSummary.dart'; // 요약 함수
import '../../global.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  const ArticleScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick iT", style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: () async {
              final url = article.url; // 기사 원문 URL
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("URL을 열 수 없습니다.")),
                );
              }
            },
          ),
        ],
      ),
      body: WebView(
        initialUrl: article.url, // 기사 원문 URL을 로드
        javascriptMode: JavascriptMode.unrestricted, // JavaScript 허용
      ),
      floatingActionButton: _buildFloatingActionButtons(context),
    );
  }

  // Floating Action Buttons 생성
  Widget _buildFloatingActionButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'bookmark',
          onPressed: () async {
            String? userId = Global.getLoggedInUserId();
            if (userId != null) {
              await _scrapArticle(context, userId, article);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("로그인이 필요합니다.")),
              );
            }
          },
          child: const Icon(Icons.bookmark),
        ),
        const SizedBox(height: 16),
        FloatingActionButton(
          heroTag: 'summarize',
          onPressed: () async {
            await _showSummaryPopup(context, article.url);
          },
          child: const Icon(Icons.remove_red_eye), // 요약 아이콘
        ),
      ],
    );
  }

  // 요약 팝업 함수
  Future<void> _showSummaryPopup(BuildContext context, String newsLink) async {
    try {
      // 로딩 다이얼로그 표시
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // 요약 데이터 가져오기
      String summary = await getSummary(newsLink);

      // 로딩 다이얼로그 닫기
      Navigator.pop(context);

      // 요약 팝업 창 표시
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("기사 요약"),
          content: Text(
            summary.isNotEmpty ? summary : "요약 내용을 가져올 수 없습니다.",
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("닫기"),
            ),
          ],
        ),
      );
    } catch (e) {
      // 에러 발생 시 처리
      Navigator.pop(context); // 로딩 다이얼로그 닫기
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("요약 중 오류 발생: $e")),
      );
    }
  }

  // 스크랩 로직
  Future<void> _scrapArticle(
      BuildContext context, String userId, Article article) async {
    try {
      await Global.addMyNews(
        userId,
        News(
          article.title,
          article.url,
          article.date,
          article.imageUrl,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("기사가 스크랩되었습니다!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("스크랩 중 오류 발생: $e")),
      );
    }
  }
}
