import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/popular/cubit/popular_state.dart';
import 'package:movie/pages/home_screen/repository/popular/data_source/popular_remote_data_source_impl.dart';
import 'package:movie/pages/home_screen/repository/popular/popular_data_source.dart';
import 'package:movie/pages/home_screen/repository/popular/popular_repository.dart';
import 'package:movie/pages/home_screen/repository/popular/repository/popular_repository_impl.dart';

class PopularDetailsViewModel extends Cubit<PopularState> {
  late PopularRepository popularRepository;
  late PopularRemoteDataSource remoteDataSource;

  PopularDetailsViewModel() : super(PopularLoadingState()) {
    remoteDataSource = PopularRemoteDataSourceImpl();
    popularRepository =
        PopularRepositoryImpl(remoteDataSource: remoteDataSource);
  }

  void getPopular(String appLanguage) async {
    try {
      emit(PopularLoadingState());
      var response = await popularRepository.getPopular(appLanguage);
      if (response!.results!.isEmpty) {
        emit(PopularErrorState(errorMessage: 'Empty data'));
      } else {
        emit(PopularSuccessState(popularList: response.results!));
        print(response.totalPages);
      }
    } catch (e) {
      emit(PopularErrorState(errorMessage: e.toString()));
    }
  }
}
