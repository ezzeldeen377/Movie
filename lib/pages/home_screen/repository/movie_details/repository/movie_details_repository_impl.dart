import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/repository/movie_details/movie_details_data_source.dart';
import 'package:movie/pages/home_screen/repository/movie_details/movie_details_repository.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsRemoteDataSource remoteDataSource;

  MovieDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieDetails?> getMovieDetails(String movieId) async {
    return await remoteDataSource.getMovieDetails(movieId);
  }
}
