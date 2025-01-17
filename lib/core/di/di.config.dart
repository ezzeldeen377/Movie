// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/browse/data/datasources/browse_remote_data_source.dart'
    as _i887;
import '../../features/browse/data/repositories/browse_repository.dart'
    as _i633;
import '../../features/browse/presentation/bloc/browse_view_model.dart'
    as _i867;
import '../../features/home_screen/data/datasources/home_screen_remote_data_source.dart'
    as _i509;
import '../../features/home_screen/data/repositories/home_screen_repository.dart'
    as _i661;
import '../../features/home_screen/presentation/bloc/home_screen/home_screen_view_model.dart'
    as _i524;
import '../../features/home_screen/presentation/bloc/movie_details/movie_details_view_model.dart'
    as _i853;
import '../../features/search/data/datasources/search_Remote_data_source.dart'
    as _i1053;
import '../../features/search/data/repositories/search_repository.dart'
    as _i708;
import '../../features/search/presentation/bloc/search_view_model.dart'
    as _i1002;
import '../../features/watch_list/data/datasources/watch_list_data_source.dart'
    as _i686;
import '../../features/watch_list/data/repositories/watch_list_repository.dart'
    as _i415;
import '../../features/watch_list/presentation/bloc/watch_list_view_model.dart'
    as _i890;
import '../api/api_manager.dart' as _i1047;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.factory<_i686.WatchListDataSource>(
        () => _i686.WatchListDataSourceImpl());
    gh.factory<_i1053.SearchRemoteDataSource>(
        () => _i1053.SearchRemoteDataSourceImpl());
    gh.factory<_i509.HomeScreenRemoteDataSource>(
        () => _i509.HomeScreenRemoteDataSourceImpl());
    gh.factory<_i708.SearchRepository>(() => _i708.SearchRepositoryImpl(
        remoteDataSource: gh<_i1053.SearchRemoteDataSource>()));
    gh.factory<_i1002.SearchViewModel>(
        () => _i1002.SearchViewModel(repository: gh<_i708.SearchRepository>()));
    gh.factory<_i415.WatchListRepository>(() => _i415.WatchListRepositoryImpl(
        dataSource: gh<_i686.WatchListDataSource>()));
    gh.factory<_i661.HomeScreenRepository>(() =>
        _i661.HomeScreenRepositoryImpl(gh<_i509.HomeScreenRemoteDataSource>()));
    gh.factory<_i887.BrowseRemoteDataSource>(() =>
        _i887.BrowseRemoteDataSourceImpl(apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i524.HomeScreenViewModel>(() => _i524.HomeScreenViewModel(
        repository: gh<_i661.HomeScreenRepository>()));
    gh.factory<_i853.MovieDetailsViewModel>(() => _i853.MovieDetailsViewModel(
        repository: gh<_i661.HomeScreenRepository>()));
    gh.factory<_i890.WatchListViewModel>(() =>
        _i890.WatchListViewModel(repository: gh<_i415.WatchListRepository>()));
    gh.factory<_i633.BrowseRepository>(() =>
        _i633.BrowseRepositoryImpl(remote: gh<_i887.BrowseRemoteDataSource>()));
    gh.factory<_i867.BrowseViewModel>(
        () => _i867.BrowseViewModel(repository: gh<_i633.BrowseRepository>()));
    return this;
  }
}
