import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/search/Cubit/search_state.dart';
import 'package:movie/pages/search/Repositroy/data_Source/movie_Remote_data_source_impl.dart';
import 'package:movie/pages/search/Repositroy/movie_remote_data_source.dart';
import 'package:movie/pages/search/Repositroy/movie_repository_contract.dart';
import 'package:movie/pages/search/Repositroy/repository/movie_repository_impl.dart';

class SearchViewModel extends Cubit<SearchState> {
  late MovieRepository repository;
  late MovieRemoteDataSource dataSource;


  SearchViewModel() : super(SearchError('Search On Any Movie You want')){
    dataSource = MovieRemoteDataSourceImpl();
    repository = MovieRepositoryImpl(remoteDataSource: dataSource);
  }

  void search(String query,String appLanguage) async {
    emit(SearchLoadingState());

    try {
      final response = await repository.searchMovies(query,appLanguage);
      if(response == null || response.results == null || response.results!.isEmpty) {
        emit(SearchError("No Data Found"));
      } else {
        emit(SearchLoaded(movieResult: response.results ?? []));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void clear() {
    emit(SearchError('Search On Any Movie You want'));
  }
}
