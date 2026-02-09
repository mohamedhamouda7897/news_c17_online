import 'package:dio/dio.dart';
import 'package:news_c17_online/core/constants.dart';
import 'package:news_c17_online/models/news_response.dart';
import 'package:news_c17_online/models/sources_reponse.dart';
import 'package:news_c17_online/screens/repository/home_repo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HomeRepoRemote extends HomeRepo {
  late Dio dio;
  HomeRepoRemote(){
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.BASEURL,

        headers: {"x-api-key": AppConstants.APIKEY},
      ),
    );

    dio.interceptors.add(PrettyDioLogger(request: true, responseBody: true));

  }
  @override
  Future<NewsResponse> getNews(String sourceId) async{
    try {
      Response response = await dio.get(
        "/v2/everything?sources=${sourceId}",
      );

      NewsResponse newsResponse = NewsResponse.fromJson(response.data);

      return newsResponse;
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  @override
  Future<SourcesResponse> getSources(String categoryId) async {
    try {
      Response response = await dio.get(
        "/v2/top-headlines/sources?category=$categoryId",
      );

      SourcesResponse sourcesResponse = SourcesResponse.fromJson(response.data);

      return sourcesResponse;
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }
}
