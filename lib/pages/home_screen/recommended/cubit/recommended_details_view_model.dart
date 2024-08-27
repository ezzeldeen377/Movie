import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/recommended/cubit/recommended_state.dart';

class RecommendedDetailsViewModel extends Cubit<RecommendedState> {
  RecommendedDetailsViewModel() : super(RecommendedLoadingState());
  int pageNumber=1;
  List<Movie> list=[];

  void getRecommended({bool fromPagination=false}) async {
    if(fromPagination){
      emit(RecommendedPaginationState());
    }else{
      emit(RecommendedLoadingState());
    }
    try {
      var response = await ApiManager.getRecommended(pageNumber);
      if (response!.results!.isEmpty) {
        emit(RecommendedErrorState(errorMessage: 'Empty data'));
      } else {
        if(response.results!.isNotEmpty){
          pageNumber++;
          list.addAll(response.results!);
        }
        emit(RecommendedSuccessState(recommendedList:list));
      }
    } catch (e) {
      throw e;
    }
  }
}
