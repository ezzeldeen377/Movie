import '../../model/movieDetails.dart';

abstract class MovieDetailsRepository {
  Future<MovieDetails?> getMovieDetails(String movieId);
}
