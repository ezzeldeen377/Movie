import 'package:flutter/cupertino.dart';
import 'package:movie/pages/browse/Repo/Movie/Repository/Movie_data_Source.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';

import 'Movie_repository_Contract.dart';

class MovieRepoImpl implements MovieRepositoryContract{
  Online remote ;
  MovieRepoImpl({ required this.remote});
  @override
  Future<MovieResponse?> getMovies(int id, int pageNumber) {
return remote.getMovies(id, pageNumber);
  }








}