import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/features/search/data/datasources/search_Remote_data_source.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';

abstract class SearchRepository {
  Future<Either<String, MovieResponse?>> searchMovies(
      String query, String appLanguage);
}

@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, MovieResponse?>> searchMovies(
      String query, String appLanguage) async {
    try {
      final check = await Connectivity().checkConnectivity();
      if (check.contains(ConnectivityResult.wifi) ||
          check.contains(ConnectivityResult.mobile)) {
        final response =
            await remoteDataSource.searchMovies(query, appLanguage);
        return Right(MovieResponse.fromJson(response));
      } else {
        return const Left('No Internet Connection');
      }
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
