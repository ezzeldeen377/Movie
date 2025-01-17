import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';
import 'package:movie/features/home_screen/data/repositories/home_screen_repository.dart';
import 'package:movie/features/home_screen/presentation/bloc/movie_details/movie_details_state.dart';
@injectable
class MovieDetailsViewModel extends Cubit<MovieDetailsState> {
  final HomeScreenRepository repository;

  MovieDetailsViewModel({required this.repository})
      : super( const MovieDetailsState(status: MovieDetailsStatus.initial));

  Future<void> getMovieDetail(String movieId, String appLanguage) async {
    emit(state.copyWith(status: MovieDetailsStatus.loading));
    final response = await repository.getMovieDetails(movieId, appLanguage);
    response.fold(
        (error) => emit(state.copyWith(
            status: MovieDetailsStatus.error, errorMessage: error)),
        (movieDetails) => emit(state.copyWith(
            status: MovieDetailsStatus.loaded, movieDetail: movieDetails)));
  }

  void getMovieVideos(String movieId, String appLanguage) async {
    emit(state.copyWith(status: MovieDetailsStatus.loading));
    final response = await repository.getMovieVideos(movieId, appLanguage);
    response.fold(
        (error) => emit(state.copyWith(
            status: MovieDetailsStatus.error, errorMessage: error)),
        (movieVideos) => emit(state.copyWith(
            status: MovieDetailsStatus.videoLoaded,
            videos: movieVideos?.results ?? [])));
  }

  int pageNumber = 1;
  List<Movie> list = [];
  void getMoreLike(String id, String appLanguage,
      {bool fromPagination = false}) async {
    if (fromPagination) {
      emit(state.copyWith(status: MovieDetailsStatus.pagination));
    } else {
      emit(state.copyWith(status: MovieDetailsStatus.loading));
    }
    final response = await repository.getMoreLike(id, pageNumber, appLanguage);

    response.fold(
        (error) => emit(state.copyWith(
            status: MovieDetailsStatus.error,
            errorMessage: error)), (movieDetails) {
      if (movieDetails!.results!.isNotEmpty) {
         pageNumber++;
          list.addAll(movieDetails.results??[]);
      }
      emit(state.copyWith(
          status: MovieDetailsStatus.loaded, movieList: list));
    });
  }
}
