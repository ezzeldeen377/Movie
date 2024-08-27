import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/pages/home_screen/new_releases/cubit/releases_details_view_model.dart';
import 'package:movie/pages/home_screen/new_releases/cubit/releases_state.dart';

import '../../../app_colors.dart';
import '../model/movie_response.dart';
import 'movie_item.dart';
import 'movie_list_header.dart';

class MovieListWidget extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final Color backgroundColor;

  MovieListWidget({
    required this.title,
    required this.movies,
    this.backgroundColor = Colors.red,
  });
  ReleasesDetailsViewModel viewModel=ReleasesDetailsViewModel();


  @override
  Widget build(BuildContext context) {
    viewModel.getReleases();
    return BlocBuilder<ReleasesDetailsViewModel,ReleasesState>(
      bloc: viewModel,
      builder: (context,state){
        if(state is ReleasesSuccessState){
          return  Container(
            color: backgroundColor,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieListHeader(title: title),
                SizedBox(height: 8),
                Flexible(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification){

                      if(notification.metrics.pixels==notification.metrics.maxScrollExtent&&notification is ScrollUpdateNotification){
                        print("loading");
                        viewModel.getReleases();


                      }
                      return true ;
                    },
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return MovieItem(movie: state.releasesList[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }else if(state is ReleasesLoadingState){
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.whiteColor,
              size: 50,
            ),
          );
        }else if (state is ReleasesErrorState){
          return  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Something went wrong: ${state.errorMessage}',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Try Again'),
                ),
              ],
            ),
          );
        }
        return Text("error",style: TextStyle(color: AppColors.whiteColor),);

      },

    );
  }
}
