import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/browse/Api/Api_Manager.dart';
import 'package:movie/pages/browse/Category/Cubit/CategoryState.dart';
import 'package:movie/pages/browse/CategoryPhoto.dart';


class CategoryDetailsVeiwmodel extends Cubit<Categorystate>{
  CategoryDetailsVeiwmodel():super(LoadingCategoryState());
void getCategory()async{
  try {
    var response = await ApiManager.getCategory();
    if(response.genres!.isEmpty){
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