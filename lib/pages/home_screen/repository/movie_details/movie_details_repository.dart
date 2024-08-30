import 'package:movie/pages/home_screen/model/MovieVideos.dart';

import '../../model/movieDetails.dart';

abstract class MovieDetailsRepository {
  Future<MovieDetails?> getMovieDetails(String movieId,String appLanguage);
  Future<MovieVideos?> getMovieVideos(String movieId,String appLanguage);
}
