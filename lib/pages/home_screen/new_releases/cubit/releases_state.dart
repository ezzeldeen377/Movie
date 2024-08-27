import 'package:movie/pages/home_screen/model/movie_response.dart';

abstract class ReleasesState {}

class ReleasesLoadingState extends ReleasesState {}

class ReleasesErrorState extends ReleasesState {
  String errorMessage;

  ReleasesErrorState({required this.errorMessage});
}

class ReleasesSuccessState extends ReleasesState {
  List<Movie> releasesList;

  ReleasesSuccessState({required this.releasesList});
}
class ReleasesPaginationState extends ReleasesState{

}
