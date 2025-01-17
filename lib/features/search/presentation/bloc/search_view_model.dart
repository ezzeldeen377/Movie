import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/features/search/data/repositories/search_repository.dart';
import 'package:movie/features/search/presentation/bloc/search_state.dart';

@injectable
class SearchViewModel extends Cubit<SearchState> {
  final SearchRepository repository;
   
  SearchViewModel({required this.repository})
      : super(SearchState(
            status: SearchStatus.initial,
            errorMessage: 'Search On Any Movie You want'));

  void search(String query, String appLanguage) async {
    emit(state.copyWith(status: SearchStatus.loading));

    final result = await repository.searchMovies(query, appLanguage);
    result.fold(
        (error) => emit(
            state.copyWith(errorMessage: error, status: SearchStatus.error)),
        (result) =>
            emit(state.copyWith(movieResult: result?.results??[], status: SearchStatus.loaded)));
  }

  void clear() {
    emit( state.copyWith(status: SearchStatus.initial,
            errorMessage: 'Search On Any Movie You want'));
  }
 
}
