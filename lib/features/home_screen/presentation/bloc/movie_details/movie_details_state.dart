// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie/features/home_screen/data/models/MovieVideos.dart';
import 'package:movie/features/home_screen/data/models/movieDetails.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';

enum MovieDetailsStatus {
  initial,
  loading,
  loaded,
  error,
  videoLoaded,
  pagination
}

extension MovieDetailsStateExtension on MovieDetailsState {
  bool get isLoading => status == MovieDetailsStatus.loading;
  bool get isError => status == MovieDetailsStatus.error;
  bool get isLoaded => status == MovieDetailsStatus.loaded;
  bool get isInitial => status == MovieDetailsStatus.initial;
  bool get isVideoLoaded => status == MovieDetailsStatus.videoLoaded;
  bool get isPagination => status == MovieDetailsStatus.pagination;
}

class MovieDetailsState {
  final MovieDetailsStatus status;
  final MovieDetails? movieDetail;
  final List<Video>? videos;
  final String? errorMessage;
  final List<Movie>? movieList;
  bool get isAllDataLoaded =>
      movieDetail != null && videos != null && movieList != null;
  const MovieDetailsState({
    required this.status,
    this.movieDetail,
    this.videos,
    this.errorMessage,
    this.movieList,
  });

  MovieDetailsState copyWith({
    MovieDetailsStatus? status,
    MovieDetails? movieDetail,
    List<Video>? videos,
    String? errorMessage,
    List<Movie>? movieList,
  }) {
    return MovieDetailsState(
      status: status ?? this.status,
      movieDetail: movieDetail ?? this.movieDetail,
      videos: videos ?? this.videos,
      errorMessage: errorMessage ?? this.errorMessage,
      movieList: movieList ?? this.movieList,
    );
  }

  @override
  String toString() {
    return 'MovieDetailsState(status: $status, errorMessage: $errorMessage)';
  }
}
