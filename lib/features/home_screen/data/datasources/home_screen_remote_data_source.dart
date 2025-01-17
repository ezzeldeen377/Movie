import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:movie/core/api/api_constants.dart';

abstract class HomeScreenRemoteDataSource {
  Future<Map<String, dynamic>?> getNewReleases(
      int pageNumber, String appLanguage);
  Future<Map<String, dynamic>?> getNewRecommended(
      int pageNumber, String appLanguage);
  Future<Map<String, dynamic>?> getMoreLike(
      String id, int pageNumber, String appLanguage);
  Future<Map<String, dynamic>?> getPopular(String appLanguage);
  Future<Map<String, dynamic>?> getMovieDetails(
      String movieId, String appLanguage);
  Future<Map<String, dynamic>?> getMovieVideos(
      String movieId, String appLanguage);
}

@Injectable(as: HomeScreenRemoteDataSource)
class HomeScreenRemoteDataSourceImpl implements HomeScreenRemoteDataSource {
  @override
  Future<Map<String, dynamic>?> getNewRecommended(
      int pageNumber, String appLanguage) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.topRatedApi, {
      'api_key': '8ad9e9ba188516e715696297859dfd0f',
      'language': appLanguage,
      'page': pageNumber.toString(),
    });
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception(
            'Failed to load recommended movies:${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getNewReleases(
      int pageNumber, String appLanguage) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.upcomingApi, {
      'api_key': '8ad9e9ba188516e715696297859dfd0f',
      'language': appLanguage,
      'page': pageNumber.toString(),
    });
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to load releases movies:${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getPopular(String appLanguage) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.popularApi, {
      'language': appLanguage,
      'page': '1',
      'api_key': '8ad9e9ba188516e715696297859dfd0f'
    });

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to load popular movies: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
   @override
  Future<Map<String,dynamic>?> getMovieDetails(String movieId,String appLanguage) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.apiName + movieId, {
      'api_key': '8ad9e9ba188516e715696297859dfd0f',
      'language': appLanguage,
      'page': '1',
      'append_to_response': 'credits'
    });

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load movie details: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String,dynamic>?> getMovieVideos(String movieId, String appLanguage)async {
    Uri url =Uri.https(ApiConstants.baseUrl,ApiConstants.apiName+movieId+ApiConstants.video,{
      'api_key': '8ad9e9ba188516e715696297859dfd0f',
      'language': 'en-US',
    });
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }else {
        throw Exception(
            'Failed to load Videos : ${response.statusCode}');
      }
    }catch(e){
      rethrow;
    }
  }
  @override
  Future<Map<String ,dynamic>?> getMoreLike(String id, int pageNumber,String appLanguage) async {
    Uri url = Uri.https(
        ApiConstants.baseUrl, ApiConstants.apiName + id + ApiConstants.similar, {
      'api_key': '8ad9e9ba188516e715696297859dfd0f',
      'language': appLanguage,
      'page': pageNumber.toString(),
    });

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to load More like this: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
