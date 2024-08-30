import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/browse/Repo/Movie/Repository/Movie_repo_impl.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';


import '../../Api/Api_Manager.dart';
import '../../Repo/Movie/Data_Source/Movie_remote_data_source.dart';
import '../../Repo/Movie/Movie_data_Source.dart';
import '../../Repo/Movie/Movie_repository_Contract.dart';
import 'MovieState.dart';

class MovieDetailsVeiwmodel extends Cubit<Moviestate>{
  late MovieRepositoryContract movie;
  late Online movieSource;
  late ApiManager apiManager;
  MovieDetailsVeiwmodel():super(LoadingMovieState()){
    apiManager=ApiManager();
    movieSource=MovieRemoteDataSourceImpl(apiManager: apiManager);
   movie=MovieRepoImpl(remote:movieSource );



  }
  int pageNumber=1;
  List<Movie> list=[];

  void getMoives(int id,String appLanguage,{bool fromPagination=false} )async {
    if(fromPagination){
      emit(PaginationMovieState());
    }else{
      emit(LoadingMovieState());
    }
    try {
      var response = await movie.getMovies(id,pageNumber,appLanguage);
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