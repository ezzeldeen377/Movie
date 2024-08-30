import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';

abstract class MovieRepository {
  Future<MovieResponse?> searchMovies(String query,String appLanguage);
}
