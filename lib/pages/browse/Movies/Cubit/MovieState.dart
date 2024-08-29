
import 'package:movie/pages/home_screen/model/movie_response.dart';

abstract class Moviestate {}
class LoadingMovieState extends Moviestate{}
class ErrorMovieState extends Moviestate{
  String errorMessage ;
  ErrorMovieState({required this.errorMessage});
}
class SuccessMovieState extends Moviestate{
  List<Movie> movieList;
  SuccessMovieState({required this.movieList});
}
class PaginationMovieState extends Moviestate{}