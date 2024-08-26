import 'package:movie/pages/home_screen/model/MovieVideos.dart';

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
class MovieVideoLoadingState extends MovieDetailsState {}

class MovieVideoErrorState extends MovieDetailsState {
  String errorMessage;

  MovieVideoErrorState({required this.errorMessage});
}

class MovieVideoSuccessState extends MovieDetailsState {
  List<Video> videoList;
  MovieVideoSuccessState({required this.videoList});
}
