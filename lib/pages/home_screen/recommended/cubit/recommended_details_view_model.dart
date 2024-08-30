import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/recommended/cubit/recommended_state.dart';
import 'package:movie/pages/home_screen/repository/recommended/data_source/recommended_remote_data_source_impl.dart';
import 'package:movie/pages/home_screen/repository/recommended/recommended_data_source.dart';
import 'package:movie/pages/home_screen/repository/recommended/recommended_repository.dart';
import 'package:movie/pages/home_screen/repository/recommended/repository/recommended_repository_impl.dart';

class RecommendedDetailsViewModel extends Cubit<RecommendedState> {
  late RecommendedRepository recommendedRepository;

  late RecommendedRemoteDataSource remoteDataSource;

  RecommendedDetailsViewModel() : super(RecommendedLoadingState()) {
    remoteDataSource = RecommendedRemoteDataSourceImpl();
    recommendedRepository =
        RecommendedRepositoryImpl(remoteDataSource: remoteDataSource);
  }
  int pageNumber=1;
  List<Movie> list=[];

  void getRecommended(String appLanguage,{bool fromPagination=false}) async {
    if(fromPagination){
      emit(RecommendedPaginationState());
    }else{
      emit(RecommendedLoadingState());
    }
    try {
      var response = await recommendedRepository.getNewRecommended(pageNumber,appLanguage);
      if (response!.results!.isEmpty) {
        emit(RecommendedErrorState(errorMessage: 'Empty data'));
      } else {
        if(response.results!.isNotEmpty){
          pageNumber++;
          list.addAll(response.results!);
        }
        emit(RecommendedSuccessState(recommendedList:list));
      }
    } catch (e) {
      throw e;
    }
  }
}
