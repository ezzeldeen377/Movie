
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/search/api/api_manager.dart';
import 'package:movie/pages/search/model/SourcesMovie.dart';

class SearchState {
  final List<Results> results;
  final bool isLoading;
  final bool hasError;

  SearchState({
    this.results = const [],
    this.isLoading = false,
    this.hasError = false,
  });
}


abstract class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;

  SearchQueryChanged(this.query);
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());

  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(SearchState());
      return;
    }

    emit(SearchState(isLoading: true));

    try {
      final response = await ApiManager.searchNews(query);
      emit(SearchState(
        results: response?.results ?? [],
        isLoading: false,
      ));
    } catch (e) {
      emit(SearchState(hasError: true, isLoading: false));
    }
  }
}
