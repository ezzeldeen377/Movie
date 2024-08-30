import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/watch_list/repository/watch_list_data_source.dart';
import 'package:movie/pages/watch_list/repository/watch_list_repository.dart';

class WatchListRepositoryImpl implements WatchListRepository{
  WatchListDataSource dataSource;
  WatchListRepositoryImpl({required this.dataSource});
  Future<bool> deleteAll()async {
    var response= await dataSource.deleteAll();
    return response;

  }
  Future<bool> removeMovie(Movie movie) async {
    var response=await dataSource.removeMovie(movie);
    return response;
  }
  Stream<List<Movie>> getAllMovies() async*{
    var response=await dataSource.getAllMovies();
    yield* response;

  }
  Future<void> addMovie(Movie movie) async {
    var response=await dataSource.addMovie(movie);
    return response;
  }
}