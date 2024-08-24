import 'package:flutter_bloc/flutter_bloc.dart';


import '../../Api/Api_Manager.dart';
import 'MovieState.dart';

class MovieDetailsVeiwmodel extends Cubit<Moviestate>{
  MovieDetailsVeiwmodel():super(LoadingMovieState());
  void getMoives(int id )async {
    try {
      var response = await ApiManager.getMoives(id);
      if (response!.results!.isEmpty) {
        emit(ErrorMovieState(errorMessage: "error List is empty "));
      }
      else {
        emit(SuccessMovieState(movieList: response.results!));
      }
    }
    catch (e) {
      emit(ErrorMovieState(errorMessage: e.toString()));
    }
  }
  }