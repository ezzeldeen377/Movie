import '../../model/movie_response.dart';

abstract class MoreLikeState {}

class MoreLikeLoadingState extends MoreLikeState {}

class MoreLikeErrorState extends MoreLikeState {
  String errorMessage;

  MoreLikeErrorState({required this.errorMessage});
}

class MoreLikeStateSuccessState extends MoreLikeState {
  List<Movie> moreLike;

  MoreLikeStateSuccessState({required this.moreLike});
}
