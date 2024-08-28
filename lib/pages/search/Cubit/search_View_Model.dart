
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/search/Cubit/search_state.dart';
import 'package:movie/pages/search/api/api_manager.dart';
import 'package:movie/pages/search/model/SourcesMovie.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';



class SearchViewModel extends Cubit<SearchState> {
  SearchViewModel():super(SearchError('Search On Any Movie'));

  Future<void> search(String query) async {


    emit(SearchLoadingState());

    try {
      final response = await ApiManager.searchMovies(query);
      if(response==null||response.results==null||response.results!.isEmpty) {
        emit(SearchError("No Data Found"));
      }else {
        emit(SearchLoaded(movieResult: response.results??[]));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}


