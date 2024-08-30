import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/repository/more_like/more_like_data_source.dart';
import 'package:movie/pages/home_screen/repository/more_like/more_like_repository.dart';

class MoreLikeRepositoryImpl implements MoreLikeRepository {
  final MoreLikeRemoteDataSource remoteDataSource;

  MoreLikeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieResponse?> getMoreLike(String id, int pageNumber,String appLanguage) async {
    return await remoteDataSource.getMoreLike(id, pageNumber,appLanguage);
  }
}
