import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/browse/Api/Api_Manager.dart';
import 'package:movie/pages/browse/Category/Cubit/CategoryState.dart';


class CategoryDetailsVeiwmodel extends Cubit<Categorystate>{
  CategoryDetailsVeiwmodel():super(LoadingCategoryState());
void getCategory()async{
  try {
    var response = await ApiManager.getCategory();
    if(response.genres!.isEmpty){
      emit(ErrorCategoryState(ErrorMessage: "error List is empty "));

    }
    else{
      emit(SuccessCategoryState(categoryList:response.genres! ));
    }
  }
  catch (e){
emit(ErrorCategoryState(ErrorMessage: e.toString()));
  }


}






}