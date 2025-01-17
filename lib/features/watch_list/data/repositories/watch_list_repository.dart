import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/features/watch_list/data/datasources/watch_list_data_source.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';

abstract class WatchListRepository {
  Future<Either<String, Unit>> deleteAll();
  Future<Either<String, Unit>> removeMovie(Movie movie);
  Stream<Either<String, List<Movie>>> getAllMovies();
  Future<Either<String, Unit>> addMovie(Movie movie);
}

@Injectable(as: WatchListRepository)
class WatchListRepositoryImpl implements WatchListRepository {
  WatchListDataSource dataSource;
  WatchListRepositoryImpl({required this.dataSource});
  @override
  Future<Either<String, Unit>> deleteAll() async {
    try {
      var response = await dataSource.deleteAll();
      return Right(response);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> removeMovie(Movie movie) async {
    try {
      var response = await dataSource.removeMovie(movie);
      return Right(response);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Stream<Either<String, List<Movie>>>  getAllMovies() async* {
    try {
         var response = dataSource.getAllMovies();

    // Listen to the stream and transform it
    await for (var movieList in response) {
      // Map each Map<String, dynamic>? to Movie
      List<Movie> movies = movieList
          .where((element) => element != null) // Filter out null values
          .map((element) => Movie.fromJson(element!)) // Convert to Movie
          .toList();

      // Yield the result as Right
      yield Right(movies);
    }
    } on Exception catch (e) {
      yield Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> addMovie(Movie movie) async {
    try {
      var response = await dataSource.addMovie(movie);
      return Right(response);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
