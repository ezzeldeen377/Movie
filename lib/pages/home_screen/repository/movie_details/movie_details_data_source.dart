import '../../model/movieDetails.dart';

abstract class MovieDetailsRemoteDataSource {
  Future<MovieDetails?> getMovieDetails(String movieId);
}
