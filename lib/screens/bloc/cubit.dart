import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_c17_online/core/constants.dart';
import 'package:news_c17_online/models/news_response.dart';
import 'package:news_c17_online/models/sources_reponse.dart';
import 'package:news_c17_online/screens/bloc/states.dart';
import 'package:news_c17_online/screens/repository/home_repo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

//repository
// SOLID
// Differance between (Singleton & Factory & lazySingleton)
// DI
// interceptors

// Theming


@injectable
class HomeCubit extends Cubit<HomeStates> {
  HomeRepo repo;

  HomeCubit(this.repo) : super(HomeInitState());

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
      NewsResponse newsResponse = await repo.getNews(
        sources[selectedIndex].id ?? "",
      );

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
      SourcesResponse sourcesResponse = await repo.getSources(categoryId);

      sources = sourcesResponse.sources ?? [];

      emit(GetSourcesSuccessState());
      getNewsData();
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }
}
