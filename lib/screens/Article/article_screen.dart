import 'package:flutter/material.dart';
import '../../Controller/GetSummary.dart';
import '../../News.dart';
import '../../models/article.dart';
import '../../components/news_service.dart'; // getSummary 함수 사용
import '../../global.dart';
import 'components/article_content.dart';
import 'components/article_floating_button.dart';
import 'components/article_header.dart';

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArticleHeader(article: article), // 헤더 컴포넌트
              const SizedBox(height: 16),
              ArticleContent(content: article.content), // 본문 컴포넌트
              const SizedBox(height: 300),
            ],
          ),
        ),
      ),
      floatingActionButton: ArticleFloatingButton(
        onBookmark: () async {
          String? userId = Global.getLoggedInUserId();
          if (userId != null) {
            await _scrapArticle(context, userId, article); // 스크랩 로직
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("로그인이 필요합니다.")),
            );
          }
        },
        onScrollToTop: () {
          Scrollable.ensureVisible(
            context,
            alignment: 0.0,
            duration: const Duration(milliseconds: 300),
          );
        },
        onSummarize: () async {
          await _showSummaryPopup(context, article.url); // 요약 기능 추가
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
      Navigator.pop(context);

      // 요약 팝업 창 표시
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("본문 요약"),
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
          article.imageUrl, // 이미지 URL 추가
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
