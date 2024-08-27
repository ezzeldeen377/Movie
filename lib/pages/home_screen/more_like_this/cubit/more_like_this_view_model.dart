import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/more_like_this/cubit/more_like_this_state.dart';

class MoreLikeThisViewModel extends Cubit<MoreLikeState> {
  MoreLikeThisViewModel() : super(MoreLikeThisLoadingState());
  int pageNumber=1;
  List<Movie> list=[];

  void getMoreLike(String id,{bool fromPagination=false}) async {
    if(fromPagination){
      emit(MoreLikeThisPaginationState());
    }else{
      emit(MoreLikeThisLoadingState());
    }
    try {

      var response = await ApiManager.getMoreLikeThis(id,pageNumber);

      if (response == null ||
          response.results == null ||
          response.results!.isEmpty) {
        emit(MoreLikeThisErrorState(errorMessage: 'Empty data'));
      } else {
        if(response.results!.isNotEmpty){
          pageNumber++;
          list.addAll(response.results??[]);
        }
        emit(MoreLikeThisSuccessState(moreLike: list));
      }
    } catch (e) {
      emit(MoreLikeThisErrorState(errorMessage: e.toString()));
    }
  }
}
