
import 'package:movie/features/home_screen/data/models/movie_response.dart';


enum SearchStatus { initial, loading, loaded, error }
extension SearchStateExtension on SearchState {
  bool get isLoading => status == SearchStatus.loading;
  bool get isError => status == SearchStatus.error;
  bool get isLoaded => status == SearchStatus.loaded;
  bool get isInitial => status == SearchStatus.initial;
}
class SearchState {
  final SearchStatus status;
  final List<Movie> movieResult;
  final String? errorMessage;

  SearchState({
    this.status = SearchStatus.initial,
    this.movieResult = const [],
    this.errorMessage,
  });

  SearchState copyWith({
    SearchStatus? status,
    List<Movie>? movieResult,
    String? errorMessage,
  }) =>
      SearchState(
        status: status ?? this.status,
        movieResult: movieResult ?? this.movieResult,
        errorMessage: errorMessage ?? this.errorMessage,
      );
    
    @override
    String toString() {
    return 'SearchState{status: $status, movieResult: $movieResult, errorMessage: $errorMessage}';
  }
}


