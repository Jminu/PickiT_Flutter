import '../News.dart';
import '../components/news_service.dart';
import '../global.dart';

class NewsController {


  Future<List<News>> fetchMyNews(String userId) async {
    return await Global.getMyNews(userId); // Global의 메서드를 호출
  }
}
