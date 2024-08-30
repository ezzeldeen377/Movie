import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/browse/Api/Api_Manager.dart';
import 'package:movie/pages/browse/Category/Cubit/CategoryState.dart';
import 'package:movie/pages/browse/CategoryPhoto.dart';
import 'package:movie/pages/browse/Repo/Category/data_source/category_data_source_impl.dart';
import 'package:movie/pages/browse/Repo/Category/repo/category_repository_impl.dart';

import '../../Repo/Category/Category_data_source.dart';
import '../../Repo/Category/Category_repo_contract.dart';


class CategoryDetailsVeiwmodel extends Cubit<Categorystate>{
  late CategoryRepoContract repository ;
  late CategoryDataSource dataSource;
  late ApiManager apiManager ;
  CategoryDetailsVeiwmodel():super(LoadingCategoryState()){
    apiManager=ApiManager();
    dataSource=CategoryDataSourceImpl(apiManager: apiManager);
    repository=CategoryRepositoryImpl(remote:dataSource );


  }
void getCategory(String appLanguage)async{
  try {
    var response = await repository.getCategory(appLanguage);
    if(response!.genres!.isEmpty){
      emit(ErrorCategoryState(ErrorMessage: "error List is empty "));

    }
    else{
      var list= Category.getCategory();
      for(int i=0;i<response.genres!.length;i++){
     list[i].id=response.genres![i].id!;
     list[i].name=response.genres![i].name!;
     print(list[i].id);
     print(list[i].name);
      }
      emit(SuccessCategoryState(categoryList: list));
    }

  }
  catch (e){
emit(ErrorCategoryState(ErrorMessage: e.toString()));
  }


}






}