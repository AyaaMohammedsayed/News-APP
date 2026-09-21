import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/home/data/api_service/api_service.dart';
import 'package:news/features/home/data/models/source.dart';
import 'news_states.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<Source> sources = [];

  Future<void> getSources(String catId) async {
    emit(SourcesLoadingState());
    try {
      var response = await ApiService.getSources(catId);
      if (response.status == 'ok') {
        sources = response.sources ?? [];
        emit(SourcesSuccessState(response));
      } else {
        emit(SourcesErrorState( 'Failed to load sources'));
      }
    } catch (e) {
      emit(SourcesErrorState(e.toString()));
    }
  }

  Future<void> getNews(String sourceId) async {
    emit(NewsLoadingState());
    try {
      var response = await ApiService.getNews(sourceId);
      if (response.status == 'ok') {
        emit(NewsSuccessState(response));
      } else {
        emit(NewsErrorState( 'Failed to load news'));
      }
    } catch (e) {
      emit(NewsErrorState(e.toString()));
    }
  }
}