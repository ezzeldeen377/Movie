import '../../../home_screen/model/movie_response.dart';

abstract class Online{
  Future<MovieResponse?>getMovies(int id,int pageNumber ,String appLanguage);






}