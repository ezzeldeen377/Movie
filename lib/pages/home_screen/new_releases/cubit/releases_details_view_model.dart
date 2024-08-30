import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/new_releases/cubit/releases_state.dart';
import 'package:movie/pages/home_screen/repository/new_releases/data_source/releases_remote_data_source_impl.dart';
import 'package:movie/pages/home_screen/repository/new_releases/relases_repository.dart';
import 'package:movie/pages/home_screen/repository/new_releases/releases_data_source.dart';
import 'package:movie/pages/home_screen/repository/new_releases/repository/releases_repository_impl.dart';

class ReleasesDetailsViewModel extends Cubit<ReleasesState> {
  late ReleasesRepository releasesRepository;
  late ReleasesRemoteDataSource remoteDataSource;

  ReleasesDetailsViewModel() : super(ReleasesLoadingState()) {
    remoteDataSource = ReleasesRemoteDataSourceImpl();
    releasesRepository =
        ReleasesRepositoryImpl(remoteDataSource: remoteDataSource);
  }
  int pageNumber=1;
   List<Movie> list=[];
  void getReleases(String appLanguage,{bool fromPagination=false}) async {
    if(fromPagination){
      emit(ReleasesPaginationState());
    }else{
      emit(ReleasesLoadingState());

    }
    try {
      var response = await releasesRepository.getNewReleases(pageNumber,appLanguage);
      if (response!.results!.isEmpty) {
        emit(ReleasesErrorState(errorMessage: 'Empty data'));
      } else {
        if(response.results!.isNotEmpty) {
          pageNumber++;
          list.addAll(response.results ?? []);
        }
        emit(ReleasesSuccessState(releasesList: list));
        print(response.results![1].title);
      }
    } catch (e) {
      throw e;
    }
  }
}
