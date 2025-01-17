import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/features/browse/data/datasources/browse_remote_data_source.dart';
import 'package:movie/features/browse/data/models/category_response.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';

abstract class BrowseRepository{
Future<Either<String, CategoryResponse?>>getCategory(String appLanguage);
Future<Either<String, MovieResponse?>>getMovies(int id,int pageNumber,String appLanguage);

}
@Injectable(as:BrowseRepository)
class BrowseRepositoryImpl implements BrowseRepository{
  BrowseRemoteDataSource remote;
  BrowseRepositoryImpl({required this.remote});
  @override
  Future<Either<String, CategoryResponse?>> getCategory(String appLanguage) async {
    try {
  final check= await Connectivity().checkConnectivity();
   if (check.contains(ConnectivityResult.wifi)||check.contains(ConnectivityResult.mobile)) {
    final result= await  remote.getCategory(appLanguage);
    return Right(CategoryResponse.fromJson(result));
  }else{
    return const Left('No Internet Connection');
  }
} on Exception catch (e) {
  return Left(e.toString());}
  }
  
  @override
  Future<Either<String, MovieResponse?>> getMovies(int id, int pageNumber, String appLanguage) async {
      try {
  final check= await Connectivity().checkConnectivity();
   if (check.contains(ConnectivityResult.wifi)||check.contains(ConnectivityResult.mobile)) {
    final result= await  remote.getMovies(id, pageNumber,appLanguage);
    return Right(MovieResponse.fromJson(result));
  }else{
    return const Left('No Internet Connection');
  }
} on Exception catch (e) {
  return Left(e.toString());}
  }



}