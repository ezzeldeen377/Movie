import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/more_like_this/cubit/more_like_this_state.dart';

class MoreLikeThisViewModel extends Cubit<MoreLikeState> {
  MoreLikeThisViewModel() : super(MoreLikeLoadingState());

  void getMoreLike(String id) async {
    try {
      emit(MoreLikeLoadingState());

      var response = await ApiManager.getMoreLikeThis(id);

      if (response == null ||
          response.results == null ||
          response.results!.isEmpty) {
        emit(MoreLikeErrorState(errorMessage: 'Empty data'));
      } else {
        emit(MoreLikeStateSuccessState(moreLike: response.results!.toList()));
      }
    } catch (e) {
      emit(MoreLikeErrorState(errorMessage: e.toString()));
    }
  }
}
