import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie/pages/home_screen/model/movie_response.dart';

import '../../../api/api_constant.dart';
import '../popular_data_source.dart';

class PopularRemoteDataSourceImpl implements PopularRemoteDataSource {
  @override
  Future<MovieResponse?> getPopular(String appLanguage) async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.popularApi, {
      'language': appLanguage,
      'page': '1',
      'api_key': '8ad9e9ba188516e715696297859dfd0f'
    });

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseBody = response.body;
        var json = jsonDecode(responseBody);
        return MovieResponse.fromJson(json);
      } else {
        // Throwing an exception for non-200 responses
        throw Exception(
            'Failed to load popular movies: ${response.statusCode}');
      }
    } catch (e) {
      // Logging the error or providing more details can be helpful for debugging
      print('Error occurred: $e');
      throw e;
    }
  }
}
