import 'package:movie/pages/home_screen/model/NewsReleases.dart';

abstract class ReleasesState {}

class ReleasesLoadingState extends ReleasesState {}

class ReleasesErrorState extends ReleasesState {
  String errorMessage;

  ReleasesErrorState({required this.errorMessage});
}

class ReleasesSuccessState extends ReleasesState {
  List<Releases> releasesList;

  ReleasesSuccessState({required this.releasesList});
}
