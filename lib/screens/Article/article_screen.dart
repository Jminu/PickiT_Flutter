import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart'; // WebView import
import '../../News.dart';
import '../../models/article.dart';
import '../../Controller/GetSummary.dart'; // 요약 함수
import '../../global.dart';
import 'components/article_floating_button.dart'; // Floating Button

class ArticleScreen extends StatefulWidget {
  final Article article;

  const ArticleScreen({Key? key, required this.article}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  // WebView 초기화 메서드
  void _initializeWebView() async {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)  // JavaScript 허용
      ..loadRequest(Uri.parse(widget.article.url));  // URL 로딩
  }

  // 기사 최상단으로 스크롤
  void _scrollToTop() async {
    await _controller.scrollTo(0, 0);
  }

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
              final url = widget.article.url; // 기사 원문 URL
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
      body: WebViewWidget(
        controller: _controller,  // WebViewController 전달
      ),
      floatingActionButton: ArticleFloatingButton(
        onBookmark: () async {
          String? userId = Global.getLoggedInUserId();
          if (userId != null) {
            await _scrapArticle(context, userId, widget.article);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("로그인이 필요합니다.")),
            );
          }
        },
        onScrollToTop: _scrollToTop,  // 최상단으로 스크롤하는 함수 전달
        onSummarize: () async {
          await _showSummaryPopup(context, widget.article.url);
        },
      ),
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
      Navigator.pop(context); // 로딩 다이얼로그 닫기

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
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("요약 중 오류 발생: $e")),
      );
    }
  }

  // 스크랩 로직
  Future<void> _scrapArticle(
      BuildContext context, String userId, Article article) async {
    try {
      News news = News(
        title: article.title,
        link: article.url,
        published: article.date,
        imageUrl: article.imageUrl,
      );

      await Global.addMyNews(userId, news);
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