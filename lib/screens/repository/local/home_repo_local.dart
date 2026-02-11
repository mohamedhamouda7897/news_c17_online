import 'package:injectable/injectable.dart';
import 'package:news_c17_online/core/cache_helper.dart';
import 'package:news_c17_online/core/internet_checker.dart';
import 'package:news_c17_online/models/news_response.dart';
import 'package:news_c17_online/models/sources_reponse.dart';
import 'package:news_c17_online/screens/repository/local/home_local_repo.dart';
import 'package:news_c17_online/screens/repository/remote/home_repo.dart';

@Injectable(as: HomeLocalRepo)
class HomeRepoLocalImpl extends HomeLocalRepo {
  @override
  Future<NewsResponse> getNews(String sourceId) async {
    var data = await CacheHelper.getNewsResponse(sourceId);
    return data ?? NewsResponse();
  }

  @override
  Future<SourcesResponse> getSources(String categoryId) async {
    var response = await CacheHelper.getSourceResponse(categoryId);
    return response ?? SourcesResponse();
  }
}
