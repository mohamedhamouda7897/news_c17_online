import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:news_c17_online/core/constants.dart';
import 'package:news_c17_online/models/news_response.dart';
import 'package:news_c17_online/models/sources_reponse.dart';
import 'package:news_c17_online/screens/bloc/states.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HomeCubit extends Cubit<HomeStates> {
  late Dio dio;

  HomeCubit() : super(HomeInitState()) {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.BASEURL,

        headers: {"x-api-key": AppConstants.APIKEY},
      ),
    );

    dio.interceptors.add(PrettyDioLogger(request: true, responseBody: true));
  }

  List<Sources> sources = [];
  List<Articles> articles = [];
  int selectedIndex = 0;

  void changeSelectedSource(int index) {
    selectedIndex = index;
    emit(OnChangeSourceTab());
    getNewsData();
  }

  Future<void> getNewsData() async {
    emit(GetNewsDataLoadingState());

    try {
      Response response = await dio.get(
        "/v2/everything?sources=${sources[selectedIndex].id}",
      );

      NewsResponse newsResponse = NewsResponse.fromJson(response.data);

      if (newsResponse.status == "error") {
        emit(GetNewsDataErrorState(newsResponse.message ?? ""));
        return;
      }

      articles = newsResponse.articles ?? [];
      emit(GetNewsDataSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetNewsDataErrorState(e.toString()));
    }
  }

  Future<void> getSources(String categoryId) async {
    emit(GetSourcesLoadingState());
    try {
      Response response = await dio.get("/v2/top-headlines/sources?category=$categoryId");

      SourcesResponse sourcesResponse = SourcesResponse.fromJson(response.data);

      sources = sourcesResponse.sources ?? [];

      emit(GetSourcesSuccessState());
      getNewsData();
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }
}
