
import 'package:injectable/injectable.dart';
import 'package:movie/core/api/api_manager.dart';

abstract class BrowseRemoteDataSource{
 Future<Map<String,dynamic>?> getCategory(String appLanguage);
 Future<Map<String,dynamic>?>getMovies(int id,int pageNumber,String appLanguage);

}

@Injectable(as: BrowseRemoteDataSource)
class BrowseRemoteDataSourceImpl implements BrowseRemoteDataSource{
  ApiManager apiManager;
  BrowseRemoteDataSourceImpl({required this.apiManager});


  @override
  Future<Map<String, dynamic>?> getCategory(String appLanguage)async {
 var response= await  apiManager.getCategory(appLanguage);
 return response;
  }
  
  @override
  Future<Map<String, dynamic>?> getMovies(int id, int pageNumber, String appLanguage) async {
    var response= await apiManager.getMoives(id, pageNumber,appLanguage);
return response;
  }


  }