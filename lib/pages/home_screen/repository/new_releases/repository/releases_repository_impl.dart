import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/repository/new_releases/relases_repository.dart';
import 'package:movie/pages/home_screen/repository/new_releases/releases_data_source.dart';

class ReleasesRepositoryImpl implements ReleasesRepository {
  final ReleasesRemoteDataSource remoteDataSource;

  ReleasesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieResponse?> getNewReleases(int pageNumber,String appLanguage) async {
    return await remoteDataSource.getNewReleases(pageNumber,appLanguage);
  }
}
