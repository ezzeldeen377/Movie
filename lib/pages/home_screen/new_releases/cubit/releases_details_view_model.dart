import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/new_releases/cubit/releases_state.dart';

import '../../api/api_manager.dart';

class ReleasesDetailsViewModel extends Cubit<ReleasesState> {
  ReleasesDetailsViewModel() : super(ReleasesLoadingState());
   int pageNumber=1;
   List<Movie> list=[];
  void getReleases({bool fromPagination=false}) async {
    if(fromPagination){
      emit(ReleasesPaginationState());
    }else{
      emit(ReleasesLoadingState());

    }
    try {
      var response = await ApiManager.getNewReleases(pageNumber);
      if (response!.results!.isEmpty) {
        emit(ReleasesErrorState(errorMessage: 'Empty data'));
      } else {
        if(response.results!.isNotEmpty) {
          pageNumber++;
          list.addAll(response.results ?? []);
        }
        emit(ReleasesSuccessState(releasesList: list));
        print(response.totalPages);
      }
    } catch (e) {
      throw e;
    }
  }
}
