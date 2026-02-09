import 'package:news_c17_online/models/news_response.dart';
import 'package:news_c17_online/models/sources_reponse.dart';
import 'package:news_c17_online/screens/repository/home_repo.dart';

class HomeRepoLocal extends HomeRepo {
  @override
  Future<NewsResponse> getNews(String sourceId) {
    // TODO: implement getNews
    throw UnimplementedError();
  }

  @override
  Future<SourcesResponse> getSources(String categoryId) {
    // TODO: implement getSources
    throw UnimplementedError();
  }
}
