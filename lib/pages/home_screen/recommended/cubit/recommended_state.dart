import '../../model/recommended_response.dart';

abstract class RecommendedState {}

class RecommendedLoadingState extends RecommendedState {}

class RecommendedErrorState extends RecommendedState {
  String errorMessage;

  RecommendedErrorState({required this.errorMessage});
}

class RecommendedSuccessState extends RecommendedState {
  List<Recommended> recommendedList;

  RecommendedSuccessState({required this.recommendedList});
}
