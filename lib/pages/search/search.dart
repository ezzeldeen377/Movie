import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/movie_details/Movie_details_widget.dart';
import 'package:movie/pages/search/Cubit/search_cubit.dart';
import 'package:movie/pages/search/MovieList.dart';
import 'package:movie/pages/search/SearchField.dart';
import 'package:movie/pages/search/SearchStateDisplay.dart';


class Search extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0), // تعديل الهوامش
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(
              searchController: _searchController,
              onChanged: (query) {
                context.read<SearchCubit>().search(query);
              },
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return SearchStateDisplay(
                  state: state,
                  searchController: _searchController,
                  onRetry: () {
                    context.read<SearchCubit>().search(_searchController.text);
                  },
                );
              },
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (!state.isLoading && !state.hasError && state.results.isNotEmpty) {
                  return MovieList(
                    movies: state.results,
                    searchController: _searchController,
                  );
                }
                return SizedBox.shrink(); // عنصر فارغ كبديل لقائمة الأفلام
              },
            ),
          ],
        ),
      ),
    );
  }
}
