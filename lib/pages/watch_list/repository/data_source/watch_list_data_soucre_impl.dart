import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/watch_list/repository/watch_list_data_source.dart';

class WatchListDataSourceImpl implements WatchListDataSource{
  @override
  Future<void> addMovie(Movie movie) async{
    // TODO: implement addMovie

    try {
      var collRef = await getCollection();
        await collRef?.doc(movie.id.toString()).set(movie);
        
    }catch(e){
      throw e;
    }
  }

  @override
  Future<bool> deleteAll()async {
    // TODO: implement deleteAll
    try{
      var collRef=await getCollection();
      var snapshot= await collRef!.get();
      for(QueryDocumentSnapshot doc in snapshot.docs){
        doc.reference.delete();
      }
      return true;
    }catch(e){
      return false;
    }
  }

  @override
  Stream<List<Movie>> getAllMovies() async*{
    // TODO: implement getAllMovies
    try {
      var collRef = await getCollection();
      if (collRef != null) {
        yield* collRef.snapshots().map((snapshot) {
          return snapshot.docs.map((doc) => doc.data()).toList();
        });
      } else {
        throw Exception("Collection reference is null");
      }


    }catch(e){
      throw e;
      }
  }



  @override
  Future<bool> removeMovie(Movie movie)async {
    // TODO: implement removeMovie
    try {
      var collref = await getCollection();
      collref?.doc(movie.id.toString()).delete();
      return true;
    }catch(e){
      return false;
    }
  }

  @override
  Future<CollectionReference<Movie>?> getCollection() async{
    // TODO: implement getCollection
     return FirebaseFirestore.instance.collection('Movies')
        .withConverter<Movie>(
        fromFirestore: (snapshot,options)=>Movie.fromJson(snapshot.data()),
        toFirestore: (movie,options)=>movie.toJson()
    );
  }

}