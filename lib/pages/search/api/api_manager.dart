// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:movie/pages/home_screen/api/api_constant.dart';
// import 'package:movie/pages/home_screen/model/movieDetails.dart';
// import 'package:movie/pages/home_screen/model/movie_response.dart';
// import 'package:movie/pages/search/api/api_constants.dart';
// import 'package:movie/pages/search/model/SourcesMovie.dart';
//
// class ApiManager {
//   static Future<MovieResponse?> searchMovies(String query) async {
//     Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.sourcesApi, {
//       'api_key': '2a19eceea3e415eb6ad14cea7d393928',
//       'query': query,
//     });
//
//     try {
//       var response = await http.get(url);
//       print('Search Response status: ${response.statusCode}');
//       print('Search Response body: ${response.body}');
//       if (response.statusCode == 200) {
//         return MovieResponse.fromJson(jsonDecode(response.body));
//       } else {
//         throw Exception('Failed to load search results');
//       }
//     } catch (e) {
//       print('Error fetching search results: $e');
//       throw e;
//     }
//   }
//   static Future<MovieDetails?> getMovieDetails(String movieId) async {
//     Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.apiName + movieId, {
//       'api_key': '8ad9e9ba188516e715696297859dfd0f',
//       'language': 'en-US',
//       'page': '1',
//       'append_to_response':'credits'
//     });
//
//     try {
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         return MovieDetails.fromJson(jsonDecode(response.body));
//       } else {
//         throw Exception('Failed to load movie details: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw e;
//     }
//   }
// }
