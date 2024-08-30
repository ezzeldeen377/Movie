import 'package:movie/pages/browse/Api/Api_Manager.dart';
import 'package:movie/pages/browse/Repo/Movie/Repository/Movie_data_Source.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';



class MovieRemoteDataSourceImpl implements Online{
  ApiManager apiManager ;
MovieRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<MovieResponse?> getMovies(int id,int pageNumber ) async{
    var response= await apiManager.getMoives(id, pageNumber);
return response;
  }





}