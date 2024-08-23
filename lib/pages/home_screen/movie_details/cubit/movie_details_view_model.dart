import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/more_like_this/cubit/more_like_this_state.dart';

import 'movie_details_state.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsState> {
  MovieDetailsViewModel() : super(MovieDetailsLoadingState());

  void getMovieDetail(String id) async {
    try {
      emit(MovieDetailsLoadingState());

      var response = await ApiManager.getMovieDetails(id);

      if (response == null ||
          response.title == null ||
          response.title!.isEmpty) {
        emit(MovieDetailsErrorState(errorMessage: 'Empty data'));
      } else {
        emit(MovieDetailsSuccessState(movieDetail: response));
      }
    } catch (e) {
      emit(MovieDetailsErrorState(errorMessage: e.toString()));
    }
  }
}
