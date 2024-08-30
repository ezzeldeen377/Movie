import 'package:movie/pages/home_screen/model/movie_response.dart';

abstract class MoreLikeRemoteDataSource {
  Future<MovieResponse?> getMoreLike(String id, int pageNumber,String appLanguage);
}
