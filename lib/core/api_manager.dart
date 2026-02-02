import 'package:dio/dio.dart';
import 'package:news_c17_online/core/constants.dart';
import 'package:news_c17_online/models/news_response.dart';
import 'package:news_c17_online/models/sources_reponse.dart';

class ApiManager {
  static Dio dio = Dio();

  static Future<SourcesResponse> getSources() async {
    Response response = await dio.get(
      "${AppConstants.BASEURL}/v2/top-headlines/sources?apiKey=${AppConstants.APIKEY}",
    );

    SourcesResponse sourcesResponse = SourcesResponse.fromJson(response.data);

    return sourcesResponse;
  }

  static Future<NewsResponse> getNewsData(String sourceId) async {
    Response response = await dio.get(
      "https://newsapi.org/v2/everything?apiKey=dc3d106e730c4256b8c275d9da58d090&sources=$sourceId",
    );

    NewsResponse newsResponse = NewsResponse.fromJson(response.data);
    return newsResponse;
  }
}
