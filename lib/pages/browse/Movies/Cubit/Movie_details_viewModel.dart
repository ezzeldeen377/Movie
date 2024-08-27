import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/browse/Models/MovieResponse.dart';


import '../../Api/Api_Manager.dart';
import 'MovieState.dart';

class MovieDetailsVeiwmodel extends Cubit<Moviestate>{
  MovieDetailsVeiwmodel():super(LoadingMovieState());
  int pageNumber=1;
  List<Movie> list=[];

  void getMoives(int id,{bool fromPagination=false} )async {
    if(fromPagination){
      emit(PaginationMovieState());
    }else{
      emit(LoadingMovieState());
    }
    try {
      var response = await ApiManager.getMoives(id,pageNumber);
      if (response!.results!.isEmpty) {
        emit(ErrorMovieState(errorMessage: "error List is empty "));
      }
      else {
        if(response.results!.isNotEmpty){
          pageNumber++;
          list.addAll(response.results??[]);
        }
        emit(SuccessMovieState(movieList: list));
      }
    }
    catch (e) {
      emit(ErrorMovieState(errorMessage: e.toString()));
    }
  }
  }