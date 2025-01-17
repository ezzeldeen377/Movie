// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie/features/home_screen/data/models/movie_response.dart';

enum WatchListStatus { initial, loading, loaded, error, finish }
extension WatchListStateExtension on WatchListState {
  bool get isLoading => status == WatchListStatus.loading;
  bool get isError => status == WatchListStatus.error;
  bool get isLoaded => status == WatchListStatus.loaded;
  bool get isInitial => status == WatchListStatus.initial;
  bool get isFinish => status == WatchListStatus.finish;
}

class WatchListState {
  final WatchListStatus status;
  final List<Movie>? movies;
  final String? errorMessage;
  final String? finishMessage;

  WatchListState({
    required this.status,
    this.movies,
    this.errorMessage,
    this.finishMessage,
  });


 

  WatchListState copyWith({
    WatchListStatus? status,
    List<Movie>? movies,
    String? errorMessage,
    String? finishMessage,
  }) {
    return WatchListState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      errorMessage: errorMessage ?? this.errorMessage,
      finishMessage: finishMessage ?? this.finishMessage,
    );
  }

  @override
  String toString() {
    return 'WatchListState(status: $status, movies: $movies, errorMessage: $errorMessage, finishMessage: $finishMessage)';
  }
}
