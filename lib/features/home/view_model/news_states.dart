import 'package:news/features/home/data/models/news_response.dart';
import 'package:news/features/home/data/models/sources_response.dart';

abstract class NewsState {}


class NewsInitialState extends NewsState {}


class SourcesLoadingState extends NewsState {}

class SourcesSuccessState extends NewsState {
  final SourcesResponse sourcesResponse;
  SourcesSuccessState(this.sourcesResponse);
}

class SourcesErrorState extends NewsState {
  final String errorMessage;
  SourcesErrorState(this.errorMessage);
}

class NewsLoadingState extends NewsState {}

class NewsSuccessState extends NewsState {
  final NewsResponse newsResponse;
  NewsSuccessState(this.newsResponse);
}

class NewsErrorState extends NewsState {
  final String errorMessage;
  NewsErrorState(this.errorMessage);
}