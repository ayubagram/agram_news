import 'package:agram_news/models/news_model.dart';

abstract class BaseNewsRepository {
  Future<List<NewsModel>> getNews();
}
