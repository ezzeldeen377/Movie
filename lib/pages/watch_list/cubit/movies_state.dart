
import 'package:movie/pages/watch_list/model/MovieResponse.dart';

abstract class MoviesState {}
class LoadingState extends MoviesState{}
class ErrorState extends MoviesState{
  String errorMessage;
  ErrorState({required this.errorMessage});
}
class FinishState extends MoviesState{
  String finishMessage;
  FinishState({required this.finishMessage});
}
class SuccessState extends MoviesState{
  List<Movie> movieList;
  SuccessState({required this.movieList});
}