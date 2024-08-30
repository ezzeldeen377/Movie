import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/more_like_this/cubit/more_like_this_state.dart';
import 'package:movie/pages/home_screen/movie_details/cubit/movie_details_state.dart';


class MovieDetailsViewModel extends Cubit<MovieDetailsState> {
  MovieDetailsViewModel() : super(MovieDetailsLoadingState());
  late MovieDetails movieDetails;
  Future<void> getMovieDetail(String id) async {
    try {

      var response = await ApiManager.getMovieDetails(id);

      if (response == null ||
          response.title == null ||
          response.title!.isEmpty) {
        emit(MovieDetailsErrorState(errorMessage: 'Empty data'));
      } else {
        movieDetails=response;
        emit(MovieDetailsSuccessState(movieDetail: response));
      }
    } catch (e) {
      emit(MovieDetailsErrorState(errorMessage: e.toString()));
    }
  }
   void getMovieVideos(String movieId) async {
    emit(MovieVideoLoadingState());
    try{
      var response=await ApiManager.getMovieVideos(movieId);
      if(response==null||response.results==null||response.results!.isEmpty){
        print("111111111111111");
        emit(MovieVideoErrorState(errorMessage:'no Data Found'));
      }else {
        print("22222222222");
        emit(MovieVideoSuccessState(videoList: response.results!));

      }

    }catch(e){
      emit(MovieVideoErrorState(errorMessage: e.toString()));
    }
  }
}
