import '../../model/movieDetails.dart';

abstract class MovieDetailsState {}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsErrorState extends MovieDetailsState {
  String errorMessage;

  MovieDetailsErrorState({required this.errorMessage});
}

class MovieDetailsSuccessState extends MovieDetailsState {
  MovieDetails movieDetail;

  MovieDetailsSuccessState({required this.movieDetail});
}
