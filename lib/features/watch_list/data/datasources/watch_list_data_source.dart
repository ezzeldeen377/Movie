import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';

abstract class WatchListDataSource {
  Future<Unit> deleteAll();
  Future<Unit> removeMovie(Movie movie);
  Stream<List<Map<String, dynamic>?>> getAllMovies();
  Future<Unit> addMovie(Movie movie);
}

@Injectable(as: WatchListDataSource)
class WatchListDataSourceImpl implements WatchListDataSource {
  final firebase = FirebaseFirestore.instance;

  CollectionReference get watchListCollection => firebase.collection('Movies');
  @override
  Future<Unit> addMovie(Movie movie) async {
    try {
      await watchListCollection
          .doc(movie.id.toString())
          .set(movie.toJson(), SetOptions(merge: true));
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> deleteAll() async {
    try {
      var snapshot = await watchListCollection.get(const GetOptions(source: Source.cache));
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<Map<String, dynamic>?>> getAllMovies() async* {
    try {
       yield* watchListCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>?).toList();
    });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> removeMovie(Movie movie) async {
    try {
      watchListCollection.doc(movie.id.toString()).delete();
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }
}
