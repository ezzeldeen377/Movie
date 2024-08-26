import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/pages/search/api/api_constants.dart';
import 'package:movie/pages/search/model/SourcesMovie.dart';

class ApiManager {
  static Future<SourcesMovie?> searchNews(String query) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.sourcesApi, {
      'api_key': '2a19eceea3e415eb6ad14cea7d393928',
      'query': query,
    });

    try {
      var response = await http.get(url);
      print('Search Response status: ${response.statusCode}');
      print('Search Response body: ${response.body}');
      if (response.statusCode == 200) {
        return SourcesMovie.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      print('Error fetching search results: $e');
      throw e;
    }
  }
}
