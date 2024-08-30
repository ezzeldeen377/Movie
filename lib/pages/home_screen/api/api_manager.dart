import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie/pages/home_screen/model/MovieVideos.dart';

import '../model/movieDetails.dart';
import '../model/movie_response.dart';
import 'api_constant.dart';

class ApiManager {
  /*
    https://api.themoviedb.org/3/movie/popular?language=en-US&page=1
   */
  // static Future<MovieResponse?> getPopular() async {
  //   Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.popularApi, {
  //     'language': 'en-US',
  //     'page': '1',
  //     'api_key': '8ad9e9ba188516e715696297859dfd0f'
  //   });
  //
  //   try {
  //     var response = await http.get(url);
  //
  //     if (response.statusCode == 200) {
  //       var responseBody = response.body;
  //       var json = jsonDecode(responseBody);
  //       return MovieResponse.fromJson(json);
  //     } else {
  //       // Throwing an exception for non-200 responses
  //       throw Exception(
  //           'Failed to load popular movies: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Logging the error or providing more details can be helpful for debugging
  //     print('Error occurred: $e');
  //     throw e;
  //   }
  // }

  /*
  https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1
   */

  // static Future<MovieResponse?> getNewReleases(int pageNumber) async {
  //   Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.upcomingApi, {
  //     'api_key': '8ad9e9ba188516e715696297859dfd0f',
  //     'language': 'en-US',
  //     'page': pageNumber.toString(),
  //   });
  //   try {
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       return MovieResponse.fromJson(jsonDecode(response.body));
  //     } else {
  //       throw Exception(
  //           'Failed to load releases movies:${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  /*
  https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1
   */

  // static Future<MovieResponse?> getRecommended(int pageNumber) async {
  //   Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.topRatedApi, {
  //     'api_key': '8ad9e9ba188516e715696297859dfd0f',
  //     'language': 'en-US',
  //     'page': pageNumber.toString(),
  //   });
  //   try {
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       return MovieResponse.fromJson(jsonDecode(response.body));
  //     } else {
  //       throw Exception(
  //           'Failed to load recommended movies:${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // static Future<MovieDetails?> getMovieDetails(String movieId) async {
  //   Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.apiName + movieId, {
  //     'api_key': '8ad9e9ba188516e715696297859dfd0f',
  //     'language': 'en-US',
  //     'page': '1',
  //     'append_to_response':'credits'
  //   });
  //
  //   try {
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       return MovieDetails.fromJson(jsonDecode(response.body));
  //     } else {
  //       throw Exception('Failed to load movie details: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  /*
  https://api.themoviedb.org/3/movie/{movie_id}/similar
   */

  // static Future<MovieResponse?> getMoreLikeThis(String id,int pageNumber) async {
  //   Uri url = Uri.https(ApiConstant.baseUrl,
  //       ApiConstant.apiName + id + ApiConstant.similar, {
  //     'api_key': '8ad9e9ba188516e715696297859dfd0f',
  //     'language': 'en-US',
  //     'page': pageNumber.toString(),
  //   });
  //
  //   try {
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       return MovieResponse.fromJson(jsonDecode(response.body));
  //     } else {
  //       throw Exception(
  //           'Failed to load More like this: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

/*
  https://api.themoviedb.org/3/movie/{movie_id}/videos
   */

   Future<MovieVideos?> getMovieVideos(String movieId) async {
    Uri url =Uri.https(ApiConstant.baseUrl,ApiConstant.apiName+movieId+ApiConstant.video,{
      'api_key': '8ad9e9ba188516e715696297859dfd0f',
      'language': 'en-US',
    });
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return MovieVideos.fromJson(jsonDecode(response.body));
      }else {
        throw Exception(
            'Failed to load Videos : ${response.statusCode}');
      }
    }catch(e){
        rethrow;
    }
  }

}
