import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/movieDetails.dart';
import '../model/movie_response.dart';
import 'api_constant.dart';

class ApiManager {
  /*
    https://api.themoviedb.org/3/movie/popular?language=en-US&page=1
   */
  static Future<MovieResponse?> getPopular() async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.popularApi, {
      'language': 'en-US',
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

  /*
  https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1
   */

  static Future<MovieResponse?> getNewsReleases() async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.upcomingApi, {
      'api_key': '8ad9e9ba188516e715696297859dfd0f',
      'language': 'en-US',
      'page': '1',
    });
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return MovieResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load releases movies:${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }

  /*
  https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1
   */

  static Future<MovieResponse?> getRecommended() async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.topRatedApi, {
      'api_key': '8ad9e9ba188516e715696297859dfd0f',
      'language': 'en-US',
      'page': '1',
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

  static Future<MovieDetails?> getMovieDetails(String movieId) async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.detailsApi + movieId, {
      'api_key': '8ad9e9ba188516e715696297859dfd0f',
      'language': 'en-US',
      'page': '1',
    });

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return MovieDetails.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load movie details: ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }

  /*
  https://api.themoviedb.org/3/movie/{movie_id}/similar
   */

  static Future<MovieResponse?> getMoreLikeThis(String id) async {
    Uri url = Uri.https(ApiConstant.baseUrl,
        ApiConstant.moreLikeApi + id + ApiConstant.similar, {
      'api_key': '8ad9e9ba188516e715696297859dfd0f',
      'language': 'en-US',
      'page': '1',
    });

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.statusCode);
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
