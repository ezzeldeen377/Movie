import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/new_releases/cubit/releases_state.dart';

import '../../api/api_manager.dart';

class ReleasesDetailsViewModel extends Cubit<ReleasesState> {
  ReleasesDetailsViewModel() : super(ReleasesLoadingState());

  void getReleases() async {
    try {
      emit(ReleasesLoadingState());
      var response = await ApiManager.getNewsReleases();
      if (response!.results!.isEmpty) {
        emit(ReleasesErrorState(errorMessage: 'Empty data'));
      } else {
        emit(ReleasesSuccessState(releasesList: response.results!));
        print(response.totalPages);
      }
    } catch (e) {
      throw e;
    }
  }
}
