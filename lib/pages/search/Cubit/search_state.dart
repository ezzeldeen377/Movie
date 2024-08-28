
import 'package:movie/pages/home_screen/model/movie_response.dart';


abstract class SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Movie> movieResult;

  SearchLoaded({required this.movieResult});
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
