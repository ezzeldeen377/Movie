// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie/features/browse/presentation/widgets/CategoryPhoto.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';

enum BrowseStatus { initial, loading, loaded, error,paginationLoading }

extension BrowseStateExtension on BrowseState {
  bool get isLoading => status == BrowseStatus.loading;
  bool get isError => status == BrowseStatus.error;
  bool get isLoaded => status == BrowseStatus.loaded;
  bool get isInitial => status == BrowseStatus.initial;
  bool get isPaginationLoading => status == BrowseStatus.paginationLoading;

}
class BrowseState {
  final BrowseStatus status;
  final List<Category>? categories;
  final String? errorMessage;
  final List<Movie>? movies;

  BrowseState({
    required this.status,
    this.categories,
    this.errorMessage,
    this.movies
  });

  

  BrowseState copyWith({
    BrowseStatus? status,
    List<Category>? categories,
    String? errorMessage,
    List<Movie>? movies
  }) {
    return BrowseState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
      movies: movies ?? this.movies
    );
  }
  
  @override
  String toString() {
    return 'BrowseState(status: $status, categories: $categories, errorMessage: $errorMessage ,movies: $movies)';
  }
}
