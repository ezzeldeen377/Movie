import '../../model/MovieVideos.dart';
import '../../model/movieDetails.dart';

abstract class MovieDetailsRemoteDataSource {
  Future<MovieDetails?> getMovieDetails(String movieId,String appLanguage);
  Future<MovieVideos?> getMovieVideos(String movieId,String appLanguage);

}
