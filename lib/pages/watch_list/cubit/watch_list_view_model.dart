
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_navigetor.dart';

import 'package:movie/pages/home_screen/model/movie_response.dart';


class WatchListViewModel extends Cubit<MoviesState>{
  WatchListViewModel():super(LoadingState());

  late WatchListNagvigetor nagvigetor;
  void showSnakeBar(String message){
    nagvigetor.showSnakeBar(message);
  }

  Future<CollectionReference<Movie>?> getCollection() async {
    return  FirebaseFirestore.instance.collection('Movies')
        .withConverter<Movie>(
        fromFirestore: (snapshot,options)=>Movie.fromJson(snapshot.data()),
        toFirestore: (movie,options)=>movie.toJson()
    );
  }

  Future<void> addMovieToFireStore(Movie movie) async {
    try {
      var collref = await getCollection();
       await collref?.doc(movie.id.toString()).set(movie);
       nagvigetor.showSnakeBar("Added Successfully");
    }catch (e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getAllMoviesFromFireStore() async {
    try {
      emit(LoadingState());
      var collref = await getCollection();
       collref?.snapshots().listen((snapshot) {
         var movieList= snapshot.docs.map((element) {
          return element.data();
        }).toList();
         emit(SuccessState(movieList: movieList));


       });
    }catch (e){
      emit(ErrorState(errorMessage: e.toString()));

    }

  }

  Future<void> removeMovieFromFireStore(Movie movie) async {
    try {
      var collref = await getCollection();
      collref?.doc(movie.id.toString()).delete();
      nagvigetor.showSnakeBar("Deleted Successfully");

    }catch (e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }



}