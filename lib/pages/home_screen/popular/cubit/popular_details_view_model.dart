import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/popular/cubit/popular_state.dart';

class PopularDetailsViewModel extends Cubit<PopularState> {
  PopularDetailsViewModel() : super(PopularLoadingState());

  void getPopular() async {
    try {
      emit(PopularLoadingState());
      var response = await ApiManager.getPopular();
      if (response!.results!.isEmpty) {
        emit(PopularErrorState(errorMessage: 'Empty data'));
      } else {
        emit(PopularSuccessState(popularList: response.results!));
        print(response.totalPages);
      }
    } catch (e) {
      throw e;
    }
  }
}
