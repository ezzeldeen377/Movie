import 'package:movie/pages/search/model/SourcesMovie.dart';

abstract class SearchState {
  List<Results> get results;
  bool get isLoading;
  bool get hasError;
}

abstract class SearchEvent {}
