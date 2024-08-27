import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../app_colors.dart';
import 'Movie_details_widget.dart';
import 'cubit/movie_details_state.dart';
import 'cubit/movie_details_view_model.dart';

class MovieDetailsView extends StatefulWidget {
  final String movieId;

  MovieDetailsView({required this.movieId});

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  MovieDetailsViewModel viewModel = MovieDetailsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
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
