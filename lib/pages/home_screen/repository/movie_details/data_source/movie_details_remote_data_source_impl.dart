import 'dart:convert';

import 'package:movie/pages/home_screen/api/api_constant.dart';
import 'package:movie/pages/home_screen/model/MovieVideos.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:http/http.dart' as http;
import 'package:movie/pages/home_screen/repository/movie_details/movie_details_data_source.dart';

class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource {
  @override
  Future<MovieDetails?> getMovieDetails(String movieId,String appLanguage) async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.apiName + movieId, {
      'api_key': '8ad9e9ba188516e715696297859dfd0f',
      'language': appLanguage,
      'page': '1',
      'append_to_response': 'credits'
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

  @override
  Future<MovieVideos?> getMovieVideos(String movieId, String appLanguage)async {
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

