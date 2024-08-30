import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/more_like_this/cubit/more_like_this_state.dart';
import 'package:movie/pages/home_screen/movie_details/cubit/movie_details_state.dart';
import 'package:movie/pages/home_screen/repository/movie_details/data_source/movie_details_remote_data_source_impl.dart';
import 'package:movie/pages/home_screen/repository/movie_details/movie_details_data_source.dart';
import 'package:movie/pages/home_screen/repository/movie_details/movie_details_repository.dart';
import 'package:movie/pages/home_screen/repository/movie_details/repository/movie_details_repository_impl.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsState> {
  late MovieDetailsRepository movieDetailsRepository;

  late MovieDetailsRemoteDataSource remoteDataSource;

  MovieDetailsViewModel() : super(MovieDetailsLoadingState()) {
    remoteDataSource = MovieDetailsRemoteDataSourceImpl();
    movieDetailsRepository =
        MovieDetailsRepositoryImpl(remoteDataSource: remoteDataSource);
  }
  late MovieDetails movieDetails;

  Future<void> getMovieDetail(String movieId,String appLanguage) async {
    try {
      var response = await movieDetailsRepository.getMovieDetails(movieId,appLanguage);

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
   void getMovieVideos(String movieId,String appLanguage) async {
    emit(MovieVideoLoadingState());
    try{
      var response=await movieDetailsRepository.getMovieVideos(movieId,appLanguage);
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
