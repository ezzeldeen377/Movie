import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/features/browse/data/repositories/browse_repository.dart';
import 'package:movie/features/browse/presentation/bloc/browse_state.dart';
import 'package:movie/features/browse/presentation/widgets/category_photo.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';


@injectable
class BrowseViewModel extends Cubit<BrowseState>{
 BrowseRepository repository;
  BrowseViewModel({required this.repository}):super(BrowseState(status: BrowseStatus.initial));
void getCategory(String appLanguage)async{
  emit(state.copyWith(status: BrowseStatus.loading));
    final response = await repository.getCategory(appLanguage);
    response.fold((error)=> emit(state.copyWith(status: BrowseStatus.error,errorMessage: error)),(r){
       var list= Category.getCategory();
      for(int i=0;i<r!.genres!.length;i++){
     list[i].id=r.genres![i].id!;
     list[i].name=r.genres![i].name!;
      }
      emit(state.copyWith(status: BrowseStatus.loaded,categories: list));
    });

    }

int pageNumber=1;
List<Movie> list=[];

  void getMoives(int id,String appLanguage,{bool fromPagination=false} )async {
    if(fromPagination){
      emit(state.copyWith(status: BrowseStatus.paginationLoading));
    }else{
      list=[];
      emit(state.copyWith(status: BrowseStatus.loading,));
    }
  
      var response = await repository.getMovies(id,pageNumber,appLanguage);

      response.fold((error)=> emit(state.copyWith(status: BrowseStatus.error,errorMessage: error)), (r) {
        if(r!.results!.isEmpty){
          emit(state.copyWith(status: BrowseStatus.error, errorMessage: "finish fetch data"));
        }else{
          pageNumber++;
          list.addAll(r.results!);

        }
        emit(state.copyWith(status: BrowseStatus.loaded,movies: list));  
      });
      
 
  }
  


}






