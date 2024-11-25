import '../News.dart';
import '../components/news_service.dart';

class NewsController {
  final NewsService _newsService = NewsService();

  Future<List<News>> fetchMyNews(String userId) async {
    return await _newsService.getMyNews(userId);
  }
}
