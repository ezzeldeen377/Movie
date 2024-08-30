
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/movie_details/cubit/movie_details_view_model.dart';
import 'package:movie/pages/search/Cubit/search_state.dart';
import 'package:movie/pages/search/api/api_manager.dart';
import 'package:movie/pages/search/model/SourcesMovie.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SearchViewModel extends Cubit<SearchState> {
  SearchViewModel():super(SearchError('Search On Any Movie'));
  MovieDetailsViewModel detailsViewModel=MovieDetailsViewModel();

  Future<MovieDetails> getMovieDetails(String id) async {
   await detailsViewModel.getMovieDetail(id);
   return detailsViewModel.movieDetails;
  }

  void search(String query) async {


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


