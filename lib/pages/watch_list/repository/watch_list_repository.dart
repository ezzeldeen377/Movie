import 'package:movie/pages/home_screen/model/movie_response.dart';

abstract class WatchListRepository{
  Future<bool> deleteAll();
  Future<bool> removeMovie(Movie movie);
  Stream<List<Movie>> getAllMovies();
  Future<void> addMovie(Movie movie);
}