import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/more_like_this/cubit/more_like_this_state.dart';
import 'package:movie/pages/home_screen/repository/more_like/data_source/more_like_remote_data_source_impl.dart';
import 'package:movie/pages/home_screen/repository/more_like/more_like_data_source.dart';
import 'package:movie/pages/home_screen/repository/more_like/more_like_repository.dart';
import 'package:movie/pages/home_screen/repository/more_like/repository/more_like_repository_impl.dart';

class MoreLikeThisViewModel extends Cubit<MoreLikeState> {
  late MoreLikeRepository moreLikeRepository;
  late MoreLikeRemoteDataSource remoteDataSource;

  MoreLikeThisViewModel() : super(MoreLikeThisLoadingState()) {
    remoteDataSource = MoreLikeRemoteDataSourceImpl();
    moreLikeRepository =
        MoreLikeRepositoryImpl(remoteDataSource: remoteDataSource);
  }
  int pageNumber=1;
  List<Movie> list=[];

  void getMoreLike(String id,String appLanguage,{bool fromPagination=false}) async {
    if(fromPagination){
      emit(MoreLikeThisPaginationState());
    }else{
      emit(MoreLikeThisLoadingState());
    }
    try {
      var response = await moreLikeRepository.getMoreLike(id, pageNumber,appLanguage);

      if (response == null ||
          response.results == null ||
          response.results!.isEmpty) {
        emit(MoreLikeThisErrorState(errorMessage: 'Empty data'));
      } else {
        if(response.results!.isNotEmpty){
          pageNumber++;
          list.addAll(response.results??[]);
        }
        emit(MoreLikeThisSuccessState(moreLike: list));
      }
    } catch (e) {
      emit(MoreLikeThisErrorState(errorMessage: e.toString()));
    }
  }
}
