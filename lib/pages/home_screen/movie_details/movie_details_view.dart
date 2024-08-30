
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/app_provider/app_provider.dart';
import 'package:movie/pages/home_screen/movie_details/Movie_details_widget.dart';
import 'package:movie/pages/home_screen/movie_details/cubit/movie_details_state.dart';
import 'package:movie/pages/home_screen/movie_details/cubit/movie_details_view_model.dart';
import 'package:provider/provider.dart';

class MovieDetailsView extends StatelessWidget {
  final String movieId;

  MovieDetailsView({required this.movieId});

  MovieDetailsViewModel viewModel = MovieDetailsViewModel();

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<AppProvider>(context);
    AppProvider provider=AppProvider(appLanguage:pro.appLanguage);
    viewModel.getMovieDetail(movieId, provider.appLanguage);
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<MovieDetailsViewModel, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoadingState) {
              return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.whiteColor,
              size: 50,
            ),
              );
            } else if (state is MovieDetailsErrorState) {
              return Center(
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
            } else if (state is MovieDetailsSuccessState) {
              return MovieDetailsWidget(movie: state.movieDetail);
            }
            return Text('noooooooo');
          }),
    );
  }
}
