import 'package:movie/pages/browse/Api/Api_Manager.dart';
import 'package:movie/pages/browse/Repo/Movie/Movie_data_Source.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';



class MovieRemoteDataSourceImpl implements Online{
  ApiManager apiManager ;
MovieRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<MovieResponse?> getMovies(int id,int pageNumber ,String appLanguage) async{
    var response= await apiManager.getMoives(id, pageNumber,appLanguage);
return response;
  }





}