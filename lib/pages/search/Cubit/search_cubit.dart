import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/search/api/api_manager.dart';
import 'search_state.dart';
import 'search_state_impl.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchStateImpl());

  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(SearchStateImpl());
      return;
    }

    emit(SearchStateImpl(isLoading: true));

    try {
      final response = await ApiManager.searchNews(query);
      emit(SearchStateImpl(
        results: response?.results ?? [],
        isLoading: false,
      ));
    } catch (e) {
      emit(SearchStateImpl(hasError: true, isLoading: false));
    }
  }
}
