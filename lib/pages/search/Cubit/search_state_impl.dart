import 'package:movie/pages/search/model/SourcesMovie.dart';
import 'search_state.dart';

class SearchStateImpl implements SearchState {
  @override
  final List<Results> results;
  @override
  final bool isLoading;
  @override
  final bool hasError;

  SearchStateImpl({
    this.results = const [],
    this.isLoading = false,
    this.hasError = false,
  });
}
