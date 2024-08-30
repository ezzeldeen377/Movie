import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/repository/recommended/recommended_data_source.dart';

import '../recommended_repository.dart';

class RecommendedRepositoryImpl implements RecommendedRepository {
  final RecommendedRemoteDataSource remoteDataSource;

  RecommendedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieResponse?> getNewRecommended(int pageNumber,String appLanguage) async {
    return await remoteDataSource.getRecommended(pageNumber,appLanguage);
  }
}
