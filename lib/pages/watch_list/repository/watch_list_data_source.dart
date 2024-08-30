import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';

abstract class WatchListDataSource{
  Future<bool> deleteAll();
  Future<bool> removeMovie(Movie movie);
  Stream<List<Movie>> getAllMovies();
  Future<void> addMovie(Movie movie);
  Future<CollectionReference<Movie>?> getCollection();
}