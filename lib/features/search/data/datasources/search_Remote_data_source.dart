import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movie/core/api/api_constants.dart';
abstract class SearchRemoteDataSource {
  Future<Map<String,dynamic>?> searchMovies(String query,String appLanguage);
}
@Injectable(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  @override
  Future<Map<String,dynamic>?> searchMovies(String query,String appLanguage) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.sourcesApi, {
      'api_key': '2a19eceea3e415eb6ad14cea7d393928',
      'query': query,
      'language':appLanguage
    });

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body) ;
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      throw e;
    }
  }
}
