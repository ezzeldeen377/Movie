import 'package:movie/pages/browse/Models/CategoryResponse.dart';
import 'package:movie/pages/browse/Models/MovieResponse.dart';

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