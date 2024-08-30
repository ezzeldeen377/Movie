import 'package:movie/pages/home_screen/model/movie_response.dart';

abstract class RecommendedRepository {
  Future<MovieResponse?> getNewRecommended(int pageNumber,String appLanguage);
}
