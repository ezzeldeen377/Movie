import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movie/core/api/api_constants.dart';








// https://api.themoviedb.org/3/genre/movie/list?api_key=d17eaee37c3c16b0b2ccaee413f91589
@lazySingleton
class ApiManager{

   Future<Map<String,dynamic>?>getCategory(String appLanguage)async{

    Uri url=Uri.https(ApiConstants.baseUrl,ApiConstants.CategoryApiName,{
      "api_key":"d17eaee37c3c16b0b2ccaee413f91589",
      'language':appLanguage
    });
    var response= await http.get(url);
    try{

 var json=jsonDecode(response.body) ;
return json;

    }
    catch(e){
rethrow ;
    }




  }

   Future<Map<String,dynamic>?>getMoives(int id,int pageNumber,String appLanguage)async{
    Uri url =Uri.https(ApiConstants.baseUrl,ApiConstants.MovieApiName,{
      "api_key":ApiConstants.apiKey,
      "with_genres":id.toString(),
      'page':pageNumber.toString(),
      'language':appLanguage

    });
    var response= await http.get(url);
    try{
      var json=jsonDecode(response.body) ;
      return json;

    }
    catch(e){
      rethrow ;
    }





}

}





