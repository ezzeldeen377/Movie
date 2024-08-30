import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/repository/popular/popular_data_source.dart';
import 'package:movie/pages/home_screen/repository/popular/popular_repository.dart';

class PopularRepositoryImpl implements PopularRepository {
  final PopularRemoteDataSource remoteDataSource;

  PopularRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieResponse?> getPopular(String appLanguage) async {
    return await remoteDataSource.getPopular(appLanguage);
  }
}
