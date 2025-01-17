// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie/features/home_screen/data/models/movie_response.dart';

enum HomeScreenStatus {
  initial,
  loading,
  popularLoaded,
  newReleasesLoaded,
  recommendedLoaded,
  error,
  newReleasesPagination,
  recommendedPagination,
}

extension HomeScreenStateExtension on HomeScreenState {
  bool get isLoading => status == HomeScreenStatus.loading;
  bool get isError => status == HomeScreenStatus.error;
  bool get isPopularLoaded => status == HomeScreenStatus.popularLoaded;
  bool get isNewReleasesLoaded => status == HomeScreenStatus.newReleasesLoaded;
  bool get isRecommendedLoaded => status == HomeScreenStatus.recommendedLoaded;
  bool get isInitial => status == HomeScreenStatus.initial;
  bool get isNewReleasesPagination => status == HomeScreenStatus.newReleasesPagination;
  bool get isRecommendedPagination => status == HomeScreenStatus.recommendedPagination;
}

class HomeScreenState {
  final HomeScreenStatus status;
  final String? errorMessage;
  final List<Movie>? popularMovies;
    final List<Movie>? newReleasesMovies;
   final  List<Movie>? recommendedMovies;

  HomeScreenState({
    this.status = HomeScreenStatus.initial,
    this.errorMessage,
    this.popularMovies,
    this.newReleasesMovies,
    this.recommendedMovies,
  });
  bool  get isAllLoaded =>popularMovies!=null&& newReleasesMovies!=null&& recommendedMovies!=null;
  HomeScreenState copyWith({
    HomeScreenStatus? status,
    String? errorMessage,
    List<Movie>? popularMovies,
    List<Movie>? newReleasesMovies,
    List<Movie>? recommendedMovies,
  }) {
    return HomeScreenState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      popularMovies: popularMovies ?? this.popularMovies,
      newReleasesMovies: newReleasesMovies ?? this.newReleasesMovies,
      recommendedMovies: recommendedMovies ?? this.recommendedMovies,
    );
  }

  @override
  String toString() {
    return 'HomeScreenState(status: $status, errorMessage: $errorMessage, popularMovies: $popularMovies, newReleasesMovies: $newReleasesMovies, recommendedMovies: $recommendedMovies)';
  }
}
