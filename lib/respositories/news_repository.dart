import 'dart:convert';
import 'package:agram_news/models/news_model.dart';
import 'base_news_repository.dart';
import 'package:http/http.dart' as http;

class NewsRepository extends BaseNewsRepository {
  @override
  Future<List<NewsModel>> getNews() async {
    final client = http.Client();
    final queryParameters = {
      'country': 'us',
      'category': 'technology',
      'apiKey': 'cab81878ac0f4d4fbd097c3752706e94'
    };
    final uri = Uri.https('newsapi.org', '/v2/top-headlines', queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<NewsModel> articles =
        body.map((dynamic item) => NewsModel.fromJson(item)).toList();
    return articles;
  }
}
