

import 'package:movie/pages/search/model/SourcesMovie.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Results> results;

  SearchLoaded(this.results);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
