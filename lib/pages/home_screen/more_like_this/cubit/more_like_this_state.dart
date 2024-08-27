import '../../model/movie_response.dart';

abstract class MoreLikeState {}

class MoreLikeThisLoadingState extends MoreLikeState {}

class MoreLikeThisErrorState extends MoreLikeState {
  String errorMessage;

  MoreLikeThisErrorState({required this.errorMessage});
}

class MoreLikeThisSuccessState extends MoreLikeState {
  List<Movie> moreLike;

  MoreLikeThisSuccessState({required this.moreLike});
}
class MoreLikeThisPaginationState extends MoreLikeState{}
