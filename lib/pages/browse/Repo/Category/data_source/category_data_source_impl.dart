import 'package:movie/pages/browse/Api/Api_Manager.dart';
import 'package:movie/pages/browse/Models/CategoryResponse.dart';
import 'package:movie/pages/browse/Repo/Category/Category_data_source.dart';
import 'package:movie/pages/browse/Repo/Category/Category_repo_contract.dart';


class CategoryDataSourceImpl implements CategoryDataSource{
  ApiManager apiManager;
  CategoryDataSourceImpl({required this.apiManager});

  @override
  Future<CategoryResponse?> getCategory(String appLanguage)async {
 var response= await  apiManager.getCategory(appLanguage);
 return response;
  }


  }



  
  
  
