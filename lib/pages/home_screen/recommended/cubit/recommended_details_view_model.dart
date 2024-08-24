import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/recommended/cubit/recommended_state.dart';

class RecommendedDetailsViewModel extends Cubit<RecommendedState> {
  RecommendedDetailsViewModel() : super(RecommendedLoadingState());

  void getRecommended() async {
    try {
      emit(RecommendedLoadingState());
      var response = await ApiManager.getRecommended();
      if (response!.results!.isEmpty) {
        emit(RecommendedErrorState(errorMessage: 'Empty data'));
      } else {
        emit(RecommendedSuccessState(recommendedList: response.results!));
        print(response.totalPages);
      }
    } catch (e) {
      throw e;
    }
  }
}
