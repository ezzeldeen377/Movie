import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/search/Cubit/search_View_Model.dart';
import 'package:movie/pages/search/Cubit/search_state.dart';
import 'package:movie/pages/search/Repositroy/data_Source/movie_Remote_data_source_impl.dart';
import 'package:movie/pages/search/Repositroy/repository/movie_repository_impl.dart';
import 'package:movie/pages/search/SearchView/ResultItem.dart';
import 'package:movie/pages/search/SearchView/SearchField.dart';


class Search extends StatelessWidget {
  SearchViewModel viewModel = SearchViewModel();
  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(
              searchController: _searchController,
              onChanged: (query) {
                viewModel.search(query);
              },
              onPreesd: () {
                _searchController.clear();
                viewModel.clear();
              },
            ),
            BlocBuilder<SearchViewModel, SearchState>(
              bloc: viewModel ,
              builder: (context, state) {
                if (state is SearchLoaded) {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        thickness: 3,
                        color: AppColors.darkGrayColor,
                        endIndent: MediaQuery.of(context).size.width * 0.1,
                        indent: MediaQuery.of(context).size.width * 0.1,
                      ),
                      itemCount: state.movieResult.length,
                      itemBuilder: (context, index) {
                        return ResultItem(movie: state.movieResult[index]);
                      },
                    ),
                  );
                } else if (state is SearchLoadingState) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.whiteColor,
                      size: 50,
                    ),
                  );
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
