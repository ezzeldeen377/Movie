import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/features/watch_list/presentation/bloc/movies_state.dart';

import 'package:movie/features/home_screen/data/models/movie_response.dart';
import 'package:movie/features/watch_list/data/repositories/watch_list_repository.dart';
@injectable
class WatchListViewModel extends Cubit<WatchListState> {
   WatchListRepository repository;
  WatchListViewModel({required this.repository})
      : super(WatchListState(status: WatchListStatus.initial));

  Future<void> deleteAllFromFireStore() async {
    final response = await repository.deleteAll();
    response.fold(
        (error) => emit(
            state.copyWith(status: WatchListStatus.error, errorMessage: error)),
        (r) => emit(state.copyWith(
            status: WatchListStatus.finish,
            finishMessage: "All Movies Delete Success")));
  }

  Future<void> addMovieToFireStore(Movie movie) async {
    final response = await repository.addMovie(movie);
    response.fold(
        (error) => emit(
            state.copyWith(status: WatchListStatus.error, errorMessage: error)),
        (r) => emit(state.copyWith(
            status: WatchListStatus.finish,
            finishMessage: "Added Successfully")));
    getAllMoviesFromFireStore();
  }

  Future<void> getAllMoviesFromFireStore({bool fromWatchlist = false}) async {
    if (fromWatchlist) {
      emit(state.copyWith(status: WatchListStatus.loading));
    }
    var response =  repository.getAllMovies();
    response.listen((either) {
      either.fold(
          (error) => emit(
              state.copyWith(status: WatchListStatus.error, errorMessage: error)),
          (r) => emit(state.copyWith(status: WatchListStatus.loaded, movies: r)));
    });
  }

  Future<void> removeMovieFromFireStore(Movie movie) async {
    final response = await repository.removeMovie(movie);
    response.fold(
        (error) => emit(
            state.copyWith(status: WatchListStatus.error, errorMessage: error)),
        (r) => emit(state.copyWith(
            status: WatchListStatus.finish,
            finishMessage: "Removed Successfully")));
  }
}
