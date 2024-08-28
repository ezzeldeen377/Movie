import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/movie_details/Movie_details_widget.dart';
import 'package:movie/pages/home_screen/movie_details/cubit/movie_details_view_model.dart';
import 'package:movie/pages/search/Cubit/search_View_Model.dart';
import 'package:movie/pages/search/Cubit/search_state.dart';
import 'package:movie/pages/search/SearchView/ResultItem.dart';
import 'package:movie/pages/search/SearchView/SearchField.dart';
import 'package:movie/pages/search/SearchView/SearchStateDisplay.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  SearchViewModel viewModel =SearchViewModel();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(
              searchController: _searchController,
              onChanged: (query) {
                viewModel.search(query);
              },
            ),
            // BlocBuilder<SearchViewModel, SearchState>(
            //   builder: (context, state) {
            //     return SearchStateDisplay(
            //       state: state,
            //       searchController: _searchController,
            //       onRetry: () {
            //         context.read<SearchViewModel>().search(_searchController.text);
            //       },
            //     );
            //   },
            // ),
            BlocBuilder<SearchViewModel, SearchState>(
              bloc: viewModel,
              builder: (context, state) {
                if (state is SearchLoaded) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.movieResult.length,
                        itemBuilder:(context,index) {
                          return FutureBuilder<MovieDetails>(
                            future: viewModel.getMovieDetails(state.movieResult[index].id.toString()),
                            builder: (context, snapshot) {

                               if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                return ResultItem(movieDetails: snapshot.data!);
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          );
                        }
                    ),
                  );
                } else if (state is SearchLoadingState) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: AppColors.yellowColor));
                } else if (state is SearchError) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage('assets/icons/icon_background.png'),
                            color: AppColors.whiteColor,
                            size: MediaQuery.of(context).size.height * 0.08,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text(
                            state.message,
                            style: TextStyle(color: AppColors.whiteColor),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
