import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/features/home_screen/data/datasources/home_screen_remote_data_source.dart';
import 'package:movie/features/home_screen/data/models/MovieVideos.dart';
import 'package:movie/features/home_screen/data/models/movieDetails.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';

abstract class HomeScreenRepository {
  Future<Either<String, MovieResponse?>> getNewReleases(
      int pageNumber, String appLanguage);
  Future<Either<String, MovieResponse?>> getNewRecommended(
      int pageNumber, String appLanguage);
  Future<Either<String, MovieResponse?>> getPopular(String appLanguage);
  Future<Either<String, MovieDetails?>> getMovieDetails(
      String movieId, String appLanguage);
  Future<Either<String, MovieVideos?>> getMovieVideos(
      String movieId, String appLanguage);
  Future<Either<String, MovieResponse?>> getMoreLike(
      String id, int pageNumber, String appLanguage);
}

@Injectable(as: HomeScreenRepository)
class HomeScreenRepositoryImpl extends HomeScreenRepository {
  final HomeScreenRemoteDataSource homeScreenRemoteDataSource;
  HomeScreenRepositoryImpl(this.homeScreenRemoteDataSource);
  @override
  Future<Either<String, MovieResponse>> getNewReleases(
      int pageNumber, String appLanguage) async {
    try {
      final check = await Connectivity().checkConnectivity();
      if (check.contains(ConnectivityResult.wifi) ||
          check.contains(ConnectivityResult.mobile)) {
        final result = await homeScreenRemoteDataSource.getNewReleases(
            pageNumber, appLanguage);
        return Right(MovieResponse.fromJson(result));
      } else {
        return const Left('No Internet Connection');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MovieResponse>> getNewRecommended(
      int pageNumber, String appLanguage) async {
    try {
      final check = await Connectivity().checkConnectivity();
      if (check.contains(ConnectivityResult.wifi) ||
          check.contains(ConnectivityResult.mobile)) {
        final result = await homeScreenRemoteDataSource.getNewRecommended(
            pageNumber, appLanguage);
        return Right(MovieResponse.fromJson(result));
      } else {
        return const Left('No Internet Connection');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MovieResponse>> getPopular(String appLanguage) async {
    try {
      final check = await Connectivity().checkConnectivity();
      if (check.contains(ConnectivityResult.wifi) ||
          check.contains(ConnectivityResult.mobile)) {
        final result = await homeScreenRemoteDataSource.getPopular(appLanguage);
        return Right(MovieResponse.fromJson(result));
      } else {
        return const Left('No Internet Connection');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MovieResponse?>> getMoreLike(
      String id, int pageNumber, String appLanguage) async {
    try {
      final check = await Connectivity().checkConnectivity();
      if (check.contains(ConnectivityResult.wifi) ||
          check.contains(ConnectivityResult.mobile)) {
        final result = await homeScreenRemoteDataSource.getMoreLike(
            id, pageNumber, appLanguage);
        return Right(MovieResponse.fromJson(result));
      } else {
        return const Left('No Internet Connection');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MovieDetails?>> getMovieDetails(
      String movieId, String appLanguage) async {
    try {
      final check = await Connectivity().checkConnectivity();
      if (check.contains(ConnectivityResult.wifi) ||
          check.contains(ConnectivityResult.mobile)) {
        final result = await homeScreenRemoteDataSource.getMovieDetails(
            movieId, appLanguage);
        return Right(MovieDetails.fromJson(result));
      } else {
        return const Left('No Internet Connection');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MovieVideos?>> getMovieVideos(
      String movieId, String appLanguage) async {
    try {
      final check = await Connectivity().checkConnectivity();
      if (check.contains(ConnectivityResult.wifi) ||
          check.contains(ConnectivityResult.mobile)) {
        final result = await homeScreenRemoteDataSource.getMovieVideos(
            movieId, appLanguage);
        return Right(MovieVideos.fromJson(result));
      } else {
        return const Left('No Internet Connection');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
