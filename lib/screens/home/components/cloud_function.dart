import 'dart:convert'; // JSON 디코딩을 위해 필요
import 'package:http/http.dart' as http;
import '../../../models/article.dart';

class CloudFunctionService {
  Future<List<Article>> fetchFilteredNews(String userId) async {
    final response = await http.get(
      Uri.parse("https://<your-cloud-function-url>?userId=$userId"),
    );

    if (response.statusCode == 200) {
      return parseArticles(response.body); // JSON 문자열 파싱
    } else {
      throw Exception("Failed to fetch news");
    }
  }

  List<Article> parseArticles(String responseBody) {
    final List<dynamic> jsonData = jsonDecode(responseBody);
    return jsonData.map((data) => Article.fromJson(data)).toList();
  }
}
