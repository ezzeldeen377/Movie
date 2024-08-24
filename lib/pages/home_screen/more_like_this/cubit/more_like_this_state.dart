import '../../model/NewsReleases.dart';

abstract class MoreLikeState {}

class MoreLikeLoadingState extends MoreLikeState {}

class MoreLikeErrorState extends MoreLikeState {
  String errorMessage;

  MoreLikeErrorState({required this.errorMessage});
}

class MoreLikeStateSuccessState extends MoreLikeState {
  List<Releases> moreLike;

  MoreLikeStateSuccessState({required this.moreLike});
}
