import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie/pages/browse/Api/Api_Constants.dart';
import 'package:movie/pages/browse/Models/MovieResponse.dart';



import '../Models/CategoryResponse.dart';






// https://api.themoviedb.org/3/genre/movie/list?api_key=d17eaee37c3c16b0b2ccaee413f91589
class ApiManager{

  static Future<CategoryResponse>getCategory()async{

    Uri url=Uri.https(ApiConstants.baseUrl,ApiConstants.CategoryApiName,{
      "api_key":"d17eaee37c3c16b0b2ccaee413f91589",
    });
    var response= await http.get(url);
    try{

 var json=jsonDecode(response.body) ;
return CategoryResponse.fromJson(json);

    }
    catch(e){
rethrow ;
    }




  }

static Future<MovieResponse?>getMoives(int id)async{
    Uri url =Uri.https(ApiConstants.baseUrl,ApiConstants.MovieApiName,{
      "api_key":ApiConstants.apiKey,
      "with_genres":id.toString()

    });
    var response= await http.get(url);
    try{

      var json=jsonDecode(response.body) ;
      return MovieResponse.fromJson(json);

    }
    catch(e){
      rethrow ;
    }





}

}





