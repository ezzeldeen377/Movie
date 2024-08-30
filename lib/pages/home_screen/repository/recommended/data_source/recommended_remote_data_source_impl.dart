import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie/pages/home_screen/model/movie_response.dart';

import '../../../api/api_constant.dart';
import '../recommended_data_source.dart';

class RecommendedRemoteDataSourceImpl implements RecommendedRemoteDataSource {
  @override
  Future<MovieResponse?> getRecommended(int pageNumber,String appLanguage) async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.topRatedApi, {
      'api_key': '8ad9e9ba188516e715696297859dfd0f',
      'language': appLanguage,
      'page': pageNumber.toString(),
    });
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return MovieResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load recommended movies:${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }
}
