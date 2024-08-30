import 'dart:convert';

import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:http/http.dart' as http;
import 'package:movie/pages/home_screen/repository/more_like/more_like_data_source.dart';
import '../../../api/api_constant.dart';

class MoreLikeRemoteDataSourceImpl implements MoreLikeRemoteDataSource {
  @override
  Future<MovieResponse?> getMoreLike(String id, int pageNumber,String appLanguage) async {
    Uri url = Uri.https(
        ApiConstant.baseUrl, ApiConstant.apiName + id + ApiConstant.similar, {
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
            'Failed to load More like this: ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }
}
