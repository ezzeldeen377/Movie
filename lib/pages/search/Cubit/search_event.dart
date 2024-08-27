import 'search_state.dart';

class SearchQueryChanged implements SearchEvent {
  final String query;

  SearchQueryChanged(this.query);
}
