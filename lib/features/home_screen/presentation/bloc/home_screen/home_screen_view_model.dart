import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';
import 'package:movie/features/home_screen/data/repositories/home_screen_repository.dart';
import 'package:movie/features/home_screen/presentation/bloc/home_screen/home_screen_state.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenState> {
  HomeScreenRepository repository;
  HomeScreenViewModel({required this.repository})
      : super(HomeScreenState(status: HomeScreenStatus.loading));
int newReleasesPage=1;
int recommendedPage=1;
List<Movie> newReleasesList=[];
List<Movie> recommendedList=[];
  Future<void> getNewReleases( String appLanguage, {required bool fromPagination}) async {
     if(fromPagination){
      emit(state.copyWith(status: HomeScreenStatus.newReleasesPagination));
    }else{
      emit(state.copyWith(status: HomeScreenStatus.loading,));

    }
    final result = await repository.getNewReleases(newReleasesPage, appLanguage);
    result.fold((l) {
      emit(state.copyWith(status: HomeScreenStatus.error, errorMessage: l));
    }, (r) {
      if(r!.results!.isNotEmpty) {
          newReleasesPage++;
          newReleasesList.addAll(r.results ??[]);
        }
      emit(state.copyWith(
        
        status: HomeScreenStatus.newReleasesLoaded,
        newReleasesMovies: newReleasesList,
      ));
    });
  }

  Future<void> getRecommended( String appLanguage,{required bool fromPagination}) async {
     if(fromPagination){
      emit(state.copyWith(status: HomeScreenStatus.recommendedPagination));
    }else{
      emit(state.copyWith(status: HomeScreenStatus.loading,));

    }
    final result = await repository.getNewRecommended(recommendedPage, appLanguage);
    result.fold((l) {
      emit(state.copyWith(status: HomeScreenStatus.error, errorMessage: l));
    }, (r) {
        if(r!.results!.isNotEmpty) {
          recommendedPage++;
          recommendedList.addAll(r.results ??[]);
        }
      emit(state.copyWith(
        status: HomeScreenStatus.recommendedLoaded,
        recommendedMovies:recommendedList,
      ));
    });
  }

  Future<void> getPopular(String appLanguage) async {
    final result = await repository.getPopular(appLanguage);
    result.fold((l) {
      emit(state.copyWith(status: HomeScreenStatus.error, errorMessage: l));
    }, (r) {
      emit(state.copyWith(
        status: HomeScreenStatus.popularLoaded,
        popularMovies: r?.results ?? [],
      ));
  });
  
}
}