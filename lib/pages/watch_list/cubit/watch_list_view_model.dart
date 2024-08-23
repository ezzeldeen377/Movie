import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_navigetor.dart';
import 'package:movie/pages/watch_list/model/MovieResponse.dart';
import 'package:http/http.dart' as http;


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
       emit(FinishState(finishMessage: 'Added Successfully'));

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
         if(movieList.isEmpty){
           emit(ErrorState(errorMessage: "No Data To Show"));
         }else {
           emit(SuccessState(movieList: movieList));
         }

       });
    }catch (e){
      emit(ErrorState(errorMessage: e.toString()));

    }

  }

  Future<void> removeMovieFromFireStore(Movie movie) async {
    try {
      var collref = await getCollection();
      collref?.doc(movie.id.toString()).delete();
      emit(FinishState(finishMessage: 'Deleted Successfully'));
    }catch (e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<MovieResponse?> getData(String id ) async {
    String baseUrl='api.themoviedb.org';
    String apiName='/3/movie/';
    String similar='/similar';
    Uri url =Uri.http(baseUrl,apiName+id+similar,{
      'api_key':'9f839cfd29a448f6565aeed621210d84'
    });
    var response= await http.get(url);
    try{
      if(response.statusCode==200){
        var movie= MovieResponse.fromJson(jsonDecode(response.body));
        print(' total result ${movie.totalResults}');
      }

    }catch (e){
      throw e ;
    }
  }

}