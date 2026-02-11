import 'package:news_c17_online/models/news_response.dart';
import 'package:news_c17_online/models/sources_reponse.dart';

abstract class HomeLocalRepo {
  Future<SourcesResponse> getSources(String categoryId);

  Future<NewsResponse> getNews(String sourceId);
}
