import 'package:movie/pages/home_screen/model/movie_response.dart';

abstract class MovieRepositoryContract{


Future<MovieResponse?>getMovies(int id,int pageNumber,String appLanguage);


}