import '../../model/popular_response.dart';

abstract class PopularState {}

class PopularLoadingState extends PopularState {}

class PopularErrorState extends PopularState {
  String errorMessage;

  PopularErrorState({required this.errorMessage});
}

class PopularSuccessState extends PopularState {
  List<Popular> popularList;

  PopularSuccessState({required this.popularList});
}
