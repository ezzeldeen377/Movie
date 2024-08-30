
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:movie/pages/watch_list/cubit/movies_state.dart';

import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/watch_list/repository/data_source/watch_list_data_soucre_impl.dart';
import 'package:movie/pages/watch_list/repository/watch_list_data_source.dart';
import 'package:movie/pages/watch_list/repository/watch_list_repository.dart';
import 'package:movie/pages/watch_list/repository/repository/watch_list_repository_impl.dart';


class WatchListViewModel extends Cubit<MoviesState>{
  late WatchListRepository repository;
  late WatchListDataSource dataSource;
  WatchListViewModel():super(LoadingState()){
    dataSource=WatchListDataSourceImpl();
    repository=WatchListRepositoryImpl(dataSource:dataSource );
  }


  Future<void> deleteAllFromFireStore()async{
    await repository.deleteAll();
    emit(FinishState(finishMessage: "All Movies Delete Success"));
  }

  Future<void> addMovieToFireStore(Movie movie) async {
    try {
      var response=await repository.addMovie(movie);
        emit(FinishState(finishMessage: "Added Successfully"));
        getAllMoviesFromFireStore();
    }catch (e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getAllMoviesFromFireStore({bool fromWatchlist=false}) async {
    if(fromWatchlist){
      emit(LoadingState());
    }
   try{
     var response= repository.getAllMovies().listen((movieList){
       emit(SuccessState(movieList: movieList));
     });
   }catch(e){
      emit(ErrorState(errorMessage:e.toString()));
   }
  }

  Future<void> removeMovieFromFireStore(Movie movie) async {
    try {
      bool response =await repository.removeMovie(movie);
      if(response) {
        emit(FinishState(finishMessage: "Deleted Successfully"));
        getAllMoviesFromFireStore();
      }else{
        emit(ErrorState(errorMessage: 'Something went wrong '));
      }
    }catch (e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }



}